local common = require "common"
local url = require "url"

function gen_serviceurl(service_name)
    local records = common.mesos_dns_get_srv(service_name)
    local first_ip = records[1]['ip']
    local first_port = records[1]['port']
    return "http://" .. first_ip .. ":" .. first_port
end

if ngx.var.serviceid == 'sparkcli' then
    ngx.var.serviceurl = gen_serviceurl('spark')
    return
end

if ngx.var.serviceid:startswith('cassandra') then
    local split_serviceid = ngx.var.serviceid:split('.')
    ngx.var.serviceurl = gen_serviceurl(split_serviceid[2] .. '-' .. split_serviceid[1])
    return
end

local state = common.mesos_get_state()
for _, framework in ipairs(state["frameworks"]) do
    if framework["id"] == ngx.var.serviceid or framework['name'] == ngx.var.serviceid then
        local split_pid = framework["pid"]:split("@")
        local split_ipport = split_pid[2]:split(":")
        local host = split_ipport[1]
        local webui_url = framework["webui_url"]
        if webui_url == "" then
            ngx.var.serviceurl = gen_serviceurl(framework['name'])
            return
        else
            local parsed_webui_url = url.parse(webui_url)
            parsed_webui_url.host = host
            if parsed_webui_url.path == "/" then
                parsed_webui_url.path = ""
            end
            ngx.var.serviceurl = parsed_webui_url:build()
            return
        end
        ngx.log(ngx.DEBUG, ngx.var.serviceurl)
    end
end
