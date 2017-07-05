local cjson = require "cjson"
local string = require "string"
local socket = require "socket"

local report_interval = 300
--local time = ngx.time()
local time = ngx.now()
local upload_ip = "127.0.0.1"
local upload_port = 8120 
local upload_bind_ip = "127.0.0.1"
local upload_bind_port = 18120
local hntv_report = ngx.shared.hntv_report

function data_format()
    local log_tab = {"tag", "server", "remote_addr", "time", "request", "status", "body_bytes_sent", "bytes_sent", "sent_http_content_length", "HIT", "host", "http_user_agent", "http_referer", "http_range","request_time","upstream_http_via", "http_x_forwarded_for", "x_real_host", "upstream_addr","bill_status","upstream_response_time","upstream_header_time","upstream_connect_time","connection"}
    log_tab["tag"] = "NEWCDN"
    log_tab["server"] = ngx.var.server_addr .. ":" .. ngx.var.server_port
    log_tab["remote_addr"] = ngx.var.remote_addr
    log_tab["time"] = "[" .. ngx.var.time_local .. "]"
    log_tab["request"] = ngx.var.request_method .. " " .. ngx.var.scheme .. "://" .. ngx.var.http_host .. ngx.var.request_uri .. " " .. ngx.var.server_protocol
    log_tab["status"] = ngx.var.status
    log_tab["body_bytes_sent"] = ngx.ctx.body_bytes_sent
    log_tab["bytes_sent"] = ngx.ctx.bytes_sent
    log_tab["sent_http_content_length"] = ngx.var.sent_http_content_length
    log_tab["HIT"] = ngx.var.sent_http_le_status 
    log_tab["host"] = ngx.var.http_host
    log_tab["http_user_agent"] = ngx.var.http_user_agent or "-"
    log_tab["http_referer"] = ngx.var.http_referer or "-"
    log_tab["http_range"] = ngx.var.http_range or "-"
    log_tab["request_time"] = tostring(tonumber(ngx.ctx.request_time)) 
    log_tab["upstream_http_via"] = ngx.var.upstream_http_via or "-"
    log_tab["http_x_forwarded_for"] = ngx.var.http_x_forwarded_for or "-"
    log_tab["x_real_host"] = ngx.var.x_real_host or "-"
    log_tab["upstream_addr"] = ngx.var.upstream_addr or "-"
    log_tab["bill_status"] = "B1"
    log_tab["upstream_response_time"] = ngx.var.upstream_response_time or "-"
    log_tab["upstream_header_time"] = ngx.var.upstream_header_time  or "-"
    log_tab["upstream_connect_time"] = ngx.var.upstream_connect_time  or "-"
    log_tab["connection"] = ngx.var.connection

    local log_str = ""
    for _, i in ipairs(log_tab) do
      log_str = log_str .. "\"" .. log_tab[i] .. "\" "
    end

    --ngx.log(ngx.ERR, "test_log_str2: ", log_str)

    return log_str
end

function report_handler()
    local udpsock = socket.udp()
    local data = data_format()
    udpsock:setsockname(upload_bind_ip, upload_bind_port)
    udpsock:sendto(data, upload_ip, upload_port)
end

function json_data_format()
    local log_tab = {"tag", "server", "remote_addr", "time", "request", "status", "body_bytes_sent", "bytes_sent", "sent_http_content_length", "HIT", "host", "http_user_agent", "http_referer", "http_range","request_time","upstream_http_via", "http_x_forwarded_for", "x_real_host", "upstream_addr","bill_status","upstream_response_time","upstream_header_time","upstream_connect_time","connection"}
    log_tab["tag"] = "NEWCDN"
    log_tab["server"] = ngx.var.server_addr .. ":" .. ngx.var.server_port
    log_tab["remote_addr"] = ngx.var.remote_addr
    log_tab["time"] = "[" .. ngx.var.time_local .. "]"
    log_tab["request"] = ngx.var.request_method .. " " .. ngx.var.scheme .. "://" .. ngx.var.http_host .. ngx.var.request_uri .. " " .. ngx.var.server_protocol
    log_tab["status"] = ngx.var.status
    log_tab["body_bytes_sent"] = ngx.ctx.body_bytes_sent
    log_tab["bytes_sent"] = ngx.ctx.bytes_sent
    log_tab["sent_http_content_length"] = ngx.var.sent_http_content_length
    log_tab["HIT"] = ngx.var.sent_http_le_status 
    log_tab["host"] = ngx.var.http_host
    log_tab["http_user_agent"] = ngx.var.http_user_agent or "-"
    log_tab["http_referer"] = ngx.var.http_referer or "-"
    log_tab["http_range"] = ngx.var.http_range or "-"
    log_tab["request_time"] = report_interval*1000 
    log_tab["upstream_http_via"] = ngx.var.upstream_http_via or "-"
    log_tab["http_x_forwarded_for"] = ngx.var.http_x_forwarded_for or "-"
    log_tab["x_real_host"] = ngx.var.x_real_host or "-"
    log_tab["upstream_addr"] = ngx.var.upstream_addr or "-"
    log_tab["bill_status"] = "B1"
    log_tab["upstream_response_time"] = ngx.var.upstream_response_time or "-"
    log_tab["upstream_header_time"] = ngx.var.upstream_header_time  or "-"
    log_tab["upstream_connect_time"] = ngx.var.upstream_connect_time  or "-"
    log_tab["connection"] = ngx.var.connection

    local log_str = cjson.encode(log_tab) 
    --ngx.log(ngx.ERR, "test_log_str3: ", log_str)
    return log_str
end

local function timer_handler(premature, key, sync_key, base_time)
    --ngx.log(ngx.ERR, "test_enter_handler: ", key)
    if premature then
        return
    end
    local data = hntv_report:get(key)
    if not data then
        return
    end
    base_time = base_time + report_interval;
    local ok, err = ngx.timer.at(report_interval, timer_handler, key, sync_key, base_time)
    if not ok then
        return
    end

    local sync_tab = {}
    sync_tab["update_flag"] = 1
    sync_tab["sync_time"] = base_time
    local sync_str = cjson.encode(sync_tab) 
    hntv_report:set(sync_key, sync_str, 0)
    --ngx.log(ngx.ERR, "test_sync_str: ", sync_str)

    --ngx.log(ngx.ERR, "test_data", data)
    local log_tab =  cjson.decode(data)
    --ngx.log(ngx.ERR, "test_log_tab1:", log_tab["time"], log_tab["connection"])
    log_tab["time"] = "[" .. os.date("%d/%b/%Y:%X +0800", base_time) .. "]"
    --ngx.log(ngx.ERR, "test_log_tab2:", log_tab["time"], log_tab["connection"])
    --ngx.log(ngx.ERR, "test_log_tab5:", log_tab["1"])

    local my_log_tab  = {"tag", "server", "remote_addr", "time", "request", "status", "body_bytes_sent", "bytes_sent", "sent_http_content_length", "HIT", "host", "http_user_agent", "http_referer", "http_range","request_time","upstream_http_via", "http_x_forwarded_for", "x_real_host", "upstream_addr","bill_status","upstream_response_time","upstream_header_time","upstream_connect_time","connection"} 
    my_log_tab["tag"] = "NEWCDN"
    my_log_tab["server"] = log_tab["server"] 
    my_log_tab["remote_addr"] = log_tab["remote_addr"] 
    my_log_tab["time"] = log_tab["time"] 
    my_log_tab["request"] = log_tab["request"] 
    my_log_tab["status"] = log_tab["status"] 
    my_log_tab["body_bytes_sent"] = log_tab["body_bytes_sent"] 
    my_log_tab["bytes_sent"] = log_tab["bytes_sent"] 
    my_log_tab["sent_http_content_length"] = log_tab["sent_http_content_length"] 
    my_log_tab["HIT"] = log_tab["HIT"]
    my_log_tab["host"] = log_tab["host"] 
    my_log_tab["http_user_agent"] = log_tab["http_user_agent"] 
    my_log_tab["http_referer"] = log_tab["http_referer"] 
    my_log_tab["http_range"] = log_tab["http_range"]
    my_log_tab["request_time"] = log_tab["request_time"] 
    my_log_tab["upstream_http_via"] = log_tab["upstream_http_via"] 
    my_log_tab["http_x_forwarded_for"] = log_tab["http_x_forwarded_for"] 
    my_log_tab["x_real_host"] = log_tab["x_real_host"]
    my_log_tab["upstream_addr"] = log_tab["upstream_addr"] 
    my_log_tab["bill_status"] = "B1"
    my_log_tab["upstream_response_time"] = log_tab["upstream_response_time"] 
    my_log_tab["upstream_header_time"] = log_tab["upstream_header_time"] 
    my_log_tab["upstream_connect_time"] = log_tab["upstream_connect_time"] 
    my_log_tab["connection"] = log_tab["connection"] 

    local log_str = ""
    for _, i in ipairs(my_log_tab) do
      --ngx.log(ngx.ERR, "test_log_str4:", i)
      log_str = log_str .. "\"" .. my_log_tab[i] .. "\" "
    end
    --ngx.log(ngx.ERR, "test_log_str1: ", log_str)

    local udpsock = socket.udp()
    udpsock:setsockname(upload_bind_ip, upload_bind_port)
    udpsock:sendto(log_str, upload_ip, upload_port)
end

if ngx.get_phase() == "body_filter" then
    local key = ngx.var.connection .. ngx.var.request_uri
    local sync_key = key .. "update_flag"

    local sync_data = hntv_report:get(sync_key)
    if sync_data == nil then
        --ngx.log(ngx.ERR, "test_sync_data_is_nil:", sync_key)
        ngx.ctx.bytes_sent = ngx.var.header_size
        ngx.ctx.body_bytes_sent = 0

        local base_time = time

        local ok, err = ngx.timer.at(report_interval, timer_handler, key, sync_key, base_time)
        if not ok then
            return
        end

        local sync_tab = {}
        sync_tab["update_flag"] = 0
        sync_tab["sync_time"] = time
        local sync_str = cjson.encode(sync_tab) 
        hntv_report:set(sync_key, sync_str, 0)
    end

    if sync_data then
        --ngx.log(ngx.ERR, "test_sync_data_is_ok_in_body:", sync_key)
	local get_sync_tab =  cjson.decode(sync_data)
	if get_sync_tab["update_flag"] == 1 then
           --ngx.log(ngx.ERR, "test_find_update_flag_is_1:", sync_key)
           ngx.ctx.bytes_sent = 0
           ngx.ctx.body_bytes_sent = 0 
           
           local sync_tab = {}
           sync_tab["update_flag"] = 0
	   sync_tab["sync_time"] = get_sync_tab["sync_time"]
           local sync_str = cjson.encode(sync_tab) 
           hntv_report:set(sync_key, sync_str, 0)
        end
    end

    local sent = string.len(ngx.arg[1])
    ngx.ctx.body_bytes_sent = ngx.ctx.body_bytes_sent + sent
    ngx.ctx.bytes_sent = ngx.ctx.bytes_sent + sent

    hntv_report:set(key, json_data_format(), 0)
end

if ngx.get_phase() == "log" then
    local key = ngx.var.connection .. ngx.var.request_uri
    local sync_key = key .. "update_flag"

    ngx.ctx.request_time = tonumber(ngx.var.request_time)
    local sync_data = hntv_report:get(sync_key)
    if sync_data then
        local sync_tab =  cjson.decode(sync_data)
        ngx.ctx.request_time = time*1000 - sync_tab["sync_time"]*1000
    end

    if not ngx.ctx.bytes_sent then
        ngx.ctx.bytes_sent = ngx.var.bytes_sent
        ngx.ctx.body_bytes_sent = ngx.var.bytes_sent
        ngx.ctx.request_time = tonumber(ngx.var.request_time)
    end

    hntv_report:delete(key)
    hntv_report:delete(sync_key)
    report_handler()
end
