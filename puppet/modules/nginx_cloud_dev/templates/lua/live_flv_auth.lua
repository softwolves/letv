local cjson = require "cjson";
local http = require "resty.http"

local function errlog(...)
    ngx.log(ngx.ERR, "lecloud_liubin6: \"", ..., "\"")
end

local req_cc_args = {"domain", "appName", "streamName", "protocol", "clientIp", "serverIp", "uri"}
local req_cc_url  = "http://api.live.letvcloud.com/v3/rtmp/pullStreamSecure"
local req_log_url = "http://log.cdn.letvcloud.com/live_tl"
local req_r2h_url = "http://127.0.0.1:9100/live/flv/"

if ngx.var.arg_debug == "liubin6" then
    req_cc_url  = "http://127.0.0.1:9999/v3/rtmp/pullStreamSecure"
end

if ngx.var.args then
    req_cc_url = req_cc_url .. ngx.var.is_args .. ngx.var.args
else
    req_cc_url = req_cc_url .. "?lecloud_tag=lengine"
end

req_cc_args["domain"] = ngx.var.http_host
req_cc_args["appName"] = ngx.var.appName
req_cc_args["streamName"] = ngx.var.streamName
req_cc_args["protocol"] = tostring(3)
req_cc_args["clientIp"] = ngx.var.remote_addr
req_cc_args["serverIp"] = ngx.var.server_addr
req_cc_args["uri"] = ngx.var.uri
req_cc_args["refer"] = ngx.var.http_referer

for _, i in ipairs(req_cc_args) do
    if req_cc_args[i] then
        req_cc_url = req_cc_url .. "&" .. i .. "=" .. req_cc_args[i] 
    end
end

errlog(req_cc_url)

ngx.ctx["CIP"] = ngx.var.remote_addr .. ":" .. ngx.var.remote_port
ngx.ctx["SIP"] = ngx.var.server_addr .. ":" .. ngx.var.server_port
ngx.ctx["Sync"] = "1"
ngx.ctx["RetCode"] = "0"
ngx.ctx["Time"] = os.date("%Y-%m-%d %H:%M:%S", ngx.now())
ngx.ctx["CtTm"] = ngx.now() * 1000
ngx.ctx["SaTm"] = ngx.now() * 1000
ngx.ctx["type"] =  "11"

local httpc = http.new()
local res, err = httpc:request_uri(req_cc_url, {
    method = "GET",
    headers = {
        ["User-Agent"] = "LeCloud-CDN-Legine",
        ["Host"] = "api.live.letvcloud.com",
    }
})

httpc:set_keepalive()

if (not res ) or (res.status ~= ngx.HTTP_OK) then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

errlog(res.body)

local res_tab = cjson.decode(res.body)

if tostring(res_tab["resultCode"]) == "0" then
    ngx.exit(404)
    return
end

ngx.var.stream_id = res_tab["streamId"]

ngx.ctx["RaTm"] =  ngx.now() * 1000
ngx.ctx["SgbTm"]= ngx.now() * 1000
ngx.ctx["Stream"] = res_tab["streamId"]

local cc_json_args = {"isPulling", "pushDelayReportLimit", "startPlayDelay", "audioOnlyParaName", "audioOnlyParaValue"}
local trans_arg_tab = {"stream_id", "rtmp_port", "pStartFlag", "edgePullBufferSize", "rtmpPullBufferSize", "client_ip", "server_ip", "client_port", "server_port", "domain"}

trans_arg_tab["rtmp_port"] = 1935
trans_arg_tab["stream_id"] = res_tab["streamId"]

if res_tab["rtmpListenPort"] then
    trans_arg_tab["rtmp_port"] = tonumber(res_tab["rtmpListenPort"])
end

if res_tab["rtmpStartPlayOpt"] then
    trans_arg_tab["pStartFlag"] = tonumber(res_tab["rtmpStartPlayOpt"])
end

if res_tab["edgePullBufferSize"] then
    trans_arg_tab["edgePullBufferSize"] = tonumber(res_tab["edgePullBufferSize"]) * 1024 * 1024
end

if res_tab["rtmpPullBufferSize"] then
    trans_arg_tab["rtmpPullBufferSize"] = tonumber(res_tab["rtmpPullBufferSize"]) * 1024 * 1024
end

trans_arg_tab["client_ip"] = ngx.var.remote_addr
trans_arg_tab["server_ip"] = ngx.var.server_addr
trans_arg_tab["client_port"] = ngx.var.remote_port
trans_arg_tab["server_port"] = ngx.var.server_port
trans_arg_tab["domain"] = ngx.var.domain


local trans_args = ""

for _, i in ipairs(trans_arg_tab) do
    if trans_arg_tab[i] then
        trans_args =  trans_args .. "&" .. i .. "=" .. trans_arg_tab[i]
    end
end

for _, i in ipairs(cc_json_args) do
    if res_tab[i] then
        trans_args =  trans_args .. "&" .. i .. "=" .. res_tab[i] 
    end
end

req_r2h_url = req_r2h_url .. ngx.var.stream_id .. "?lecloud_tag=lengine"
req_r2h_url = req_r2h_url .. trans_args
ngx.var.req_r2h_url = req_r2h_url
errlog(req_r2h_url)

if (ngx.var.return_302 == "true") or (res_tab[return_302] == "true") then
    -- http://live.coop.gslb.letv.com/live/flv/$stream_id?uip=$uip&platid=10&splatid=1029
    local req_gslb_url = "http://live.coop.gslb.letv.com/live/flv/" .. ngx.var.stream_id
    local req_gslb_args = "uip=" .. ngx.var.remote_addr .. "&platid=10&splatid=1029"
    req_gslb_url =  req_gslb_url .. "?" .. req_gslb_args
    errlog(req_gslb_url)
    
    local httpc = http.new()
    local res, err = httpc:request_uri(req_gslb_url, {
        method = "GET",
        headers = {
          ["User-Agent"] = "LeCloud-CDN-Legine",
          ["X-LETV-IP"] = ngx.var.remote_addr,
        }
    })

    httpc:set_keepalive()
     
    if (not res ) or (res.status ~= ngx.HTTP_MOVED_TEMPORARILY) then
        ngx.exit(ngx.HTTP_NOT_FOUND)
    end
   
    local location = res.headers["Location"]

    ngx.ctx["RgbTm"] = ngx.now() * 1000
    ngx.ctx["SqhTm"] = ngx.now() * 1000
    ngx.ctx["SdTm"] = ngx.now() * 1000
    ngx.ctx["Version"] = "nginx"

    errlog(location)
    
    if ( not location ) or ( string.len(location) == 0) then
        ngx.exit(ngx.HTTP_NOT_FOUND)
    end

    local function push_data(premature, data)
        local httpc = http.new()

        local res, err = httpc:request_uri(req_log_url, {
            method = "POST",
            body = data,
            headers = {
                ["User-Agent"] = "LeCloud-CDN-Legine",
                ["Host"] = "log.cdn.letvcloud.com",
            }
        })

        httpc:set_keepalive()
    end

    local report_tab = {"Time", "Version", "Stream", "CIP", "SIP", "Sync", "RetCode", "CtTm", "SaTm", "RaTm", "SgbTm", "RgbTm", "SqhTm", "SdTm", "type"}
    local report_data = ""
    for _, key in ipairs(report_tab) do
        if not ngx.ctx[key] then
            ngx.ctx[key] = "0"
        end
        report_data = report_data .. ", " .. key .. ":" .. ngx.ctx[key]
    end

    -- remove the start ", "
    report_data = string.sub(report_data,3)
    local ok, err = ngx.timer.at(0, push_data, report_data)
    
    errlog(report_data)

    location = ngx.re.sub(location, "^(.*)&path=.*?(&.*)?$", "$1$2")
    location = string.format("%s%s", location, trans_args)
    ngx.header.Location = location
    ngx.exit(ngx.HTTP_MOVED_TEMPORARILY)
end
