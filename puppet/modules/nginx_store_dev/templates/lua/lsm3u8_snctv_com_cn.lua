local table_maxn = table.maxn
local table_concat = table.concat
local string_find = string.find
local string_format = string.format
local string_gsub = string.gsub
local string_len = string.len

local request_uri = ngx.var.request_uri
local uri = ngx.var.uri
local is_args = ngx.var.is_args

local m3u8_request_uri = "/lecloud/inner" .. ngx.var.request_uri
local res = ngx.location.capture(m3u8_request_uri)
if res.status ~= 200 then ngx.log(ngx.ERR, "can't get original m3u8 file") return ngx.exit(res.status) end
local m3u8_content = res.body

local func = function (m)
    local str = ""
    if ngx.var.args then
        str = "http://".. ngx.var.http_host .. m[2]  .. "&lecloud_src=" .. m[1] .. "\n"
    else
        str = "http://".. ngx.var.http_host .. m[2] .. "?lecloud_src=" .. m[1] .. "\n"
    end
    return str
end

result_string = ngx.re.gsub(m3u8_content, "http://([^/]+)([^\\n]+)(\\n)", func, "imx")

local content_length = string_len(result_string)
ngx.header["Content-Length"] = content_length
return ngx.print(result_string)
