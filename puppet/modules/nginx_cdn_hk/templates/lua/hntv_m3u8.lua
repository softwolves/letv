-- basic
local table_maxn = table.maxn
local table_concat = table.concat
local string_find = string.find
local string_format = string.format
local string_gsub = string.gsub
local string_len = string.len

-- request info
local request_uri = ngx.var.request_uri
local uri = ngx.var.uri
local is_args = ngx.var.is_args
local query_string = ngx.var.query_string
local arange = ngx.var.arg_arange or "0"

local m3u8_request_uri = "/arange" .. uri .. is_args .. query_string 
local res = ngx.location.capture(m3u8_request_uri)
if res.status ~= 200 then ngx.log(ngx.ERR, "can't get original m3u8 file") return ngx.exit(res.status) end
local m3u8_content = res.body

function parse_m3u8(m3u8, is_args, query_string)
    local leading_tbl = {}
    local time_tbl = {}
    local size_tbl = {}
    local ts_tbl = {}
    local lines = {}
    local flag = false

    local pattern = string_format("([^%s]+)", "\n")
    local res = string_gsub(m3u8, pattern, function(c) lines[#lines + 1] = c end)

    for i = 1, table_maxn(lines) do
        local line = lines[i]
        if flag == true then
            if is_args ~= "" then
                ts_tbl[#ts_tbl + 1] = string_gsub(line, "_mp4%.ts.*$", "_mp4.ts" .. is_args .. query_string)
            else
                ts_tbl[#ts_tbl + 1] = line
            end
            --ngx.log(ngx.ERR, ts_tbl[#ts_tbl])
            flag = false
        elseif string_find(line, "^#EXTINF") then
            local _, _, duration = string_find(line, "^#EXTINF:([^,]+),$")
            time_tbl[#time_tbl + 1] = duration
            --ngx.log(ngx.ERR, time_tbl[#time_tbl])
            flag = true
        elseif string_find(line, "^#EXT%-MGTV%-File%-SIZE") then
            local _,_,size = string_find(line, "^#EXT%-MGTV%-File%-SIZE:(.*)")
            size_tbl[#size_tbl + 1] = size
        elseif not string_find(line, "#EXT%-X%-ENDLIST") then
              leading_tbl[#leading_tbl + 1] = line
              --ngx.log(ngx.ERR, leading_tbl[#leading_tbl])
        end
    end

    return leading_tbl,size_tbl, time_tbl, ts_tbl
end

local arange_num = tonumber(arange)
if arange_num == nil or arange_num < 0 then return ngx.exit(403) end
local result_string = ""
query_string = string_gsub(query_string, "%%", "%%%%")

-- 1. arange == 0 
-- 2. no arange param in request
if arange_num == 0 then
    result_string = string_gsub(m3u8_content, "_mp4%.ts[^\n]*\n", "_mp4.ts" .. is_args .. query_string .. "\n")
    local content_length = string_len(result_string) 
    ngx.header["Content-Length"] = content_length
    return ngx.print(result_string)
end

local leading_tbl, size_tbl,time_tbl, ts_tbl = parse_m3u8(m3u8_content, is_args, query_string)

local leading_string = table_concat(leading_tbl, "\n")
local ts_tbl_len = table_maxn(ts_tbl)
if ts_tbl_len ~= table_maxn(time_tbl) then
    --ngx.log(ngx.ERR, "parse error: ts and EXTINF not match")
    ngx.exit(500)    
end

local duration_sum = 0
local ts_count = 0
for i = 1, ts_tbl_len do
    if duration_sum >= arange_num then 
        break 
    end
    duration_sum = duration_sum + time_tbl[i]
    ts_count = ts_count + 1
end

if ts_count == 0 then ts_count = ts_tbl_len end

local body_string = ""
if ts_count > 0 then
    for i = 1, ts_count do
        if size_tbl[i] then
            body_string = body_string .. "#EXT-MGTV-File-SIZE:" .. size_tbl[i] .. "\n"
        end
        body_string = body_string .. "#EXTINF:" .. time_tbl[i] .. ",\n" .. ts_tbl[i] .. "\n"
    end
    result_string = leading_string .. "\n" .. body_string .. "#EXT-X-ENDLIST"
end
--ngx.log(ngx.ERR, result_string)
local content_length = string_len(result_string)
ngx.header["Content-Length"] = content_length
ngx.print(result_string)
