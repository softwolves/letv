local uri = ngx.var.uri
local uri_len = string.len(uri)
local unit = string.sub(ngx.var.uri, uri_len)
local size = string.sub(ngx.var.uri, 16, uri_len - 1)
local scale = 1

if unit == "K" or unit == "k" then
    scale = 1024
elseif unit == "M" or unit == "m" then
    scale = 1024 * 1024
elseif unit == "G" or unit == "g" then
    scale = 1024 * 1024 * 1024
else
    local size = string.sub(ngx.var.uri, 16, uri_len)
end

size = size * scale
ngx.say(string.rep("0", size))
