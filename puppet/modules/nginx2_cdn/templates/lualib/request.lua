local _M = {}

local function get_lua_phase(d) 
    if package.loaded[d] then
        return package.loaded[d]
    end

    return nil
end


function _M.init_request()
    local request = {}

    request["uri_args"] = ngx.req.get_uri_args()
    request["headers"] = ngx.req.get_headers()
    request["request_uri"] = ngx.var.request_uri
    request["uri"] = request["request_uri"]
    request["cache_request_uri"] = request["request_uri"]
    request["request_domain"] = ngx.var.host
    request["request_method"] = ngx.var.request_method
    request["server_addr"] = ngx.var.server_addr
    request["remote_addr"] = ngx.var.remote_addr
    request["is_args"] = ngx.var.is_args
    request["scheme"] = ngx.var.scheme
    request["server_port"] = ngx.var.server_port
    request["lua_phase"] = ngx.var.lua_phase
    request["origin_detection_url"] = ngx.var.origin_detection_url
 
    request["args"] = ngx.var.args or ""
    request["lua_phase"] = get_lua_phase(request["lua_phase"])

    if request["args"] ~= "" then
        _, _, request["uri"] = string.find(request["uri"], "([^?]+)?")
    end

    request["cache_url"] = request["scheme"] .. "://" .. request["request_domain"] .. request["request_uri"]

    if ngx.var.ignore_args == "True" then
        request["cache_url"] = request["scheme"] .. "://" .. request["request_domain"] .. request["uri"]
    end

    if request["server_port"] == "16688" then
        request["origin_server"] = true
    end
    
    return request
end


function _M.post_var(request)
    ngx.var.cache_url = request["cache_url"]
    ngx.var.cache_request_uri = request["cache_request_uri"]

    if request["headers"]["X-LeCloud-Host"] then
       ngx.var.bill_status = "B2"
    end
    -- TODO: for gslb support switch
end


function _M.origin_detection_url(request)
    local c = "/" .. request["request_domain"] .. request["origin_detection_url"]
    if c == request["uri"] then
        return true
    end
    return false
end

function _M.check_conhash(request)
    if request["headers"]["X-LeCloud-Conhash"] then
        return false
    end
    return true
end

return _M

