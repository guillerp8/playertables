_Players = {}
ESX = ESX 
Jobs = {}

if C['UseOldESX'] then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
end

DebugLog = function(txt)
    if txt then
        print("^3[playertables] [Debug] ^7" ..txt)
    end
end

CreateThread(function()
    Citizen.Wait(1000)
     for k, v in pairs(Jobs) do
         _Players[v.name] = {}
         if C['enableDebug'] then
             DebugLog("Registered job: " ..v.name)
         end
     end
 end)


AddEventHandler('esx:setJob', function(source, job, lastJob)
    local _src <const> = source
    if _Players[lastJob['name']] then
        if _Players[lastJob['name']][_src] then
            _Players[lastJob['name']][_src] = nil
            if C['enableDebug'] then
                DebugLog("Changed job and removed from job '" ..lastJob['name'].."'")
            end
        end
    end
    if _Players[job['name']] then
        _Players[job['name']][_src] = _src
        if C['enableDebug'] then
            DebugLog("The source '" .._src.. "' changed from '" ..lastJob['name'].."' to '"..job['name'].. "'")
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local _src <const> = source
    local xPlayer = ESX['GetPlayerFromId'](_src)
    if xPlayer then
        local _job <const> = xPlayer['job']['name']
        if _Players[_job] then
            if _Players[_job][_src] then
                _Players[_job][_src] = nil
            end
            if C['enableDebug'] then
                DebugLog("Dropped player: '" .._src.. "' and removed from job '" .._job.."'")
            end
        end
    end
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local _src <const> = source
    if xPlayer['job']['name'] then
        local _job <const> = xPlayer['job']['name']
        if _Players[_job] then
            _Players[_job][_src] = _src
            DebugLog("Player asigned to: '" .._job.."'")
        end
    end
end)

exports("getPlayers", function(job)
    if job then
        return _Players[job]
    else
        RconPrint("^1PLAYERTABLES ERROR: Provide a valid job in export 'getPlayers'\n")
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        MySQL.query('SELECT name FROM jobs ', {},
        function(result)
            Jobs = result
        end)
    end
end)