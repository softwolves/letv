local url = require "net.url"
local unescape_uri = ngx.unescape_uri

local arg_url = ngx.var.arg_url


local location = unescape_uri(arg_url)
local u = url.parse(location)
local host = u.host;
local query = u.query;
local path = u.path


ngx.var.key = path
ngx.var.filename = "/letv/fet/imgo" .. path
