local _M = {}

function _M.access_handler(req)
  ngx.var.cdn_src_sec =  ngx.md5(ngx.var.uri .. ngx.var.secure_key)
end

return _M
