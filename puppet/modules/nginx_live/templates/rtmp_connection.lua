local pull_num = ngx.var.arg_pull_num
local push_num = ngx.var.arg_push_num
local interval = ngx.var.arg_interval

local status_report = ngx.shared.status_report

local pull_num_pre = status_report:get("pull_num")
local push_num_pre = status_report:get("push_num")
local pull_num_stale = status_report:get("pull_num_stale")
local push_num_stale = status_report:get("push_num_stale")

pull_num_pre =  (pull_num_pre and pull_num_pre) or 0
push_num_pre =  (push_num_pre and push_num_pre) or 0

if  tonumber(pull_num_pre) < tonumber(pull_num) or pull_num_stale == nil  then
    status_report:set("pull_num", pull_num, interval)
    status_report:set("pull_num_stale", 1, 45)
end

if  tonumber(push_num_pre) < tonumber(push_num) or push_num_stale == nil  then
    status_report:set("push_num", push_num, interval)
    status_report:set("push_num_stale", 1, 45)
end

ngx.say("pull_num: ", pull_num)
ngx.say("push_num: ", push_num)
ngx.say("interval: ", interval)

