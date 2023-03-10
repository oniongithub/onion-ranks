ors.refresh_table = function()
    if (not sql.TableExists(ors.table_name)) then
        sql.Query("CREATE TABLE " .. ors.table_name .. "( id INTEGER, steamid TEXT, rank INTEGER, PRIMARY KEY(id AUTOINCREMENT) )")
    end
end

ors.refresh_player = function(steam64)
    local query_table = sql.Query("SELECT * FROM "  .. ors.table_name .. " WHERE steamid='" .. steam64 .. "';")
    if (not sql.Query("SELECT * FROM "  .. ors.table_name .. " WHERE steamid='" .. steam64 .. "';")) then
        sql.Query("INSERT INTO " .. ors.table_name .. " (steamid, rank) VALUES ('" .. steam64 .. "', 1);")
        return true
    else return true end
end

ors.update_rank = function(steam64, rank)
    if (steam64 and rank) then
        if (ors.refresh_player(steam64) and ors.rank_str[rank]) then
            sql.Query("UPDATE "  .. ors.table_name .. " SET rank=" .. tostring(ors.rank_str[rank]) .. " WHERE steamid='" .. steam64 .. "';")

            return true
        end
    end
end

ors.get_player_rank = function(steam64)
    if (ors.refresh_player(steam64)) then
        local query = sql.Query("SELECT * FROM "  .. ors.table_name .. " WHERE steamid='" .. steam64 .. "';")

        if (query and query[1]) then
            return ors.rank_int[tonumber(query[1].rank)]
        end
    end

    return ors.base_rank
end

ors.get_steamid = function(id)
    if (string.find(id, ':')) then
        id = util.SteamIDTo64(id) 
    end

    return id
end