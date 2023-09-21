ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    timers = false
    exports['qtarget']:AddBoxZone('Scrap', Config.Locations.Ped, 1.00, 1.50, {
        name = 'scrap',
        debugPoly = false,
        minZ = 18.12,
        maxZ = 20.32,
        }, {
            options = {
                {
                    event = 'sm_scrapyard:giveinformation',
                    icon = 'fa-solid fa-car',
                    label = Config.Notify.targetlabel,
                },
            },
            distance = 7.0
    })
    Citizen.Wait(10000)
end)

Citizen.CreateThread(function()
        RequestModel("s_m_m_dockwork_01")
        
        while not HasModelLoaded("s_m_m_dockwork_01") do
            Wait(1)
        end
        
        ped = CreatePed(1, "s_m_m_dockwork_01", Config.Locations.Ped, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedDiesWhenInjured(ped, false)
        SetPedCanPlayAmbientAnims(ped, true)
        SetPedCanRagdollFromPlayerImpact(ped, false)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_COFFEE", 0, true)
end)

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
     Citizen.Wait(5)
    end
end

local animDict = "mini@repair"

local blveh =
	IsVehicleModel( bati, akuma, avarus, bagger, bati2, carbonrs, chimera, cliffhanger, daemon, daemon2, defiler, deathbike, diablous, diablous2, double, enduro, esskey, faggio, faggio2, faggio3, fcr, fcr3, hakuchou, hakuchou2, gargoyle, lectro, manchez, manchez3, nemesis, sovereign, thrust, vader, menchez2 )

RegisterNetEvent('sm_scrapyard:giveinformation')
AddEventHandler("sm_scrapyard:giveinformation", function()
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false )
        if timers == false and IsPedInAnyVehicle(PlayerPedId()) then
            -- HERE PUT DISPATCH IF YOU WANT TO
        timers = true
        lib.progressBar({
            duration = 15000,
            label = Config.Notify.progresslabel,
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
                move = true,
                combat = true,
                mouse = false,
            },
        })
        SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 0, false, false)
        Wait(100)
        SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 0, true)
        Wait(100)
        lib.callback("sm_scrapyard:deletevehicle")
        SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 1, false, false)
        Wait(100)
        SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 1, true)
        Wait(100)
        lib.callback("sm_scrapyard:deletevehicle")
        SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 2, false, false)
        Wait(100)
        SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 2, true)
        Wait(100)
        lib.callback("sm_scrapyard:deletevehicle")
        SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 3, false, false)
        Wait(100)
        SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 3, true)
        Wait(100)
        lib.callback("sm_scrapyard:deletevehicle")
        SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 4, false, false)
        Wait(100)
        SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false),4, true)
        Wait(100)
        lib.callback("sm_scrapyard:deletevehicle")
        SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 5, false, false)
        Wait(100)
        SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false),5, true)
            Wait(1200)
            lib.callback("sm_scrapyard:deletevehicle")
        DeleteVehicle(vehicle)
        Citizen.Wait(20000)
        timers = false
    elseif timers == true then
        lib.notify({
            title = Config.Notify.label,
            description = 'You cant do it twice, wait a little!',
            type = 'error'
        })
    else
        lib.notify({
            title = Config.Notify.label,
            description = 'Something is wrong!',
            type = 'error'
        })
    end
end)





