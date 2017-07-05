local cjson = require("cjson")

local user = {
  fcheck    = 403, --default 403
  splatid   = nil,
  cde       = nil,
  uri       = ngx.var.uri,
  status    = 0,    --default 0
  arg1      = ngx.arg[1] or nil ,
  stream_id = nil
}
local Strategy ={}

function init(user)
  if ngx.var.arg_fcheck ~= nil  then
     user.fcheck = tonumber(ngx.var.arg_fcheck)
  else
     ngx.log(ngx.ERR, "fcheck is nil")
  end

  if ngx.var.arg_splatid ~= nil  then
     user.splatid = tonumber(ngx.var.arg_splatid)
  else
     ngx.log(ngx.ERR, "splatid is nil")
  end

  if ngx.var.arg_cde ~= nil  then
     user.cde = tonumber(ngx.var.arg_cde)
  end

  if ngx.var.arg_stream_id ~= nil  then
     user.stream_id = ngx.var.arg_stream_id
  end

end

--在17:00-22:59:59区间内
function effect_time() 
  local cur_time = ngx.localtime()
  _, _, hour, min, sec = string.find(cur_time, "(%d%d):(%d%d):(%d%d)")
  --ngx.log(ngx.ERR,"hour: ", hour)
  if hour == nil then
    return 
  end
  if tonumber(hour) >= 17 and tonumber(hour) <=22 then
    return true
  end 
  return false
end

--在18:30-23:30:59区间内
function effect_time2()
  local cur_time = ngx.localtime()
  _, _, hour, min, sec = string.find(cur_time, "(%d%d):(%d%d):(%d%d)")
  if hour == nil or min == nil then
    return
  end

  local start_time = 18*3600+30*60
  local end_time = 23*3600+30*60
  local loc_time = hour*3600+min*60
  if loc_time >= start_time and loc_time <= end_time then
    return true
  end
  return false
end

--cde版本是否大于等于1024
function cde_check(cde_version)
  local cde_version = cde_version or 1024
  if  cde_version - 1024 == 0 then
     return true
  end

  return false
end

--流量控制
function flowrate_control(user, min, max) 
  local min = min or 50
  local max = max or 120
  math.randomseed(tostring(ngx.time()):reverse():sub(1, 6))  
  local r = math.random(min, max)
  ngx.var.limit_rate = r .. "k"
 -- ngx.log(ngx.ERR, "limit rate ", r, "k")
  return "ok"
end

function IsCCTV(stream_id)
  if stream_id == nil then return end
  local k, v = string.match(stream_id, "cctv(.*)")
  if k ~= nil then
    return true
  end
end

function IsSatelliteTV(stream_id)
  if stream_id == nil then return end
  local k1, v = string.match(stream_id, "zhejiang(.*)")
  local k2, v = string.match(stream_id, "ws_hunanws(.*)")
  local k3, v = string.match(stream_id, "jiangsu(.*)")
  local k = k1 or k2 or k3
  if k ~= nil then
    return true
  end
end

function  Strategy.Chaojishipin()
   if not effect_time() then
     return
   end
   if user.splatid ~= 1060201002 then
     return
   end
   if not IsCCTV(user.stream_id) then
     return
   end
   return  flowrate_control(user, 0, 120)
end

function  Strategy.SuperLive()
  if not effect_time2() then
    return
  end
  if user.splatid ~= 1036 and user.splatid ~=1048 then
    return
  end
  if not IsSatelliteTV(user.stream_id) and not IsCCTV(user.stream_id)then
    return
  end
  if cde_check(user.cde) then
    return 
  end
  return  flowrate_control(user, 0, 25)
end

function  Strategy.Tvapk()
  if not effect_time2() then
    return
  end
  if user.splatid ~= 1011 then
    return
  end
  if not IsSatelliteTV(user.stream_id) and not IsCCTV(user.stream_id)then
    return
  end
  if user.cde == 1025 or user.cde == 1036 then
    return 
  end
  return  flowrate_control(user, 0, 25)
end

function  Strategy.QspTv()
  if user.splatid ~= 1014 then
    return
  end
  if user.cde ==1022 then
    return
  end
    return  "Strategy_qsptv"
end

function Strategy.OtherStream()
  local sp = user.splatid
  if sp == 1011 or sp == 1014 or sp == 1036 or sp == 1048 or sp == 1012 then
    return
  end
  if not IsSatelliteTV(user.stream_id) and not IsCCTV(user.stream_id)then
    return
  end
    return "Strategy_OtherStream"
end

function main()
  init(user)
  local flag_flowrate_control = true
 
  if not flag_flowrate_control then
    return 
  end

  if user.fcheck == 403 or user.fcheck == "2" then
     return 
  end 

  if ngx.var.arg_keep_stopp ~= nil or ngx.var.arg_splatid == nil then
    return
  end

  local s1 = Strategy.Chaojishipin()
  local s2 = Strategy.SuperLive()
  local s3 = Strategy.Tvapk()
  local s4 = Strategy.QspTv()

  local s = s1 or s2 or s3 or s4 or "ok"

return s
end

--Main----------------
return main() or "ok"
