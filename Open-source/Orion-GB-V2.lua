
--[[
local cloneref = cloneref or loadstring(game:HttpGet("https://raw.githubusercontent.com/exploiter101/MM2/refs/heads/main/Open-source/Orion-GB-V2.lua"))()
local Players = cloneref(game:GetService("Players"))
print(Players)
]]
-- version 1.1
local function cloneref(instance)
	if typeof(instance) ~= "Instance" then
		return instance
	end
	local proxy = newproxy(true)
	local mt = getmetatable(proxy)
	local function safe(func, ...)
		local ok, result = pcall(func, ...)
		return ok and result or nil
	end
	mt.__index = function(_, key)
		local value = safe(function() return instance[key] end)
		if typeof(value) == "function" then
			return function(_, ...) return value(instance, ...) end
		end
		return value
	end
	mt.__newindex = function(_, key, value)
		safe(function() instance[key] = value end)
	end
	mt.__tostring = function()
		return (safe(function() return instance:GetFullName() end) or "Instance")
	end
	mt.__eq = function(_, other)
		return other == instance
	end
	mt.__call = function(_, ...)
		return safe(instance, ...)
	end
	mt.__metatable = "cloneref_protected"
	return proxy
end
return cloneref
