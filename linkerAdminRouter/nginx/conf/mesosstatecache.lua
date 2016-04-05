local shmlock = require "resty.lock"
local http = require "resty.http.simple"


local _M = {}


local POLL_PERIOD_SECONDS = 25
local CACHE_EXPIRATION_SECONDS = 20


local function cache_data(key, value)
    -- Store key/value pair to SHM cache (shared across workers).
    -- Return true upon success, false otherwise.
    -- Expected to run within lock context.

    local cache = ngx.shared.mesos_state_cache
    local success, err, forcible = cache:set(key, value)
    if success then
        return true
    end        
    ngx.log(
        ngx.ERR,
        "Could not store " .. key .. " to state cache: " .. err
        )
    return false
end


local function fetch_and_cache_state()
    -- Fetch state JSON from Mesos. If successful, store to SHM cache.
    -- Expected to run within lock context.

    -- Use cosocket-based HTTP library, as ngx subrequests are not available
    -- from within this code path (decoupled from nginx' request processing).
    -- The timeout parameter is given in milliseconds.
    local res, err = http.request(
        "leader.mesos",
        5050,
        {
            path = "/master/state-summary",
            timeout = 10000,
        }
    )

    if not res then
        ngx.log(ngx.ERR, "Mesos state request failed: " .. err)
        return
    end

    if res.status ~= 200 then
        ngx.log(ngx.ERR, "Mesos state response status: " .. res.status)
        return
    end

    ngx.log(
        ngx.NOTICE,
        "Mesos state response retrieved. Body length: " .. 
        string.len(res.body)
        )

    -- Store new data in cache, together with current time.
    ngx.update_time()
    local time_fetched = ngx.now()
    ngx.log(ngx.NOTICE, "Storing Mesos state to SHM.")
    local success = cache_data("statejson", res.body)
    if success then
        cache_data("last_fetch_time", time_fetched)
    end
end        


local function refresh_mesos_state_cache()
    -- Refresh state cache if not yet existing or if expired.
    -- Obtain cross-worker lock before performing operations.
    -- This function is usually run periodically, in all worker
    -- processes, spawned via ngx.timer (in a coroutine).

    -- Acquire lock. Fail immediately if another worker
    -- currently holds the lock.
    local lock = shmlock:new("shmlocks", { timeout=0 })
    local elapsed, err = lock:lock("mesos-state")
    if not elapsed then
        ngx.log(
            ngx.DEBUG,
            "Did not acquire mesos-state shmlock: " .. err
            )
        return
    end

    local cache = ngx.shared.mesos_state_cache
    
    -- Handle special case of first invocation.
    local fetchtime = cache:get("last_fetch_time")
    if not fetchtime then
        ngx.log(ngx.NOTICE, "Mesos state cache empty. Fetch.")
        fetch_and_cache_state()
    else
        ngx.update_time()
        local diff = ngx.now() - fetchtime
        if diff > CACHE_EXPIRATION_SECONDS then
            ngx.log(ngx.NOTICE, "Mesos state cache expired. Refresh.")
            fetch_and_cache_state()
        else
            ngx.log(ngx.DEBUG, "Mesos state cache not expired.")
        end
    end
  
    local ok, err = lock:unlock()
    if not ok then
        -- If this fails, an unlock happens automatically,
        -- by default after 30 seconds, to prevent deadlock.
        ngx.log(
            ngx.ERR,
            "Failed to unlock mesos-state shmlock: " .. err
            )
    end
end


function _M.periodically_poll_mesos_state()
    -- This function is invoked from within init_worker_by_lua code.
    -- ngx.timer.at() can be called here, whereas most of the other ngx.*
    -- API is not availabe.

    timerhandler = function(premature)
        -- Handler for recursive timer invocation.
        -- Within a timer callback, plenty of the ngx.* API is available,
        -- with the exception of e.g. subrequests. As ngx.sleep is also not
        -- available in the current context, the recommended approach of
        -- implementing periodic tasks is via recursively defined timers.

        -- Premature timer execution: worker process tries to shut down.
        if premature then
            return
        end

        -- Invoke timer business logic.
        refresh_mesos_state_cache()

        -- Register new timer.
        local ok, err = ngx.timer.at(POLL_PERIOD_SECONDS, timerhandler)
        if not ok then
            ngx.log(ngx.ERR, "Failed to create timer: " .. err)
        end
    end

    -- Trigger initial timer, about 1 second after nginx startup.
    local ok, err = ngx.timer.at(1, timerhandler)
    if not ok then
        ngx.log(ngx.ERR, "failed to create timer: " .. err)
        return
    end
    ngx.log(ngx.DEBUG, "Created recursive timer for Mesos state polling.")
end


local function get_state_summary(retry)
    -- Fetch state summary JSON from cache and handle
    -- special case of cache not yet existing.
    local cache = ngx.shared.mesos_state_cache
    local statejson = cache:get("statejson")
    if not statejson then
        if retry then
            ngx.log(
                ngx.ERR,
                "Coud not retrieve Mesos state when first requested."
            )
            return nil
        end
        ngx.log(
            ngx.NOTICE,
            "Mesos state not available in cache yet. Fetch it."
        )
        refresh_mesos_state_cache()
        return get_state_summary(true)
    end
    return statejson
end


-- Expose interface for requesting state summary JSON.
_M.get_state_summary = get_state_summary


return _M
