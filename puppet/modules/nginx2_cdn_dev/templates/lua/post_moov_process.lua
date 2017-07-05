-- libs
local math = require "math"
local http = require "resty.http"

-- request info
local ngx_log = ngx.log
local ngx_var = ngx.var
local scheme = ngx_var.scheme
local server_addr = ngx_var.server_addr
local uri = ngx_var.uri
local server_port = ngx_var.server_port
local args = ngx.req.get_uri_args()
local query_args = ngx_var.is_args .. ngx_var.args
local host = ngx_var.http_host
local slice_location_prefix = ngx_var.slice_location_prefix
local target_request_uri = ngx.ctx.target_request_uri
local target_uri = scheme .. "://" .. server_addr .. ":" .. server_port
                   .. slice_location_prefix .. target_request_uri
-- get valid range of mdat
local start_offset = ngx_var.mp4_start_offset
local end_offset = ngx_var.mp4_end_offset

if not start_offset or not end_offset or tonumber(start_offset) > tonumber(end_offset) then
  ngx_log(ngx.ERR, "invalid start_offset or end_offset")
  return ngx.exit(500)
end

local httpc = http.new()
httpc:set_timeout(5000)
httpc:connect(server_addr, server_port)
local res, err = httpc:request{
  path = slice_location_prefix .. target_request_uri, 
  headers = {
    ["Host"] = host,
    ["Range"] = "bytes=" .. start_offset .. "-" .. end_offset - 1, 
    ["X-LeCloud-Conhash"] = X_LeCloud_Conhash,
  }
}

if not res then
  ngx.say("failed to request: ", err)
  return 
end

ngx.print(ngx_var.mp4_new_moov_mdat_atom)
ngx.flush(true)
local moov_sent = 0
local reader = res.body_reader
repeat
  local chunk, err = reader(524288)
  if err then
    ngx_log(ngx.ERR ,err)
  end

  if chunk then
    ngx.print(chunk)
    ngx.flush(true)
  end
until not chunk

httpc:set_keepalive()
