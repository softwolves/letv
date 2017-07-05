local cjson = require "cjson";
local arg_tab = { }
local cache_ttl = 3 * 60
local flv_auth_cache = ngx.shared.flv_auth_cache
local trans_args = ""
local http = require("resty.http")


table.insert(arg_tab, "domain=" .. ngx.var.domain)
table.insert(arg_tab, "appName=" .. ngx.var.appName)
table.insert(arg_tab, "streamName=" .. ngx.var.streamName)
table.insert(arg_tab, "protocol=" .. tostring(3))
table.insert(arg_tab, "clientIp=" .. ngx.var.remote_addr)
table.insert(arg_tab, "serverIp=" .. ngx.var.server_addr)
table.insert(arg_tab, "uri=" .. ngx.var.filename)

local cache_key = ngx.var.domain .. ngx.var.appName .. ngx.var.streamName

trans_args = flv_auth_cache:get(cache_key)

if ngx.var.http_referer then
    table.insert(arg_tab, "refer=" .. ngx.var.http_referer)
end
table.insert(arg_tab, ngx.var.args)

local delay = 5
local handler
handler = function (premature, args, host, connection, cache_key)
    if premature then
        return
    end

    local hc = http:new()
    local res, err = hc:request_uri("http://127.0.0.1/live_flv_auth?" .. args, {
        method = "GET",
        headers = { ["Host"] = host,}
        })
    if not res then
        return
    end

    if res.status ~= ngx.HTTP_OK then
        return
    end

    local trans_args = ""

    local res_tab = cjson.decode(res.body)

    if tostring(res_tab["resultCode"]) == "0" then
        flv_auth_cache:set(connection, 1, 10)
        return
    end

    if tostring(res_tab["resultCode"]) == "1" then


        local trans_arg_tab = {"pStartFlag", "rtmp_port", "edgePullBufferSize", "rtmpPullBufferSize", "isPulling", "pushDelayReportLimit", "startPlayDelay", "client_port", "server_port"}
        
        trans_arg_tab["rtmp_port"] = 1935
        trans_arg_tab["edgePullBufferSize"] = 0
        trans_arg_tab["rtmpPullBufferSize"] = 0
        trans_arg_tab["isPulling"] = 0
        trans_arg_tab["pushDelayReportLimit"] = 0
        trans_arg_tab["startPlayDelay"] = nil
        trans_arg_tab["client_port"] = ngx.var.remote_port
        trans_arg_tab["server_port"] = ngx.var.server_port
        
        if res_tab["rtmpStartPlayOpt"] then
            trans_arg_tab["pStartFlag"] = tonumber(res_tab["rtmpStartPlayOpt"])
        end
        
        if res_tab["rtmpListenPort"] then
            trans_arg_tab["rtmp_port"] = tonumber(res_tab["rtmpListenPort"])
        end
        
        if res_tab["edgePullBufferSize"] then
            trans_arg_tab["edgePullBufferSize"] = tonumber(res_tab["edgePullBufferSize"]) * 1024 * 1024
        end
        
        if res_tab["rtmpPullBufferSize"] then
            trans_arg_tab["rtmpPullBufferSize"] = tonumber(res_tab["rtmpPullBufferSize"]) * 1024 * 1024
        end
        
        if res_tab["isPulling"] then
            trans_arg_tab["isPulling"] = tonumber(res_tab["isPulling"])
        end
        
        if res_tab["pushDelayReportLimit"] then
            trans_arg_tab["pushDelayReportLimit"] = tonumber(res_tab["pushDelayReportLimit"])
        end
        
        if res_tab["startPlayDelay"] then
            trans_arg_tab["startPlayDelay"] = tonumber(res_tab["startPlayDelay"])
        end
        
        for _, i in ipairs(trans_arg_tab) do
            if trans_arg_tab[i] then
                trans_args =  trans_args .. "&" .. i .. "=" .. trans_arg_tab[i]
            end
        end

       flv_auth_cache:set(cache_key, trans_args)
       flv_auth_cache:set(cache_key.."lecloudstreamid", res_tab["streamId"])

        return
    end

end

if trans_args then
    ngx.var.trans_args = trans_args
    ngx.var.stream_id = flv_auth_cache:get(cache_key.."lecloudstreamid")
    local ok, err = ngx.timer.at(0, handler, table.concat(arg_tab, "&"), ngx.var.domain, ngx.var.connection, cache_key)
    if not ok then
        ngx.log(ngx.ERR, "failed to create the timer: ", err)
        return
    end
    return
end

trans_args = ""


local res = ngx.location.capture("/live_flv_auth?", 
            { args = table.concat(arg_tab, "&")})

if res.status ~= ngx.HTTP_OK then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

local res_tab = cjson.decode(res.body)
ngx.var.stream_id = res_tab["streamId"]

local trans_arg_tab = {"pStartFlag", "rtmp_port", "edgePullBufferSize", "rtmpPullBufferSize", "isPulling", "pushDelayReportLimit", "startPlayDelay", "client_port", "server_port"}

trans_arg_tab["rtmp_port"] = 1935
trans_arg_tab["edgePullBufferSize"] = 0
trans_arg_tab["rtmpPullBufferSize"] = 0
trans_arg_tab["isPulling"] = 0
trans_arg_tab["pushDelayReportLimit"] = 0
trans_arg_tab["startPlayDelay"] = nil
trans_arg_tab["client_port"] = ngx.var.remote_port
trans_arg_tab["server_port"] = ngx.var.server_port

if tostring(res_tab["resultCode"]) == "0" then
    ngx.exit(404)
    return
end

if res_tab["rtmpStartPlayOpt"] then
    trans_arg_tab["pStartFlag"] = tonumber(res_tab["rtmpStartPlayOpt"])
end

if res_tab["rtmpListenPort"] then
    trans_arg_tab["rtmp_port"] = tonumber(res_tab["rtmpListenPort"]) 
end

if res_tab["edgePullBufferSize"] then
    trans_arg_tab["edgePullBufferSize"] = tonumber(res_tab["edgePullBufferSize"]) * 1024 * 1024
end

if res_tab["rtmpPullBufferSize"] then
    trans_arg_tab["rtmpPullBufferSize"] = tonumber(res_tab["rtmpPullBufferSize"]) * 1024 * 1024
end

if res_tab["isPulling"] then
    trans_arg_tab["isPulling"] = tonumber(res_tab["isPulling"])
end

if res_tab["pushDelayReportLimit"] then
    trans_arg_tab["pushDelayReportLimit"] = tonumber(res_tab["pushDelayReportLimit"])
end

if res_tab["startPlayDelay"] then
    trans_arg_tab["startPlayDelay"] = tonumber(res_tab["startPlayDelay"])
end

for _, i in ipairs(trans_arg_tab) do
    if trans_arg_tab[i] then
        trans_args =  trans_args .. "&" .. i .. "=" .. trans_arg_tab[i]
    end
end

ngx.var.trans_args = trans_args

flv_auth_cache:set(cache_key, trans_args)
flv_auth_cache:set(cache_key.."lecloudstreamid", res_tab["streamId"])
