local cjson = require "cjson"
local upstream = require "ngx.upstream"

local _M = {}

local get_servers = upstream.get_servers
local get_upstreams = upstream.get_upstreams

local string_find = string.find
local string_len  = string.len

local policy_tab = {random = 1, roundrobin = 0}

local function get_uptream_tab(ups_var, ups_tab, us)
    local seq = 1
    local regex = "(.*)_(.*)_(.*)"
    ups_tab["domain"] = ups_var .. "_" .. "orgin"
    ups_tab["sourcelist"] = { }
    for i , j in pairs(us) do
        local begin, stop = string_find(j , ups_var, 1, true)
        if begin then
            local m = ngx.re.match(j, regex)
            local id = tonumber(m[3])
            ups_tab["sourcelist"][id] = { }
            ups_tab["sourcelist"][id][j] = { }
            local server_tab = get_servers(j)
            ups_tab["policy"] = policy_tab[m[2]]

            for k, srv in pairs(server_tab) do
                local addr = srv["addr"]
                ups_tab["sourcelist"][id][j][k] = { }
                ups_tab["sourcelist"][id][j][k]["hostip"] = addr
                ups_tab["sourcelist"][id][j][k]["status"] = 1
            end
            seq = seq + 1
        end
    end
    return seq
end



function _M.upstream_to_json(host)
   local ups_tab = { }
   local us = get_upstreams()
   local server_name = ngx.var.server_name
   local ups_var = host
 

   if get_uptream_tab(ups_var, ups_tab, us) == 1 then
       return nil
       -- get_uptream_tab("default", ups_tab, us)
   end

   local config = cjson.encode(ups_tab)
   return config
end

function _M.addr_parse(addr)
    local regex = "([0-9]+.[0-9]+.[0-9]+.[0-9]+):([0-9]+)"
    local m = ngx.re.match(addr, regex)
    if not m then
         return addr, nil
    end
    return m[1], m[2]
end

function _M.get_current_upstream(upstream_tab, config, seq, key)
    local ups_tab = cjson.decode(config)
    local sourcelist = ups_tab["sourcelist"]
    local policy = ups_tab["policy"]
    
    local host
    local seq = seq
    
    local ups_size = table.maxn(sourcelist)
    local crc32 = ngx.crc32_long(key)
    local hash = bit.band(bit.rshift(crc32, 16), 0x7fff)

    math.randomseed(os.time())
    
    local start = 1
    
    if policy == 1 then
        start = math.random(ups_size)
    end
    
    for i = 1, ups_size, 1 do
        j = sourcelist[(start + i - 2) % ups_size + 1]

        if not (type(j) == "table") then
            break
        end

        for nodeid, iplist in pairs(j) do
            if (not (type(iplist) == "table")) or table.maxn(iplist) < 1 then
                break
            end
            host = iplist[hash % table.maxn(iplist) + 1]
            ngx.log(ngx.ERR, "le upstream dynamic module: ", host["hostip"])
            if host["status"] == 1 then
                seq = seq + 1
                upstream_tab[seq] = host["hostip"]
            end
        end
    end
    
    for i = 1, ups_size, 1 do
        j = sourcelist[(start + i - 2) % ups_size + 1]

        if not (type(j) == "table") then
            break
        end
        for nodeid, iplist in pairs(j) do
            if (not (type(iplist) == "table")) or table.maxn(iplist) < 1 then
                break
            end
            for k = 1, table.maxn(iplist) - 1, 1 do
                host = iplist[(hash + k)% table.maxn(iplist) + 1]
                if host["status"] == 1 then
                    seq = seq + 1
                    upstream_tab[seq] = host["hostip"]
                end
            end
        end
    end
    return seq
end

function _M.update_upstream_status(config)
    if config and string.len(config) > 0 then
        local ups_tab = cjson.decode(config)
        local server_tab = get_servers("node_backend")
        for k, srv in pairs(server_tab) do
            local ip, port = _M.addr_parse(srv["addr"])
            local host = ups_tab["myhostlist"][k]

            if ip == host["hostip"] then
               upstream.set_peer_down("node_backend", false, k - 1, host["status"] == 0)
               upstream.set_peer_down("ats_node_backend", false, k - 1, host["status"] == 0)
            else
               ngx.log(ngx.ERR, "le dynamic upstream module :", ip , "==", host["hostip"], " is not true")
            end
        end
    end
end

return _M

