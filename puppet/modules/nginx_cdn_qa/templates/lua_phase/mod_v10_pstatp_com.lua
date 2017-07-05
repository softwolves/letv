local _M = {}

function _M.access_handler(req)
    local regex = [[/([^/]+)/([^/]+)(/.*)]]
    local m = ngx.re.match(ngx.var.uri, regex)
    if not m then
       ngx.exit(404)
    end
    local token = m[1]
    local hex_time = "0x" .. m[2]
    local real_path = m[3]
    ngx.log(ngx.ERR, "jinritoutiao hex_time: ", hex_time)
    local time = tonumber(string.format("%d", hex_time))
    if time + 3600 < ngx.time() then
        ngx.log(ngx.ERR, "jinritoutiao timeout")
        ngx.exit(403)
    end
    
    if ngx.md5("bytedance-letv" .. real_path .. string.sub(hex_time, 3, string.len(hex_time))) ~=  token then
        ngx.log(ngx.ERR, "jinritoutiao md5sum", "bytedance-letv" .. real_path .. hex_time, "----", token)
        ngx.exit(403)
    end

    ngx.req.set_uri(real_path)   
    ngx.var.cohash_key = real_path
end

return _M
