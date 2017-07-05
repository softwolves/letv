local cjson = require "cjson";
local res = ngx.location.capture("/live_rtmp_auth?", 
            { args = { domain = ngx.var.domain, appName = ngx.var.appName,
                       streamName= ngx.var.streamName, protocol = 1,
                       clientIp = ngx.var.remote_addr, serverIp = ngx.var.server_addr,
                       uri = ngx.var.filename } })

if res.status ~= ngx.HTTP_OK then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

local res_tab = cjson.decode(res.body)
ngx.var.stream_id = res_tab["streamId"]
rtmp_listen_port = 1935
if res_tab["rtmpListenPort"] then
    rtmp_listen_port = tonumber(res_tab["rtmpListenPort"]) 
end
ngx.var.rtmp_port = 6000 + rtmp_listen_port - 1935

