local _M = {}

function _M.access_handler(req)
    local regex = [[/([^/]+)/([^/]+)(/.*)]]
    local m = ngx.re.match(ngx.var.uri, regex)
    if not m then
       ngx.exit(404)
    end

    if m[1] == "slice" then
      regex = [[/slice/([^/]+)/([^/]+)(/.*)]]
      m = ngx.re.match(ngx.var.uri, regex)
      if not m then
        ngx.exit(404)
      end
    end

    local token = m[1]
    local hex_time = "0x" .. m[2]
    local real_path = m[3]
    ngx.log(ngx.ERR, "yy hex_time: ", hex_time)
    local time = tonumber(string.format("%d", hex_time))
    if time < ngx.time() then
        ngx.log(ngx.ERR, "yy timeout")
        ngx.exit(403)
    end

    if ngx.md5("yy200504cdGyao@35E#Mf5TrEE" .. m[2] .. ngx.var.http_host .. real_path) ~=  token then
        ngx.log(ngx.ERR, "yy md5sum", "yy200504cdGyao@35E#Mf5TrEE" .. m[2] .. ngx.var.http_host ..real_path , "----", token)
        ngx.exit(403)
    end

    --ngx.req.set_uri(real_path) 
    --ngx.var.cohash_key = real_path
end

return _M
