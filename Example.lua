-- How to use the resource?

local _police = exports['playertables']:getPlayers("police") -- Get the players that have the specified job
for k, v in pairs(_police) do -- Iterate table of players with job
    print(v) -- Print the source
    TriggerClientEvent("police:doSomething", v) -- Trigger a client event to each police in the server
end

local _police = exports['playertables']:getPlayers("ambulance") -- Get the players that have the specified job
for k, v in pairs(_police) do -- Iterate table of players with job
    print(v) -- Print the source
    TriggerClientEvent("police:doSomething", v) -- Trigger a client event to each police in the server
end

-- Why you must use this?
-- Instead of getting all the players and loop getting the player job, just get all the players with an specified job.

-- DO NOT ENSURE THE RESOURCE WITH PLAYERS INSIDE YOUR SERVER