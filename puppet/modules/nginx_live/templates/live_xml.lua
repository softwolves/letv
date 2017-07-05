local string = require "string"

local tm = ngx.var.arg_abstimeshift
local ms = ngx.var.arg_mslice
local uri = ngx.var.uri
local prefix = "/letv/fet/live/leflv/"
local loop = 0

local mon = {
        ["Jan"] = "1",
        ["Feb"] = "2",
        ["Mar"] = "3",
        ["Apr"] = "4",
        ["May"] = "5",
        ["Jun"] = "6",
        ["Jul"] = "7",
        ["Aug"] = "8",
        ["Sep"] = "9",
        ["Oct"] = "10",
        ["Nov"] = "11",
        ["Dec"] = "12"
}


function xml_string_parse(filename)
        local file, err= io.open(filename)
        if not file then
                ngx.log(ngx.ERR, "xml_string_parse: ", err)
                return nil
        end

        local data = ""
        local result = {}
        local i = 1
        local count = 1
        for line in file:lines() do
                if string.find(line, "<header", 0) then
                        line = string.gsub(line, ">", " />")
                        result[i] = line.. "\r\n"
                        i = i + 1
                end

                if (string.find(line, "<clip", 0)) then
                        data = data .. line .. "\r\n"
                        for line in file:lines() do
                                if (string.find(line, "</clip>", 0)) then
                                        data = data ..line .. "\r\n"
                                        result[i] = data
                                        i = i + 1
                                        data = ""
                                        break
                                end

                                data = data .. line .. "\r\n"
                        end
                end

        end

        file:close()
        return result
end

function get_stream_name()
        local str = nil
        local _, pos = string.find(uri, "leflv/", 0)
        if pos == nil then
                ngx.log(ngx.ERR, "uri error")
                return nil
        end

        last = string.find(uri, "/", pos + 1)
        if last == nil then
                ngx.log(ngx.ERR, "uri error")
                return nil
        end
        str = string.sub(uri, pos + 1, last - 1)
        ngx.log(ngx.DEBUG, "str: ", str)
        return str
end

function dir_file_get(tmstr)
        local day = ngx.re.sub(tmstr, "[A-Z|a-z]+, ([0-9]+) ([A-Z|a-z]+) ([0-9]+) ([0-9]+):([0-9]+):([0-9]+) [A-Z]+", "$1")
        local mon_e = ngx.re.sub(tmstr, "[A-Z|a-z]+, ([0-9]+) ([A-Z|a-z]+) ([0-9]+) ([0-9]+):([0-9]+):([0-9]+) [A-Z]+", "$2")
        local year = ngx.re.sub(tmstr, "[A-Z|a-z]+, ([0-9]+) ([A-Z|a-z]+) ([0-9]+) ([0-9]+):([0-9]+):([0-9]+) [A-Z]+", "$3")
        local hour = ngx.re.sub(tmstr, "[A-Z|a-z]+, ([0-9]+) ([A-Z|a-z]+) ([0-9]+) ([0-9]+):([0-9]+):([0-9]+) [A-Z]+", "$4")
        local min = ngx.re.sub(tmstr, "[A-Z|a-z]+, ([0-9]+) ([A-Z|a-z]+) ([0-9]+) ([0-9]+):([0-9]+):([0-9]+) [A-Z]+", "$5")
        local sec = ngx.re.sub(tmstr, "[A-Z|a-z]+, ([0-9]+) ([A-Z|a-z]+) ([0-9]+) ([0-9]+):([0-9]+):([0-9]+) [A-Z]+", "$6")

        local str = nil
        hour = tonumber(hour) 
        ngx.log(ngx.ERR, "year: ", year, " mon: ", mon[mon_e], " day: ", day, " hour: ", tostring(hour), " sec: ", sec)
        if hour < 10 then
                str = year .. mon[mon_e] .. day .. "0" .. tostring(hour)
        else
                str = year .. mon[mon_e] .. day .. tostring(hour)
        end
        ngx.log(ngx.DEBUG, "str: ", str)
        return str, min, sec
end

function parse_file_name()
        ngx.log(ngx.DEBUG, "tm: ", tm)
        str_name = get_stream_name()
        if str_name == nil then
                return nil
        end
        ngx.log(ngx.DEBUG, "str_name: ", str_name)
        tm = tonumber(tm) 

        local tmstr = ngx.http_time(tm + 28800)
        ngx.log(ngx.DEBUG, "tmstr: ", tmstr)

        local dir ,file, sc = dir_file_get(tmstr)

        local str = prefix .. str_name .. "/" ..dir .. "/"
        return str, file, sc
end

function xml_check(tb) 
	
	local name = tb
	--local str = ngx.re.sub(name, ".*=[0-9]+/([0-9]+)_[0-9]+_[0-9]+.[a-z]+.*", "$1")
        local s, e = string.find(name, "%d+/%d+_%d+_%d+", 0)
	local str = string.sub(name, s, e)
	str = ngx.re.sub(str, "[0-9]+/([0-9]+)_[0-9]+_[0-9]+", "$1")
	ngx.log(ngx.ERR, "scw: ", str)
	local st = tonumber(str)
	local ab = tonumber(tm)

	--ngx.log(ngx.ERR, "tm: ", str, " ab: ", ab, " tb: ", tb)
	if st < ab then
		return false
	end
	return true
end


--Main-----------------
local count = 0
local out = ""
local flag = 1
local header = nil



while count < tonumber(ms) do
	loop = loop + 1
        local file_name, xml_t, sc = parse_file_name()
        if file_name == nil then
                ngx.log(ngx.ERR, "file name get error")
                return
        end


	local xml_tb = xml_string_parse(file_name .. xml_t .. ".xml")
	if not xml_tb then
		break
	end

	local header = ""
	for k, v in pairs(xml_tb) do
		if v ~= nil then
			if string.find(v, "<header", 0) then
				header = v 
			end
			if string.find(v ,"<clip", 0) then
				if xml_check(v) == true then
					out = out .. header
					out = out .. v
					count = count + 1
					header = ""
				end
			end		
			if count >= tonumber(ms) then
				break;
			end
		end
	end

	tm = tostring(tonumber(tm) + 60 - tonumber(sc))			
	if loop >= 10000 then
		return
	end
end 

local length = 0

if out == "" then
	ngx.header.Content_Length = 0
	return 
end

length = string.len("<?xml version=\"1.0\" encoding=\"utf-8\" ?>" .. "<root>" .. out .. "</root>")

length = length + 4

ngx.header.Content_Length = length

ngx.say("<?xml version=\"1.0\" encoding=\"utf-8\" ?>")
ngx.say("<root>")
ngx.say(out)
ngx.say("</root>")

return 

