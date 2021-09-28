# playertables
A resource to save players in tables depending on ESX jobs.

### [Discord](https://discord.gg/eBpmkW6e5j)

# License
This project does not contain a license, therefore you are not allowed to add one and claim it as yours. You are not allowed to sell this nor re-distribute it. You are not allowed to change/add a license. If you want to modify or make an agreement, you can contact me. Pull requests are accepted as long as they do not contain breaking changes. You can read more [HERE](https://opensource.stackexchange.com/questions/1720/what-can-i-assume-if-a-publicly-published-project-has-no-license) 

### Requirements

- ESX legacy or deprecated versions setting true the old ESX config.
- **Do not ensure the resource with the server with players inside!**

### Installation
1) Download from the releases tab.
2) Move the resource into your resources folder.
3) Add `ensure playertables` in your server.cfg
4) Start your server.

## Why you must use this?

Instead of getting all the players with ESX.GetPlayers() or ESX.GetExtendedPlayers() and loop getting the player job, just get all the players with an specified job.

## Documentation

- How to implement the resource


```lua
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
```

- Export error

Set in true use old esx in config.

- "<" error?

Update your artifacts because the resource uses lua 5.4 .

# Credits

- Readme inspired by Bombay (Entity Evolution)
