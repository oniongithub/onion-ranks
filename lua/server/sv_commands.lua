concommand.Add("onion_setrank", function(ply, command, args)
    if (not ply:IsSuperAdmin()) then return end
    local target = player.GetBySteamID64(args[1])
    local rank = args[2]

    if (not target) then return ply:ChatPrint("Please enter a valid SteamID64.") end

    if (rank and target:SetRank(rank)) then
        ply:ChatPrint("Successfully set the rank of " .. target:Nick() .. ".")
    else
        ply:ChatPrint("Failed to set the rank of " .. target:Nick() .. ".")
    end
end)

concommand.Add("onion_getrank", function(ply, command, args)
    if (not ply:IsSuperAdmin() or not args[1] or type(args[1]) ~= "string") then return end
    local target = player.GetBySteamID64(args[1])

    if (not target) then return ply:ChatPrint("Please enter a valid SteamID64.") end

    ply:ChatPrint("Rank: " .. target:GetNWRank())
end)