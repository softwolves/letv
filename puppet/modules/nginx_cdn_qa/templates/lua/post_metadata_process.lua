-- libs
local math = require "math"
local http = require "resty.http"

-- request info
local ngx_log = ngx.log
local ngx_var = ngx.var
local scheme = ngx_var.scheme
local server_addr = ngx_var.server_addr
local server_port = ngx_var.server_port
local host = ngx_var.http_host
local slice_location_prefix = ngx_var.slice_location_prefix
local target_request_uri = ngx.ctx.target_request_uri
local target_uri = scheme .. "://" .. server_addr .. ":" .. server_port
                   .. slice_location_prefix .. target_request_uri

local httpc = http.new()
httpc:set_timeout(5000)

local drag = ngx_var.drag

if drag == "bytes_drag" then
  local start = ngx_var.arg_start
  if start == nil then
    start = 0
  end

  httpc:connect(server_addr, server_port)
  local res, err = httpc:request{
    path = slice_location_prefix .. target_request_uri, 
    headers = { 
    ["Host"] = host,
    ["Range"] = "bytes=" .. start .. "-",  
    }
  }

  if not res then
    ngx.say("failed to request: ", err)
    return 
  end

  --ngx.print("FLV\01\05\0\0\0\09\0\0\0\0")
  ngx.print(ngx_var.flv_header .. ngx_var.flv_video_tag .. ngx_var.flv_audio_tag)
  ngx.flush(true)

  local moov_sent = 0 
  local reader = res.body_reader
  repeat
    local chunk, err = reader(5242)
    if err then
      ngx_log(ngx.ERR ,err)
    end 

    if chunk then
      ngx.print(chunk)
      ngx.flush(true)
    end 
  until not chunk

  return 
end

-- get valid range of mdat
local start_offset = ngx_var.flv_start_offset
local end_offset = ngx_var.flv_end_offset

if not start_offset or not end_offset or tonumber(start_offset) > tonumber(end_offset) then
  ngx_log(ngx.ERR, "invalid start_offset or end_offset")
  return ngx.exit(500)
end

httpc:connect(server_addr, server_port)
local res, err = httpc:request{
  path = slice_location_prefix .. target_request_uri, 
  headers = {
    ["Host"] = host,
    ["Range"] = "bytes=" .. start_offset .. "-" .. end_offset - 1, 
  }
}

if not res then
  ngx.say("failed to request: ", err)
  return 
end

ngx.print(ngx_var.flv_header .. ngx_var.flv_new_meta ..  ngx_var.flv_video_tag .. ngx_var.flv_audio_tag)
ngx.flush(true)
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
