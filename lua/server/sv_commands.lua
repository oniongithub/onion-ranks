concommand.Add("onion_setrank", function(ply, command, args)
    if (not ply:IsSuperAdmin()) then return end

    if (ors.update_rank(ors.get_steamid(args[1]), args[2])) then
        ply:ChatPrint("Successfully set the rank of " .. args[1] .. ".")
    else
        ply:ChatPrint("Failed to set the rank of " .. args[1] .. ".")
    end
end)

concommand.Add("onion_getrank", function(ply, command, args)
    if (not ply:IsSuperAdmin() or not args[1] or type(args[1]) ~= "string") then return end

    ply:ChatPrint("The rank of " .. args[1] .. " is " .. ors.get_player_rank(ors.get_steamid(args[1])))
end)