local url = require "net.url"
local unescape_uri = ngx.unescape_uri
local escape_uri = ngx.escape_uri

local arg_url = ngx.var.arg_durl

local location = unescape_uri(arg_url)
local u = url.parse(location)
local host = u.host
local query = u.query
local path = u.path


if ngx.var.arg_call == 0  then
    return 
end


local m3u8_url = u.scheme .. "://" ..  host .. path .. "/playlist.m3u8" 

local start ,_ = string.find(location, "?")

if query then
    m3u8_url = m3u8_url .. string.sub(location, start)
end

local m3u8_url_escape = escape_uri(m3u8_url)
local filename = "/letv/fet/imgo/ts" .. path .. "/playlist.m3u8"

local res = ngx.location.capture("/api/addfile", 
                { args = "durl=" .. m3u8_url_escape .. "&outkey=" .. ngx.var.arg_outkey .. "&file=" .. filename .. "&call=0" })

