local dict = ngx.shared.r2h_report

local sip = ngx.var.server_addr
local cip = ngx.var.remote_addr
local uuid = ngx.var.connection
local streamid = ngx.var.stream_id
local connecttime = os.date("%Y%m%d%H%M", ngx.req.start_time())

if ngx.status ~= 200 and ngx.status ~= 206 then
    return
end

local key = "streamid=".. streamid.."&cip="..cip.."&sip="..sip .."&uuid=".. uuid.."&connect-time="..connecttime
local value = string.len(ngx.arg[1])

local ok, err = dict:incr(key, value)

if not ok then
    local ok, err, forcible = dict:add(key, value, 0)
end


