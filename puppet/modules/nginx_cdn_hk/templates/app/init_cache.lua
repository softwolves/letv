local lfs = require("lfs")

local mod_dir = "/usr/local/nginx/conf/lua_phase"

for user_config in lfs.dir(mod_dir) do
    if string.find(user_config, "^mod_") then
        local _, _, mod_name = string.find(user_config, "^mod_([^.]+)%.lua$")
        if mod_name and mod_name ~= "" then
            local mod = require(mod_name)
        end
    end
end

