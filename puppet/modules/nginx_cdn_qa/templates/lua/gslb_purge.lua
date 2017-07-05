local stream_id = ngx.var.streamid
local gslb_cache = ngx.shared.live_gslb_cache
gslb_cache:delete(stream_id)
ngx.say("OK")


