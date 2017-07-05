if ngx.var.request_method == "PURGE" then 
	local http = require "resty.http"
	local math = require "math"
	local ngx_var = ngx.var
	local scheme = ngx_var.scheme
	local request_uri = ngx_var.request_uri
	local server_addr = ngx_var.server_addr
	local server_port = ngx_var.server_port
	local X_LeCloud_Conhash = ngx.var.http_X_LeCloud_Conhash

	local target_uri = scheme .. "://" .. server_addr .. ":" .. server_port .. request_uri
	local host = ngx_var.http_host

	local httpc = http.new()
	httpc:set_timeout(5000)

	local res, err = httpc:request_uri(target_uri, {
			method = "HEAD",
			headers = {
			["Host"] = host,
			["X-LeCloud-Conhash"] = X_LeCloud_Conhash,
			}
			})

	if not res or (res.status ~= 200 and res.status ~= 206) then
		return res.status
	end

	local content_length = res.headers["Content-Length"]
	if not content_length then
		ngx.say("no find Content-Length in response headers") 
	end 

	ngx.var.lecloud_length_value = content_length;

end
