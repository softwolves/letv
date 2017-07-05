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
local uri = ngx_var.uri
local args = ngx.req.get_uri_args()
local ngx_args = ngx_var.args
local host = ngx_var.http_host
local X_LeCloud_Conhash = ngx.var.http_X_LeCloud_Conhash
local slice_location_prefix = ngx_var.slice_location_prefix
local yy_range_location_prefix = ngx_var.yy_range_location_prefix
ngx_var.yy_range_header = args["range"]

-- remove start/end argument for upstream
local target_request_uri = string.gsub(request_uri, "start=[^&]+", "")
target_request_uri = string.gsub(target_request_uri, "end=[^&]+", "")
if yy_range_location_prefix then
  target_request_uri = string.gsub(target_request_uri, "range=[^&]+", "")
end
target_request_uri = string.gsub(target_request_uri, "&+", "&")
target_request_uri = string.gsub(target_request_uri, "?&", "?")
target_request_uri = string.gsub(target_request_uri, "?$", "")
ngx.ctx.target_request_uri = target_request_uri
local target_uri = scheme .. "://" .. server_addr .. ":" .. server_port
                   .. slice_location_prefix .. target_request_uri 

-- gloabal vars
local file_size = 0
local query_start = 0
local query_end = 0
local httpc = http.new()
httpc:set_timeout(5000)

-- flag
local ftyp_done = 0
local moov_done = 0
local mdat_atom_done = 0
local pre_parse_done = 0

local ftyp = ""
local moov = ""
local mdat_atom_header = ""

query_start = args["start"]
query_end = args["end"]

local function bytes_to_int(str,endian,signed)
  local t={str:byte(1,-1)}
  if endian=="big" then
    local tt={}
    for k=1,#t do
        tt[#t-k+1]=t[k]
    end
    t=tt
  end
  local n=0
  for k=1,#t do
    n=n+t[k]*2^((k-1)*8)
  end
  if signed then
    n = (n > 2^(#t*8-1) -1) and (n - 2^(#t*8)) or n
  end
  return n
end

local function ftyp_handler(pos, atom_size, atom)
  local res, err = httpc:request_uri(target_uri, {
    method = "GET",
    headers = {
      ["Host"] = host,
      ["Range"] = "bytes=" .. pos .. "-" .. pos + atom_size - 1,
      ["X-LeCloud-Conhash"] = X_LeCloud_Conhash,
    }
  })

  if not res or (res.status ~= 200 and res.status ~= 206) then
    return res.status
  end

  ftyp = res.body
  pos = pos + atom_size 
  ftyp_done = 1

  return res.status, pos
end

local function moov_handler(pos, atom_size, atom)
  local res, err = httpc:request_uri(target_uri, {
    method = "GET",
    headers = {
      ["Host"] = host,
      ["Range"] = "bytes=" .. pos .. "-" .. pos + atom_size -1,
      ["X-LeCloud-Conhash"] = X_LeCloud_Conhash,
    }
  })  

  if not res or (res.status ~= 200 and res.status ~= 206) then
    return res.status
  end
  moov = res.body
  pos = pos + atom_size
  moov_done = 1

  return res.status, pos
end

local function mdat_atom_handler(pos, atom_size, atom)
  mdat_atom_header = atom
  pos = pos + atom_size
  mdat_atom_done = 1 

  return 200, pos
end

local atom_handler_tbl = {
  ["ftyp"] = ftyp_handler,
  ["moov"] = moov_handler,
  ["mdat"] = mdat_atom_handler,
}

local function get_next_atom_info(pos)
  local res, err = httpc:request_uri(target_uri, {  
    method = "GET",
    headers = {
      ["Host"] = host,
      ["Range"] = "bytes=" .. pos .. "-" .. pos + 15,
      ["X-LeCloud-Conhash"] = X_LeCloud_Conhash,
    }
  })

  if not res then
    ngx.log(ngx.ERR, "request to upstream error: " .. err)
    return
  end

  if res.status ~= 200 and res.status ~= 206  then
    return res
  end

  local atom_size = bytes_to_int(string.sub(res.body, 1, 4), "big")
  if atom_size == 1 then
    atom_size = bytes_to_int(string.sub(res.body, 9, 16), "big")
  end

  local atom_type = string.sub(res.body, 5, 8)

  if file_size == 0 then 
    local content_range = res.headers["Content-Range"]
    if not content_range then
      ngx_log(ngx.ERR, "upstream does not support range request")
      return res
    end
    _, _, file_size = string.find(content_range, "^[^/]+/(.*)$")
  end

  return res, atom_size, atom_type
end

if ngx.var.request_method == "PURGE" then
  local res, err = httpc:request_uri(target_uri, {
    method = "PURGE",
    headers = { 
      ["Host"] = host,
      ["X-LeCloud-Conhash"] = X_LeCloud_Conhash,
    }
  }) 
  
  ngx.exit(res.status)
else
  if yy_range_location_prefix then
    if ngx_var.yy_range_header and (query_start or query_end) then
      ngx_log(ngx.ERR, "invalide params, start or end  and range exist at the same time")
      ngx.exit(400)
    end

    if ngx_var.yy_range_header then
        return ngx.exec(yy_range_location_prefix .. target_request_uri)
    end
  end

  query_start = math.max(tonumber(query_start or 0), 0)
  query_end = tonumber(query_end)

  if query_start == 0 then
    query_start = nil
  end

  if not query_start and not query_end then
    return ngx.exec(slice_location_prefix .. target_request_uri)
  end

  if query_start == nil then
    query_start = 0
  end

  if query_end and query_end < query_start then
    ngx_log(ngx.ERR, "invalide start/end query params")
    ngx.exit(400)
  end

  local current_pos = 0
  local status = 0
  local atom_size = 0
  local atom_type = ""
  local res = {}
  while pre_parse_done == 0 do
    res, atom_size, atom_type = get_next_atom_info(current_pos)
    if not res then
      return ngx.exit(502)
    end

    if not atom_size then
      ngx_log(ngx.ERR, "failed to request to upstream")
      return ngx.exit(res.status)
    end

    if atom_handler_tbl[atom_type] then
      status, current_pos = atom_handler_tbl[atom_type](current_pos, atom_size, res.body)
      if not current_pos then
        ngx_log(ngx.ERR, "faield to request to upstream")
        return ngx.exit(status)
      end 

      if ftyp_done == 1 and moov_done == 1 and mdat_atom_done == 1 then
        pre_parse_done = 1
      end

    else
      current_pos = current_pos + atom_size
    end
  end

  if pre_parse_done ~= 1 then
    ngx_log(NGX.ERR, "Content Format not correct")
    ngx.exit(500)
  end

  ngx_var.mp4_query_start = query_start
  ngx_var.mp4_query_end = query_end
  ngx_var.mp4_ftyp_moov = ftyp .. moov .. mdat_atom_header
  ngx_var.mp4_file_size = file_size
end
