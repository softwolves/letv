local request = require("request")
local var = require("var")

local req = request.init_request()

var.init_var(req)

ngx.ctx.request = req

local lua_phase = req["lua_phase"]

if not req["headers"]["X-LeCloud-Host"] then
    ngx.var.x_real_ip = ngx.var.remote_addr
    ngx.var.x_forwarded_for = ngx.var.x_forwarded_for
    ngx.var.bill_status = "B1"
end

if lua_phase then
    if not req["headers"]["X-LeCloud-Host"] then
        if lua_phase.access_handler and (ngx.var.arg_from ~= "watchdog") then
            lua_phase.access_handler(req)
        end
    end

    if lua_phase.content_handler then
        lua_phase.content_handler(req)
    end
end

ngx.var.cache_url = request["cache_url"]
ngx.var.cache_request_uri = request["cache_request_uri"]

