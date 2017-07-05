local cjson = require "cjson";
local arg_tab = { }

table.insert(arg_tab, "domain=" .. ngx.var.domain)
table.insert(arg_tab, "appName=" .. ngx.var.appName)
table.insert(arg_tab, "streamName=" .. ngx.var.streamName)
table.insert(arg_tab, "protocol=" .. tostring(3))
table.insert(arg_tab, "clientIp=" .. ngx.var.remote_addr)
table.insert(arg_tab, "serverIp=" .. ngx.var.server_addr)
table.insert(arg_tab, "uri=" .. ngx.var.filename)
if ngx.var.http_referer then
    table.insert(arg_tab, "refer=" .. ngx.var.http_referer)
end
table.insert(arg_tab, ngx.var.args)

ngx.ctx["CIP"] = ngx.var.remote_addr .. ":" .. ngx.var.remote_port
ngx.ctx["SIP"] = ngx.var.server_addr .. ":" .. ngx.var.server_port
ngx.ctx["Sync"] = "1"
ngx.ctx["RetCode"] = "0"
ngx.ctx["Time"] = os.date("%Y-%m-%d %H:%M:%S", ngx.now())
ngx.ctx["CtTm"] = ngx.now() * 1000
ngx.ctx["SaTm"] = ngx.now() * 1000
ngx.ctx["type"] =  "11"

local res = ngx.location.capture("/live_flv_auth?", 
            { args = table.concat(arg_tab, "&")})

if res.status ~= ngx.HTTP_OK then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

local res_tab = cjson.decode(res.body)
ngx.var.stream_id = res_tab["streamId"]

ngx.ctx["RaTm"] =  ngx.now() * 1000
ngx.ctx["SgbTm"]= ngx.now() * 1000
ngx.ctx["Stream"] = res_tab["streamId"]

local trans_arg_tab = {"pStartFlag", "rtmp_port", "edgePullBufferSize", "rtmpPullBufferSize", "isPulling", "pushDelayReportLimit", "client_ip", "server_ip", "domain", "startPlayDelay", "client_port", "server_port"}

trans_arg_tab["rtmp_port"] = 1935
trans_arg_tab["edgePullBufferSize"] = 0
trans_arg_tab["rtmpPullBufferSize"] = 0
trans_arg_tab["isPulling"] = 0
trans_arg_tab["pushDelayReportLimit"] = 0
trans_arg_tab["startPlayDelay"] = nil

ngx.log(ngx.ERR, res.body)

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

ngx.var.trans_args = trans_args
