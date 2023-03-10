local load = {} load.__index = {}
ors = {} ors.__index = {}
load.server = function(p) if (SERVER) then return include(p) end end
load.client = function(p) if (CLIENT) then return include(p) end AddCSLuaFile(p) end
load.shared = function(p) load.server(p) return load.client(p) end

-- The gLua API contains this function but one is deprecated and one is dev-branch
load.file_start = function(input, start)
    if (input:sub(1, string.len(start)) == start) then
        return true
    end

    return false
end

load.directory = function(dir)
    local files, directories = file.Find(dir .. "/*", "LUA")

    for i, v in pairs(files) do
        local path = dir .. "/" .. v

        if (load.file_start(v, "sv_")) then
            load.server(path)
        elseif (load.file_start(v, "cl_")) then
            load.client(path)
        else
            load.shared(path)
        end
    end
end

load.shared("sh_config.lua")
load.directory("server")

if (SERVER) then
    timer.Simple(0, function() ors.refresh_table() end)
end