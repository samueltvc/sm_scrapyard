-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

ESX = exports["es_extended"]:getSharedObject()

local function formatNumberWithCommas(n)
    return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,"):gsub(",(%-?)$","%1"):reverse()
end

local function createBlip(coords, sprite, colour, text, scale)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

local function sellItem(data)
    local data = data
    local input = lib.inputDialog('How many would you like to sell?', {'Quantity'})
    if input then
        data.quantity = math.floor(tonumber(input[1]))
        if data.quantity < 1 then
            lib.notify({
                title = 'Error',
                description = 'Please enter a valid amount!',
                type = 'error'
            })
        else
            local done = lib.callback.await('ws_sellshop:sellItem', 100, data)
            if not done then
                lib.notify({
                    title = 'Error',
                    description = 'You lacked the requested items to sell!',
                    type = 'error'
                })
            else
                lib.notify({
                    title = 'Success',
                    description = 'You sold your goods for and profited $'..formatNumberWithCommas(done),
                    type = 'success'
                })
            end
        end
    else
        lib.notify({
            title = 'Error',
            description = 'Please enter a valid amount!',
            type = 'error'
        })
    end
end

local function createSellShopInteractOptions(storeData)
    local items = storeData.items
    local options = {}

    for i = 1, #items do
        table.insert(options, {
            title = items[i].label,
            description = 'Sell Price: $' .. items[i].price,
            event = 'ws_sellshop:sellItem',
            args = { item = items[i].item, price = items[i].price, currency = items[i].currency }
        })
    end

    return options
end

local function setupBlipsAndInteractions()
    for i, sellShop in ipairs(Config.SellShops) do
        exports.qtarget:AddBoxZone(
            i .. "_sell_shop",
            sellShop.coords,
            1.0,
            1.0,
            {
                name = i .. "_sell_shop",
                heading = sellShop.blip.heading,
                debugPoly = false,
                minZ = sellShop.coords.z - 1.5,
                maxZ = sellShop.coords.z + 1.5
            },
            {
                options = {
                    {
                        event = 'ws_sellshop:interact',
                        icon = 'fas fa-hand-paper',
                        label = 'Interact',
                        store = sellShop
                    }
                },
                job = 'all',
                distance = 1.5
            }
        )

        if sellShop.blip.enabled then
            createBlip(sellShop.coords, sellShop.blip.sprite, sellShop.blip.color, sellShop.label, sellShop.blip.scale)
        end
    end
end

local function spawnPedAtShops()
    local pedSpawned = {}
    local pedPool = {}

    while true do
        local sleep = 1500
        local playerPed = cache.ped
        local pos = GetEntityCoords(playerPed)

        for i, sellShop in ipairs(Config.SellShops) do
            local dist = #(pos - sellShop.coords)

            if dist <= Config.SellShopDistance and not pedSpawned[i] then
                pedSpawned[i] = true
                lib.requestModel(sellShop.ped, 100)
                lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 100)
                pedPool[i] = CreatePed(28, sellShop.ped, sellShop.coords.x, sellShop.coords.y, sellShop.coords.z, sellShop.heading, false, false)
                FreezeEntityPosition(pedPool[i], true)
                SetEntityInvincible(pedPool[i], true)
                SetBlockingOfNonTemporaryEvents(pedPool[i], true)
                TaskPlayAnim(pedPool[i], 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
            elseif dist >= Config.SellShopDistance + 1 and pedSpawned[i] then
                local model = GetEntityModel(pedPool[i])
                SetModelAsNoLongerNeeded(model)
                DeletePed(pedPool[i])
                SetPedAsNoLongerNeeded(pedPool[i])
                pedPool[i] = nil
                pedSpawned[i] = false
            end
        end

        Wait(sleep)
    end
end

-- Main code
AddEventHandler('ws_sellshop:sellItem', sellItem)

AddEventHandler('ws_sellshop:interact', function(data)
    local storeData = data.store
    local options = createSellShopInteractOptions(storeData)
    lib.registerContext({
        id = 'storeInteract',
        title = storeData.label,
        options = options
    })
    lib.showContext('storeInteract')
end)

-- Initialize the script
setupBlipsAndInteractions()
spawnPedAtShops()
