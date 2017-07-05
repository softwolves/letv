local balancer = require "ngx.balancer"
local concat = table.concat
local cjson = require "cjson"
local leups = require "le.upstream"

local log = ngx.log
local ERR = ngx.ERR

local ups_config = ngx.shared.ups_config

local string_find = string.find
local string_len = string.len

if not ngx.ctx.tries then
    ngx.ctx.tries = 0
end

if ngx.ctx.tries <= 10 then
    local ok, err = balancer.set_more_tries(1)
    if not ok then
        return error("failed to set more tries: ", err)
    elseif err then
        ngx.log(ngx.ERR, "set more tries: ", err)
    end
end

ngx.ctx.tries = ngx.ctx.tries + 1

if ngx.ctx.tries > 1 then
    local host = ngx.ctx.upstream[ngx.ctx.tries]
    host, port = leups.addr_parse(host)
    if host then
        balancer.set_current_peer(host, 80)
    end
    return
end

local server_name = ngx.var.http_host
local ups_var = server_name
local orgin_ups_var = server_name .. "_" .. "origin"
local config = ups_config:get(ups_var)
local origin_config = ups_config:get(origin_ups_var)

if not config or string.len(config) == 0 then
    config = ups_config:get("default")
end


if not origin_config or string_len(origin_config) == 0 then
    origin_config = leups.upstream_to_json(ups_var)
    if not origin_config then
       origin_config = leups.upstream_to_json("default")
    end
    ups_config:set(origin_ups_var, config_origin)
end

if not config or string.len(config) == 0 then
    config = origin_config
end

ngx.ctx.upstream = { }

local seq = leups.get_current_upstream(ngx.ctx.upstream, config, 0, ngx.var.uri)
seq = leups.get_current_upstream(ngx.ctx.upstream, origin_config, seq, ngx.var.uri)

host, port = leups.addr_parse(ngx.ctx.upstream[1])
balancer.set_current_peer(host, 80)

