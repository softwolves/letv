local black_list = ngx.shared.black_list

local _, args = string.find(ngx.var["request_uri"],"?")

ngx.log(ngx.ERR, "ngx request uri: ", string.sub(ngx.var["request_uri"], args + 1))

res = ngx.location.capture("/live/secure/report_tokens_ip_proxy?"..string.sub(ngx.var["request_uri"], args + 1))

if res.status ~= 200 then
        ngx.log(ngx.ERR, "report_tokens_ip_proxy error", res.status);
end

local value, flags = black_list:get("refresh_tokens_black_list")

if not value then
	ngx.say("OK")
	return
end
ngx.say("not ok")
black_list:delete("refresh_tokens_black_list")
local res = ngx.location.capture("/live/secure/get_tokens_black_list_proxy")
ngx.say(res.body)
black_list:set("black_list", res.body)
