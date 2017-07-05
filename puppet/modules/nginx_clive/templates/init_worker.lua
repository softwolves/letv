local http = require("resty.http")

local delay = 10  -- in seconds
local new_timer = ngx.timer.at
local log = ngx.log
local ERR = ngx.ERR

local function get_lock(delay)
    local status_report = ngx.shared.status_report

    local ok, err = status_report:add("status_report_lock", true, delay - 0.001)
    if not ok then
        if err == "exists" then
            return nil
        end
        log(ERR, "failed to add status_report_lock: ", err)
        return nil
    end
    return true
end

status_report_func = function(premature)
    if not premature then
        local ok, err = new_timer(delay, status_report_func)

        if not ok then
            log(ERR, "failed to create timer: ", err)
            return
        end
        
        if not get_lock(delay) then
            return
        end

        local sock = ngx.socket.tcp()
        local ok, err = sock:connect("127.0.0.1", 80)

        if not ok then
            log(ERR, "failed to connect: ", err)
            return
        end

        local req = "GET /local_ips HTTP/1.0\r\nHost: localhost\r\nConnection: close\r\n\r\n"
        local bytes, err = sock:send(req)

        if not bytes then
           log(ERR, "failed to send request: ", err)
           sock:close()
           return
        end

        while true do
            local line, err, part = sock:receive()
            if line then
                -- log("received: ", line)
            else
                -- ngx.say("failed to receive a line: ", err, " [", part, "]")
                break
            end
        end
        sock:close()

        local sock = ngx.socket.udp()
        local ok, err = sock:setpeername("report.gslb.letv.com", 8123)
        if not ok then
            log("failed to connect to gslb: ", err)
            sock:close()
            return
        end

        local status_report = ngx.shared.status_report
        local status_data_keys = {"local_ips", "nband", "hband", "ngx_stat_writing", "load", "wget", "pull_num", "push_num", "hls_creater"}
        local status_data_vals = { }

        for _, key in ipairs(status_data_keys) do
            local val = status_report:get(key)
            val = (val and val) or 0
            table.insert(status_data_vals, val)
       end

        sock:send(table.concat(status_data_vals, ","))
	sock:close()


-- new report to gslb agent--------------
        local hc = http:new()
        local res, err = hc:request_uri("http://report.g5.letv.cn/report/heartbeat", {
                method = "POST",
                body = table.concat(status_data_vals, ","),
            })
        ngx.log(ngx.ERR, "status: ", res.status)

    end
end

local ok, err = new_timer(delay, status_report_func)
if not ok then
    log(ERR, "failed to create timer: ", err)
    return
end
