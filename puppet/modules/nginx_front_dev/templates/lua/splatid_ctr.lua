local pantm    = ngx.var.arg_pantm
local panuid   = ngx.var.arg_panuid
local pantoken = ngx.var.arg_pantoken
local splatid  = ngx.var.arg_splatid
local key      = "dsaf;sdakf24rwr0#@#$fdasf145"
local uri      = ngx.var.uri
local curtime  = ngx.time()
local status   = 0

local function secure_check3()

        local str = string.find(uri, "%.ts", 0)
        if str ~= nil then
                str = string.gsub(uri, "/(.*)_mp4/.*", "%1")
        else
                str = string.gsub(uri, "/(.*)%..*", "%1")
        end

        if pantm and panuid and pantoken and splatid then
		local newpantm = tonumber(pantm) / 100
                if newpantm < curtime then
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
end

local function secure_check2()
	local str = ngx.encode_base64(ngx.var.uri)
	str = "/live/secure/tokens_veirfy?" .. ngx.var.args .. "&letv_filename=" .. str
	str = str .. "&letv_ip=" .. ngx.var.server_addr

	local res = ngx.location.capture(str)
	if res.status == 403 then
		ngx.var.secure_link_v2_log = "token_verify_error"
		ngx.exit(403)
	end 

	return 
end

local function secure_check1()
	local str = ngx.re.sub(uri, "/(.*/.*)", "$1")

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
end


--Main----------------


if ngx.var.arg_fcheck == nil or ngx.var.arg_fcheck == "2" then
	return 
end 

if ngx.var.arg_keep_stopp ~= nil or ngx.var.arg_splatid == nil then
        return
end

if ngx.var.sb_splatid == nil then
	return 
end

for splatid in string.gmatch(ngx.var.sb_splatid, "([^,]+)") do
        if splatid == ngx.var.arg_splatid then
                status = tonumber(splatid)
                break
        end
end

if status == 0 then
	return
end

if status == 1411  then
	secure_check1()
elseif status == 1408 or status == 1409 then
	secure_check3()
else
	secure_check2()
end

return


