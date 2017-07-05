local hls_creater = ngx.var.arg_creaternum
local status_report = ngx.shared.status_report

if hls_creater then
    status_report:set("hls_creater", hls_creater)
end

ngx.say("hls_creater: ", hls_creater)
