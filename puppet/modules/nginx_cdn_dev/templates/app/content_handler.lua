local request = require("request")
local var = require("var")

local req = request.init_request()

var.init_var(req)

ngx.ctx.request = req

local lua_phase = req["lua_phase"]


if lua_phase then
    if lua_phase.access_handler and (not req["headers"]["X-LeCloud-Host"]) and (ngx.var.arg_from ~= "watchdog") then
        lua_phase.access_handler(req)
    end

    if lua_phase.content_handler then
        lua_phase.content_handler(req)
    end
end

request.post_var(req)

if req["origin_server"] or req["request_method"] == "POST" or request.origin_detection_url(req) then
    return ngx.exec("@BACKEND")
end

if request.check_conhash(req) then
    return ngx.exec("@NGINX")
end

return ngx.exec("@ATS")

