local common = require "common"

local state = common.mesos_get_state()
for _, slave in ipairs(state["slaves"]) do
    if slave["id"] == ngx.var.slaveid then
        local split_pid = slave["pid"]:split("@")
        ngx.var.slaveaddr = split_pid[2]
        ngx.log(ngx.DEBUG, ngx.var.slaveaddr)
    end
end
