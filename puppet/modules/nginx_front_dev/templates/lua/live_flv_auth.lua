local cjson = require "cjson";
local arg_tab = { }

table.insert(arg_tab, "domain=" .. ngx.var.domain)
table.insert(arg_tab, "appName=" .. ngx.var.appName)
table.insert(arg_tab, "streamName=" .. ngx.var.streamName)
table.insert(arg_tab, "protocol=" .. tostring(3))
table.insert(arg_tab, "clientIp=" .. ngx.var.remote_addr)
table.insert(arg_tab, "serverIp=" .. ngx.var.server_addr)
table.insert(arg_tab, "uri=" .. ngx.var.filename)
table.insert(arg_tab, ngx.var.args)

local res = ngx.location.capture("/live_flv_auth?", 
            { args = table.concat(arg_tab, "&")})

if res.status ~= ngx.HTTP_OK then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

local res_tab = cjson.decode(res.body)
ngx.var.stream_id = res_tab["streamId"]
local rtmp_listen_port = 1935
local edgepullbuffersize = 0
local rtmppullbuffersize = 0

if res_tab["rtmpStartPlayOpt"] then
    pstartflag = tonumber(res_tab["rtmpStartPlayOpt"])
end

if res_tab["rtmpListenPort"] then
    rtmp_listen_port = tonumber(res_tab["rtmpListenPort"]) 
end

if res_tab["edgePullBufferSize"] then
    edgepullbuffersize = tonumber(res_tab["edgePullBufferSize"]) * 1024 * 1024
end

if res_tab["rtmpPullBufferSize"] then
    rtmppullbuffersize = tonumber(res_tab["rtmpPullBufferSize"]) * 1024 * 1024
end

ngx.var.rtmp_port = rtmp_listen_port 
ngx.var.pstartflag = pstartflag
ngx.var.edgepullbuffersize = edgepullbuffersize
ngx.var.rtmppullbuffersize = rtmppullbuffersize

