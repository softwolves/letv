local url = require "net.url"

local log = ngx.log
local args = ngx.var.args
local host = ngx.var.http_host
local cache_key = host

local gslb_cache = ngx.shared.gslb_cache

local cache_ttl = 3 * 60
local cache_value_keys = {"path", "geo", "cips", "platid", "splatid", "proxy", "lersrc", "tag", "cuhost", "sign", "sthost", "cuid", "flw3x"}

if ngx.var.cache_key and string.len(ngx.var.cache_key) ~= 0 then
    cache_key = ngx.var.cache_key
end

if ngx.var.cache_ttl and string.len(ngx.var.cache_ttl) ~= 0 then
    cache_ttl = tonumber(ngx.var.cache_ttl)
end

local cache = gslb_cache:get(cache_key)

if cache then
    ngx.var.gslb_cache  = cache .."&gslb_cache_status=HIT"
    if args then
        cache = args .. "&" .. cache
    end
    ngx.var.gslb_path = cache .. "&lecloud_proxy=2001"
    ngx.var.log_location = "http://" .. host .. ngx.var.uri .. "?" .. cache .. "&lecloud_proxy=1001" 
    return
end

local arg_tab = {}
table.insert(arg_tab, "must=" .. ngx.var.cdnid)
if args then
    table.insert(arg_tab, args)
end

local res = ngx.location.capture('/gslb_proxy'..ngx.var.uri.."?"..table.concat(arg_tab, "&") , { share_all_vars = true })

if res.status == 302 then
    local location = res.header['Location']
    local u = url.parse(location)
    local host = u.host;
    local query = u.query;
    local cache_value_tab = {}

    for i, key in ipairs(cache_value_keys) do
        if query[key] == nil then
            query[key] = ""
        end

        if key == "sthost" or key == "lersrc" then
            if string.len(query[key]) % 4 == 2 then
                query[key] = query[key] .. string.rep("=", 2)
            end

            if string.len(query[key]) % 4 == 3 then
                query[key] = query[key] .. string.rep("=", 1)
            end
        end

        table.insert(cache_value_tab, key.."="..query[key])
    end

    local cache_value = table.concat(cache_value_tab, "&")
    gslb_cache:set(cache_key, cache_value, cache_ttl)
    ngx.var.gslb_cache = cache_value .. "&gslb_cache_status=MISS"
    if args then
        cache_value = args .. "&" .. cache_value
    end
    ngx.var.gslb_path = cache_value .. "&lecloud_proxy=2001"
    ngx.var.log_location = "http://" .. host .. ngx.var.uri .. "?" .. cache_value .. "&lecloud_proxy=1001"
    return
end
