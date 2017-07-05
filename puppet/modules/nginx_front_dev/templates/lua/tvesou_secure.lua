local request = "/auth_request?"
local uri = ngx.var.uri

uri = string.gsub(uri, "/", "%%2")

request = request .. "__path=" .. uri .. "&" .. ngx.var.args

local res = ngx.location.capture(request)
if res.status ~= 200 then
	ngx.log(ngx.ERR, "test2: ", request, " status: ", res.status)
	ngx.exit(403)
end

return 
