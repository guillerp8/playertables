_Players = {}

if C['UseOldESX'] then
    ESX = ESX 
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
end

DebugLog = function(txt)
    if txt then
        print("^3[playertables] [Debug] ^7" ..txt)
    end
end

for k, v in pairs(ESX['Jobs']) do
    _Players[v['name']] = {}
    if C['enableDebug'] then
        DebugLog("Registered job: " ..v['name'])
    end
end

AddEventHandler('esx:setJob', function(source, job, lastJob)
    local _src <const> = source
    if _Players[lastJob['name']][_src] then
        _Players[lastJob['name']][_src] = nil
    end
    _Players[job['name']][_src] = _src
    if C['enableDebug'] then
        DebugLog("The source '" .._src.. "' changed from '" ..lastJob['name'].."' to '"..job['name'].. "'")
    end
end)

AddEventHandler('playerDropped', function(reason)
	local _src <const> = source
    local xPlayer = ESX['GetPlayerFromId'](_src)
    if xPlayer['job']['name'] then
        local _job <const> = xPlayer['job']['name']
        if _Players[_job][_src] then
            _Players[_job][_src] = nil
        end
        if C['enableDebug'] then
            DebugLog("Dropped player: '" .._src.. "' and removed from job '" .._job.."'")
        end
    end
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local _src <const> = source
    if xPlayer['job']['name'] then
        local _job <const> = xPlayer['job']['name']
        _Players[_job][_src] = _src
        DebugLog("Player asigned to: '" .._job.."'")
    end
end)

exports("getPlayers", function(job)
    if job then
        return _Players[job]
    else
        RconPrint("^1PLAYERTABLES ERROR: Provide a valid job in export 'getPlayers'\n")
    end
end)