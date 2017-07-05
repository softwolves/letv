local local_ips = ngx.var.local_ips_var
local status_report = ngx.shared.status_report
status_report:set("local_ips", local_ips)
status_report:set("ngx_stat_writing", ngx.var.connections_writing)
status_report:set("load", ngx.var.sys_load)

ngx.say("local_ips: ", local_ips)
ngx.say("ngx_stat_writing: ", ngx.var.connections_writing)
ngx.say("load", ngx.var.sys_load)

