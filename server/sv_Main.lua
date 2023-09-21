local ver = '1.0.0'

CreateThread(function()
    if GetResourceState(GetCurrentResourceName()) == 'started' then
        print('SM_SCRAPYARD STARTED ON VERSION: ' .. ver)
    end
end)


lib.callback.register('sm_scrapyard:deletevehicle', function()

    local _source = source
    local Inventory = exports.ox_inventory:Inventory()
    local xPlayer = ESX.GetPlayerFromId(_source)
    local chance = math.random(0, 100)

    local chances = {
        { min = 0, max = 55, quantity = 1 },
        { min = 56, max = 95, quantity = 2 },
        { min = 96, max = 100, quantity = 3 }
    }
    
    for _, chanceRange in ipairs(chances) do
        if chance >= chanceRange.min and chance <= chanceRange.max then
            if exports.ox_inventory:CanCarryItem(_source, Config.Item, chanceRange.quantity) then
                exports.ox_inventory:AddItem(_source, Config.Item, chanceRange.quantity)
                break
            end
        end
    end
end)
