local cjson = require "cjson"
local ups_config = ngx.shared.ups_config
local upstream = require "ngx.upstream"
local leups = require "le.upstream"

local get_servers = upstream.get_servers
local get_upstreams = upstream.get_upstreams

local string_find = string.find
local string_len = string.len

if ngx.var.request_method == "POST" then
local config = ngx.var.request_body
    local config_tab = cjson.decode(config)

    local domain = config_tab["domain"]
    
    if not domain or string_len(domain) == 0  then
       domain = "default"
    end

    ngx.say("domain:", domain)

    for i, j in pairs(config_tab["sourcelist"]) do
        for nodeid, _ in pairs(j) do
           ngx.say(nodeid)
        end
    end

    ups_config:set(domain, config)
end

if ngx.var.request_method == "GET" then

    local domain = ngx.var.arg_domain

    if not domain then
        domain = "default"
    end

    local config = ups_config:get(domain)

    if not config or string_len(config) == 0 then
        config = leups.upstream_to_json(domain)
        if not config then
            config = leups.upstream_to_json("default")
        end
    end

    ngx.say(config)

end
