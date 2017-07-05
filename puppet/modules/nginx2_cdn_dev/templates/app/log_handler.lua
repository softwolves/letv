local req = ngx.ctx.request

if req and req.lua_phase then
    local lua_phase = req["lua_phase"]
    if lua_phase.log then
        lua_phase.log(req)
    end
end
