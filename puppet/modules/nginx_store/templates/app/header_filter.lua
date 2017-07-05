_VERSION = "31.3.17"

local var = require("var")

ngx.header["X-NG-Host"] = var.hostname
ngx.header["X-LeCloud-Ver"] = "LeCloud/" .. _VERSION

local req = ngx.ctx.request

if req and req.lua_phase then
    local lua_phase = req["lua_phase"]
    if lua_phase.header_filter then
        lua_phase.header_filter(req)
    end
end
