local _M = {}

function _M.access_handler(req)
    local regex = [[/([^/]+)/([^/]+)(/.*)]]
    local m = ngx.re.match(ngx.var.uri, regex)
    if not m then
       ngx.exit(403)
    end
    local token = m[1]
    local hex_time = "0x" .. m[2]
    local real_path = m[3]
    local url_regex =  [[\.(sb|hb)$]]
    ngx.log(ngx.ERR, "ottvideoyd.hifuntv.com hex_time: ", hex_time)
    local time = tonumber(hex_time)
    if not time then
        ngx.exit(403)
    end
    if time + 14400 < ngx.time() then
        ngx.log(ngx.ERR, "ottvideoyd.hifuntv.com timeout")
        ngx.exit(403)
    end
    
    if ngx.md5(ngx.var.secure_key .. real_path .. string.sub(hex_time, 3, string.len(hex_time))) ~=  token then
        ngx.log(ngx.ERR, "md5sum ---", ngx.var.secure_key .. real_path .. string.sub(hex_time, 3, string.len(hex_time)), "----", token)
        ngx.exit(403)
    end

    local url_m = ngx.re.match(ngx.var.uri, url_regex)
    
    if url_m and not ngx.var.args then
        ngx.exit(403)
    end

    ngx.req.set_uri(real_path)   
    ngx.var.cohash_key = real_path
end

return _M
