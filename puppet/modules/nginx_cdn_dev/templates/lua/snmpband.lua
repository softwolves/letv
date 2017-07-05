local nband = ngx.var.arg_nband
local hband = ngx.var.arg_hband
local status_report = ngx.shared.status_report

if hband then
    status_report:set("hband", hband)
end

if nband then
    status_report:set("nband", nband)
end

status_report:set("load", 0);
status_report:set("wget", 0);

ngx.say("hband: ", hband)
ngx.say("nband: ", nband)
