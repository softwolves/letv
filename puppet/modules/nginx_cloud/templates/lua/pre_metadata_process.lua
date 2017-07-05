-- libs
local math = require "math"
local http = require "resty.http"

-- request info
local ngx_log = ngx.log
local ngx_var = ngx.var
local scheme = ngx_var.scheme
local request_uri = ngx_var.request_uri
local server_addr = ngx_var.server_addr
local server_port = ngx_var.server_port
local args = ngx.req.get_uri_args()
local ngx_args = ngx_var.args
local host = ngx_var.http_host
local slice_location_prefix = ngx_var.slice_location_prefix

-- remove start/end argument for upstream
local target_request_uri = string.gsub(request_uri, "start=[^&]+", "")
target_request_uri = string.gsub(target_request_uri, "end=[^&]+", "")
target_request_uri = string.gsub(target_request_uri, "&+", "&")
target_request_uri = string.gsub(target_request_uri, "?&", "?")
target_request_uri = string.gsub(target_request_uri, "?$", "")
target_request_uri = string.gsub(target_request_uri, "&$", "")
ngx.ctx.target_request_uri = target_request_uri
local target_uri = scheme .. "://" .. server_addr .. ":" .. server_port
                   .. slice_location_prefix .. target_request_uri 

-- gloabal vars
local file_size = 0
local query_start = 0
local query_end = 0
local httpc = http.new()
httpc:set_timeout(5000)

if ngx.var.request_method == "PURGE" then
  local res, err = httpc:request_uri(target_uri, {
    method = "PURGE",
    headers = { 
      ["Host"] = host,
    }   
  })  
  
  ngx.exit(res.status)
end

query_start = args["start"]
query_end = args["end"]

local res, err = httpc:request_uri(target_uri, {
  method = "GET",
  headers = {
    ["Host"] = host,
    ["Range"] = "bytes=" .. 0 .. "-" .. 327679,
  }
})

if not res then
  ngx_log(ngx.ERR, "ERR: " .. err) 
end

if res.status ~= 206 and res.status ~= 200 then
  ngx.exit(res.status)
end

local content_range = res.headers["Content-Range"]
if not content_range then
  ngx_log(ngx.ERR, "upstream does not support range request")
  return ngx.exit(500)
end

_, _, file_size = string.find(content_range, "^[^/]+/(.*)$")

if not query_start and not query_end then
  return ngx.exec(slice_location_prefix .. target_request_uri)
end

flv_meta = res.body

query_start = math.max(tonumber(query_start or 0), 0)
query_end = tonumber(query_end)

if query_end and query_end < query_start then
  ngx_log(ngx.ERR, "invalide start/end query params")
  ngx.exit(400)
end

ngx_var.flv_meta = flv_meta
ngx_var.flv_query_start = query_start
ngx_var.flv_query_end = query_end
ngx_var.flv_file_size = file_size
