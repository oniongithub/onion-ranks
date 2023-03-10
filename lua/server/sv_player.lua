local plyMeta = FindMetaTable("Player")

function plyMeta:GetNWRank()
    return self:GetNWString("onion-ranks", ors.base_rank)
end

function plyMeta:SetNWRank(rank)
    self:SetNWString("onion-ranks", rank)
end

function plyMeta:IsRank(str)
    if (str) then
        return (self:GetNWRank() == str)
    end

    return false
end

function plyMeta:GetRank()
    return ors.get_player_rank(self:SteamID64())
end

function plyMeta:SetRank(rank)
    if (rank and type(rank) == "string") then
        if (not self:IsRank(rank)) then
            if (ors.update_rank(self:SteamID64(), rank)) then
                self:SetNWRank(rank)
                return true
            end
        end
    end
end

function plyMeta:RefreshRank()
    self:SetNWRank(self:GetRank())
end

function plyMeta:ClearRank()
    if (ors.update_rank(self:SteamID64(), ors.base_rank)) then
        return true
    end
end

gameevent.Listen("player_activate")
hook.Add("player_activate", "sv_refresh_rank", function(args)
    local ply = Player(args.userid)
    if (ply and (not ply:IsPlayer() or ply:IsBot() or ply:SteamID() == "STEAM_0:0:0")) then return end
    
    ply:RefreshRank()
end)