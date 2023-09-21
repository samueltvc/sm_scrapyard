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

    if chance < 40 and exports.ox_inventory:CanCarryItem(_source, Config.Item, 1) then
        exports.ox_inventory:AddItem(_source, Config.Item, 1)
    elseif chance >= 40 and chance < 55 and exports.ox_inventory:CanCarryItem(_source, Config.Item, 1) then
        exports.ox_inventory:AddItem(_source, Config.Item, 1)
    elseif chance >= 55 and chance < 70 and exports.ox_inventory:CanCarryItem(_source, Config.Item, 1) then
        exports.ox_inventory:AddItem(_source, Config.Item, 2)
    elseif chance >= 70 and chance < 85 and exports.ox_inventory:CanCarryItem(_source, Config.Item, 1) then
        exports.ox_inventory:AddItem(_source, Config.Item, 2)
    elseif chance >= 85 and chance < 95 and exports.ox_inventory:CanCarryItem(_source, Config.Item, 1) then
        exports.ox_inventory:AddItem(_source, Config.Item, 2)
    elseif chance >= 97 and chance <= 100 and exports.ox_inventory:CanCarryItem(_source, Config.Item, 1) then
        exports.ox_inventory:AddItem(_source, Config.Item, 3)
    end
end)
