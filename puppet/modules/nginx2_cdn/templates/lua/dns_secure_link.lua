local f3tm   = tonumber(ngx.var.arg_f3tm)
local key    = ngx.var.key
local f3key  = ngx.var.arg_f3key
local uri    = ngx.var.uri
local time   = tonumber(ngx.time())

if f3tm == nil or f3key == nil then
    ngx.var.secure_link_v2_log = "args_error"
    ngx.exit(403)
end

if key == nil then
    return
end

if f3tm  < time then
    ngx.var.secure_link_v2_log = "timeout"
    ngx.exit(403)
end

local string = ngx.md5(key .. uri .. tostring(f3tm))
if string ~= f3key then
    ngx.var.secure_link_v2_log = "md5error"
    ngx.exit(403)
end

ngx.var.secure_link_v2_log = "ok"

return


