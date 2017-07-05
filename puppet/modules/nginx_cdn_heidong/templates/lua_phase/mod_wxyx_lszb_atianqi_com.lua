local _M = {}

function _M.access_handler(req)
  local cur = ngx.time()
  if (not ngx.var.arg_f3tm) or (not ngx.var.arg_f3key) then
    ngx.exit(403)
  end
  local unix_time = tonumber(ngx.var.arg_f3tm);
  if cur > unix_time then
    ngx.exit(403)
  end
  local md5 =  ngx.md5("snmwxgdchannelqaz324rle" .. ngx.var.uri .. ngx.var.arg_f3tm)
  if md5 ~= ngx.var.arg_f3key then
    ngx.exit(403)
  end
end

return _M
