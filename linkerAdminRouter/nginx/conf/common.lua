local cjson_safe = require "cjson.safe"
local statecache = require "mesosstatecache"


local common = {}


function common.mesos_get_state()
    -- Read Mesos state JSON from SHM cache.
    -- Return decoded JSON or nil upon error.
    local statejson = statecache.get_state_summary()
    local state, err = cjson_safe.decode(statejson)
    if not state then
        ngx.log(ngx.ERR, "Cannot decode JSON: " .. err)
        return nil
    end
    return state
end


function common.mesos_dns_get_srv(framework_name)
    local res = ngx.location.capture(
        "/mesos_dns/v1/services/_" .. framework_name .. "._tcp.marathon.mesos")

    if res.truncated then
        -- Remote connection dropped prematurely or timed out.
        ngx.log(ngx.ERR, "Request to Mesos DNS failed.")
        return nil
    end
    if res.status ~= 200 then
        ngx.log(ngx.ERR, "Mesos DNS response status: " .. res.status)
        return nil
    end

    local records, err = cjson_safe.decode(res.body)
    if not records then
        ngx.log(ngx.ERR, "Cannot decode JSON: " .. err)
        return nil
    end
    return records
end


function string:split(sep)
    local sep, fields = sep or " ", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end


function string.startswith(str, prefix)
    return string.sub(str, 1, string.len(prefix)) == prefix
end


return common
