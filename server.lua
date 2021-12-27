local eventCoords = nil
local identifiers = { -- list of allowed licenses 
    "license:"
}

RegisterCommand("startevent", function() 
    SetupEvent(source)
end)

RegisterCommand("resetevent", function() 
    SetupEvent(source)
end)

RegisterCommand("stopevent", function() 
    local _source = source
    
    if IsAllowed(GetPlayerIdentifiers(_source)) then
        eventCoords = nil
        TriggerClientEvent("evsys:showNotif", -1, "Event stopped by "..GetPlayerName(_source))
    end
end)

RegisterCommand("tpevent", function() 
    local _source = source
    
    SetEntityCoords(GetPlayerPed(_source), eventCoords, false, true, true, false)
    TriggerClientEvent("evsys:showNotif", _source, "Teleported!")
end)

function IsAllowed(userInformations)
    for i = 1, #userInformations, 1 do
        if string.sub(userInformations[i], 1, string.len("license:")) == "license:" then
            for j = 1, #identifiers, 1 do
                if userInformations[i] == identifiers[j] then
                    return true
                end
            end
            return false
        end
    end
end

function SetupEvent(src)
    if IsAllowed(GetPlayerIdentifiers(src)) then
        eventCoords = GetEntityCoords(GetPlayerPed(src))
        TriggerClientEvent("evsys:showNotif", -1, "New event created by "..GetPlayerName(src))
    end
end