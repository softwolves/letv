local string = require "string"
local socket = require "socket"

local report_interval = 300
local time = ngx.time()
local upload_ip = "127.0.0.1"
local upload_port = 8120
local upload_bind_ip = "127.0.0.1"
local upload_bind_port = 18120


--[[
--$remote_addr -$remote_user [$time_local] "$request"$status $bytes_sent $body_bytes_sent $request_time "$http_range" "$http_referer""$http_user_agent" "$http_x_forwarded_for" "$connection" $PNO "$HIT""server_addr"
--112.85.252.86 --[10/Aug/2015:16:56:31 +0800] "GET /mp4/2015/dianshiju/xfsn_27591/71DC70FF6EBC49525726E8E250755A59_20150721_1_1_383.mp4/1770000_1780000_v01_mp4.ts?uuid=55c7caed8e454ed2ad22dc3d58b6a84f HTTP/1.1" 200 401960 401756 2809 "-" "-" "AppleCoreMedia/1.0.0.12F69 (iPad; U; CPU OS 8_3 like Mac OS X; zh_cn)" "-" "273428218" 1021“HIT”132.45.252.16
--]]

function data_format()
    local delim1 = " "
    local delim2 = "\""
    local delim4 = "["
    local delim5 = "]"
    local hit = "HIT"
    local http_range = ngx.var.http_range
    local http_referer = ngx.var.http_referer
    local http_user_agent = ngx.var.http_user_agent
    local http_x_forwarded_for = ngx.var.http_x_forwarded_for
    local remote_user = ngx.var.remote_user
    local pno = ngx.var.arg_PNO 
    local log_location = ngx.var.log_location

    if ngx.var.log_location == nil then
        log_location = "-"
    end

    if ngx.var.http_range == nil then
        http_range = "-"
    end

    if ngx.var.http_referer == nil then
        http_referer = "-"
    end

    if ngx.var.http_user_agent == nil then
        http_user_agent = "-"
    end

    if ngx.var.http_x_forwarded_for == nil then
        http_x_forwarded_for = "-"
    end

    if ngx.var.remote_user == nil then
        remote_user = "-"
    end

    if ngx.var.arg_PNO == nil then
        pno = "-"
    end

    local data = ""
    data = data .. ngx.var.remote_addr
    data = data .. delim1
    data = data .. "-"
    data = data .. delim1
    data = data .. remote_user
    data = data .. delim1 .. delim4
    data = data .. ngx.var.time_local
    data = data .. delim5 .. delim1 .. delim2
    data = data .. ngx.var.request_method .. delim1
    data = data .. ngx.var.http_host .. ngx.var.request_uri .. delim1
    data = data .. ngx.var.server_protocol
    data = data .. delim2 .. delim1
    data = data .. ngx.var.status
    data = data .. delim1
    data = data .. ngx.ctx.bytes_sent
    data = data .. delim1
    data = data .. ngx.ctx.body_bytes_sent
    data = data .. delim1
    data = data .. tostring(tonumber(ngx.var.request_time)*1000)
    data = data .. delim1 .. delim2
    data = data .. http_range
    data = data .. delim2 .. delim1 .. delim2
    data = data .. http_referer
    data = data .. delim2 .. delim1 .. delim2
    data = data .. http_user_agent
    data = data .. delim2 .. delim1 .. delim2
    data = data .. http_x_forwarded_for
    data = data .. delim2 .. delim1 .. delim2
    data = data .. ngx.var.connection
    data = data .. delim2 .. delim1
    data = data .. pno
    data = data .. delim1 .. delim2
    data = data .. hit
    data = data .. delim2 .. delim1 .. delim2
    -- data = data .. ngx.var.server_addr
    data = data .. "-"
    data = data .. delim2 .. delim1
    data = data .. ngx.var.host
    data = data .. delim1 .. delim2
    data = data .. log_location
    data = data .. delim2 .. "\r\n"
 
    return data
end

function report_handler()
    local udpsock = socket.udp()
    local data = data_format()
    udpsock:setsockname(upload_bind_ip, upload_bind_port)
    udpsock:sendto(data, upload_ip, upload_port)
end


if ngx.ctx.report_time == nil then
    ngx.ctx.bytes_sent = ngx.var.header_size
    ngx.ctx.body_bytes_sent = 0
    ngx.ctx.report_time = time
    ngx.ctx.report_time = ngx.ctx.report_time - ngx.ctx.report_time % report_interval
    ngx.ctx.report_time = ngx.ctx.report_time + report_interval
end

local sent = string.len(ngx.arg[1])
ngx.ctx.body_bytes_sent = ngx.ctx.body_bytes_sent + sent
ngx.ctx.bytes_sent = ngx.ctx.bytes_sent + sent

if time > ngx.ctx.report_time or ngx.arg[2] == true then
    report_handler()
    ngx.ctx.bytes_sent = 0
    ngx.ctx.body_bytes_sent = 0
    ngx.ctx.report_time = time
    ngx.ctx.report_time = ngx.ctx.report_time - ngx.ctx.report_time % report_interval
    ngx.ctx.report_time = ngx.ctx.report_time + report_interval
end

