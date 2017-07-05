local pantm    = ngx.var.arg_pantm
local panuid   = ngx.var.arg_panuid
local pantoken = ngx.var.arg_pantoken
local splatid  = ngx.var.arg_splatid
local key      = "dsaf;sdakf24rwr0#@#$fdasf145" 
local uri      = ngx.var.uri
local curtime  = ngx.time()

local str = ngx.re.sub(uri, "/coopcdn/cloud.gslb.letv.com(/.*/.*)", "$1")
ngx.log(ngx.ERR, "scw: ", str)

if pantm and panuid and pantoken and splatid then
	if tonumber(pantm) < curtime then
		ngx.var.secure_link_v2_log = "timeout"
		ngx.exit(403)
	end

	if key == nil then
		return 
	end
	
	local md5_str = string.format("%s,%s,%s,%s,%s", str, splatid, pantm, panuid, key)
	local md5 = ngx.md5(md5_str)
	ngx.log(ngx.ERR, "scw: ", md5_str, " md5: ", md5, " pantoken: ", pantoken)
	if md5 ~= pantoken then
		ngx.var.secure_link_v2_log = "md5error"
		ngx.exit(403)
	end
	return
end

ngx.var.secure_link_v2_log = "args_error"
ngx.exit(403)
