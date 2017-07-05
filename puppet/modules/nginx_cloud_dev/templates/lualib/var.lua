local socket = require("socket")

local _M = {}

function _M.init_var(request)
    return true
end

local function gethostname()
    return socket.dns.gethostname()
end

_M.hostname = gethostname()

return _M

