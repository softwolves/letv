local url = require "net.url"

local leorgurl =  ngx.unescape_uri(ngx.var.arg_leorgurl)
local url = url.parse(leorgurl)

local from, to, err = ngx.re.find(url.path, "[^/]+$", "jo")

local src = string.sub(url.path, from, to - string.len("_playlist.m3u8"))

if not ngx.ctx.m3u8 then
    ngx.ctx.m3u8 = ""
end

if not ngx.arg[2] then
    ngx.ctx.m3u8 = ngx.ctx.m3u8 .. ngx.arg[1]
    ngx.arg[1] = nil
    return
end

ngx.ctx.m3u8 = ngx.ctx.m3u8 .. ngx.arg[1]

local line = -1
local func = function(m) 
    line = line + 1
    -- return m[1] .. src .. line .. m[3]
    return m[1] .. src .. "_" .. string.format("%04d", line) .. ".ts" .. "?leorgurl=" .. m[2] .. "&" ..  m[3] .. "\n"
end

local newstr = ngx.re.gsub(ngx.ctx.m3u8, "(.*ver_00.*_mp4/)(ver_00.*\\.ts)\\?(.*)\n", func)

ngx.arg[1] = newstr

