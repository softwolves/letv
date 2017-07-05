local cjson = require "cjson"
local args = ngx.req.get_uri_args() 

local value = ngx.shared.black_list:get("black_list");

if value == nil then
	return 	
end
value = cjson.decode(value)
for k, v in pairs(value) do
	if args["splatid"] == k then
		for k2, v2 in pairs(v) do
			for k3, v3 in pairs(v2) do
				if args[k2] == v3 then
					ngx.exit(403)
				end
			end
		end
		--[[if args[k2] == v2 then
				ngx.exit(403)
		end]]
	end
end 

