local dict = ngx.shared.hls_report
local dict_stat = ngx.shared.hls_report_stat

local sip = ngx.var.server_addr
local cip = ngx.var.remote_addr
local uuid = ngx.var.connection
local streamid = ngx.var.stream_id
local bytes_sent = ngx.var.bytes_sent
local request_time = ngx.var.request_time

local regex = [[((\d+\.){3})\d+]]

local m = ngx.re.match(sip, regex)
local n = ngx.re.match(cip, regex)

if m and n then
    if m[1] == n[1] then
        return
    end
end

if string.len(ngx.var.stream_id) == 0 then
    streamid  = ngx.var.upstream_http_stream_id
end

local key = "streamid=".. streamid.."&cip="..cip.."&sip="..sip
local ok, err = dict:incr(key, bytes_sent)

if not ok then
    local ok, err, forcible = dict:add(key, tonumber(bytes_sent), 0)
end

if ngx.status >= 500 and ngx.status < 600 then
    local ok, err = dict_stat:incr(key.."xx5", 1)
    if not ok then
        local ok, err, forcible = dict_stat:add(key.."xx5", 1, 0)
    end
end


if tonumber(request_time) >= 3 then
    local ok, err = dict_stat:incr(key.."t3", 1)
    if not ok then
        local ok, err, forcible = dict_stat:add(key.."t3", 1, 0)
    end
end


if tonumber(request_time) < 3 then
    local ok, err = dict_stat:incr(key.."t0", 1)
    if not ok then
        local ok, err, forcible = dict_stat:add(key.."t0", 1, 0)
    end
end

