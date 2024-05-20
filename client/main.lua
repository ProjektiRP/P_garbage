local bags = 0
local bagsTaken = {}
local bagProp = nil
local jobVehicle = nil
local blip = nil
local isHoldingBag = false
local isOnDuty = false

if Config.RequireJob then
    jobName = Config.Job
else
    jobName = nil
end

CreateThread(function()
    if Config.Blip.Show then
        local shouldShowBlip = Config.RequireJob and ESX.PlayerData.job.name == Config.Job or not Config.RequireJob
        if shouldShowBlip then
            blip = AddBlipForCoord(Config.JobClock)

            SetBlipSprite(blip, Config.Blip.Sprite)
            SetBlipScale(blip, Config.Blip.Scale)
            SetBlipColour(blip, Config.Blip.Color)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.Locales[Config.Language]['garbage_job'])
            EndTextCommandSetBlipName(blip)
        end
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    if Config.RequireJob then
        if job.name == 'garbage' and blip == nil then
            blip = AddBlipForCoord(Config.JobClock)

            SetBlipSprite(blip, Config.Blip.Sprite)
            SetBlipScale(blip, Config.Blip.Scale)
            SetBlipColour(blip, Config.Blip.Color)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.Locales[Config.Language]['garbage_job'])
            EndTextCommandSetBlipName(blip)
        elseif job.name ~= 'garbage' and blip ~= nil then
            RemoveBlip(blip)
            blip = nil
        end
    end
end)

exports.ox_target:addModel(Config.Models, {
    {
        label = Config.Locales[Config.Language]['collect_bag'],
        icon = 'fas fa-trash',
        distance = 2.0,
        onSelect = function(data)
            local playerPed = PlayerPedId()

            if bagsTaken[data.entity] == nil then
                bagsTaken[data.entity] = 0
            end

            loadAnimDict("anim@heists@narcotics@trash")
            ProgressBar(5000, Config.Locales[Config.Language]['collecting_bag'], {scenario = 'PROP_HUMAN_BUM_BIN'}, {move = true, mouse = false, combat = true, sprint = true, car = true})

            isHoldingBag = true
            bagProp = CreateObject(GetHashKey("prop_cs_street_binbag_01"), 0, 0, 0, true, true, true)
            AttachEntityToEntity(bagProp, playerPed, GetPedBoneIndex(playerPed, 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)

            bagsTaken[data.entity] += 1

            TaskPlayAnim(playerPed, 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0, -1, 49, 0, 0, 0, 0)
        end,
        canInteract = function(entity)
            return not isHoldingBag and isOnDuty and bagsTaken[entity] ~= 3 and bags < Config.MaxBags
        end
    }
})

exports.ox_target:addGlobalVehicle({
    {
        label = Config.Locales[Config.Language]['put_bag'],
        icon = 'fas fa-trash',
        bones = 'boot',
        distance = 2.0,
        onSelect = function(data)
            ProgressBar(800, Config.Locales[Config.Language]['putting_bag'], {dict = 'anim@heists@narcotics@trash', clip = 'throw_b'}, {move = true, mouse = false, combat = true, sprint = true, car = true})
            DeleteEntity(bagProp)
            bagProp = nil
            isHoldingBag = false
            bags += 1

            if bags == Config.MaxBags then
                Notify('inform', Config.Locales[Config.Language]['max_bags'])
            end
        end,
        canInteract = function(entity)
            return isHoldingBag and GetEntityModel(entity) == GetHashKey(Config.VehicleModel)
        end
    }
})

exports.ox_target:addSphereZone({
    coords = Config.JobClock,
    radius = 1.0,
    debug = false,
    options = {
        {
            label = Config.Locales[Config.Language]['clock_in'],
            icon = 'fas fa-clipboard',
            groups = jobName,
            distance = 2.0,
            onSelect = function(data)
                ProgressBar(2000, Config.Locales[Config.Language]['clocking_in'], nil, {move = true, mouse = false, combat = true, sprint = true, car = true})

                ESX.Game.SpawnVehicle(Config.VehicleModel, Config.VehicleSpawn.xyz, Config.VehicleSpawn.w, function(vehicle)
                    Notify('inform', Config.Locales[Config.Language]['clocked_in'])
                    receiveCarKeys(vehicle, GetVehicleNumberPlateText(vehicle))

                    jobVehicle = vehicle
                end)
                isOnDuty = true
            end,
            canInteract = function()
                return not isOnDuty
            end
        },
        {
            label = Config.Locales[Config.Language]['clock_out'],
            icon = 'fas fa-clipboard',
            groups = jobName,
            distance = 2.0,
            onSelect = function(data)
                ProgressBar(2000, Config.Locales[Config.Language]['clocking_out'], nil, {move = true, mouse = false, combat = true, sprint = true, car = true})
                Notify('inform', Config.Locales[Config.Language]['clocked_out'])

                TriggerServerEvent('P_garbage:pay', bags)
                DeleteVehicle(jobVehicle)
                jobVehicle = nil
                bagsTaken = {}
                bags = 0
                isOnDuty = false
            end,
            canInteract = function()
                return isOnDuty
            end
        }
    }
})