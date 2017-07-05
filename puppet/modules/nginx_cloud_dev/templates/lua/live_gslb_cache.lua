local url = require "net.url"

local stream_id = ngx.var.stream_id
local log = ngx.log
local uip = ngx.var.http_serveraddr
local args = ngx.var.args

local gslb_cache = ngx.shared.live_gslb_cache

local cache_ttl = 3 * 60
local cache_value_keys = {"path", "geo", "cips", "hls_cname"}

local cache = gslb_cache:get(stream_id)
local host  = gslb_cache:get(stream_id.."host") 

if cache then
    if args then
        cache = cache.."&"..args
    end
    ngx.var.stream_path = cache
    ngx.var.stream_host = host
    ngx.var.gslb_cache  = cache.."&gslb_cache_status=HIT"
    ngx.var.log_location = "http://" .. host .. "?" .. ngx.var.gslb_cache
    return
end
if not uip then
    uip = ngx.var.arg_server_addr
end

if uip then
    ngx.req.set_header("X-LETV-IP", uip)
end
local arg_tab = {}

table.insert(arg_tab, "platid=10")
table.insert(arg_tab, "splatid=1029")

if args then
    table.insert(arg_tab, args)
end

if ngx.var.arg_hls_cname == nil  then
    table.insert(arg_tab, "hls_cname="..ngx.var.http_host)
end

local res = ngx.location.capture('/live_gslb_proxy'..ngx.var.uri.."?"..table.concat(arg_tab, "&"))

if res.status == 302 then
    local location = res.header['Location']
    local u = url.parse(location)
    local host = u.host;
    local query = u.query;
    local cache_value_tab = {}

    for i, key in ipairs(cache_value_keys) do
        if query[key] == nil then
            query[key] = "0"
        end
        table.insert(cache_value_tab, key.."="..query[key])
    end

    local cache_value = table.concat(cache_value_tab, "&")
    gslb_cache:set(stream_id, cache_value, cache_ttl)
    gslb_cache:set(stream_id.."host", u.host, cache_ttl)
    ngx.var.gslb_cache = cache_value.."&gslb_cache_status=MISS"
    if args then
        cache_value = cache_value.."&"..args
    end
    ngx.var.stream_path = cache_value
    ngx.var.stream_host = u.host
    ngx.var.log_location = "http://" .. u.host .. "?" .. ngx.var.gslb_cache
    return
end
