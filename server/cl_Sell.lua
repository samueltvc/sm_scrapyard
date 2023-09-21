-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

ESX = exports["es_extended"]:getSharedObject()

lib.callback.register('ws_sellshop:sellItem', function(source, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = data.item
    local quantity = data.quantity

    local xItem = xPlayer.getInventoryItem(item)

    if xItem.count >= quantity then
        local profit = math.floor(data.price * quantity)
        xPlayer.removeInventoryItem(item, quantity)
        xPlayer.addAccountMoney(data.currency, profit)
        return profit
    end

    return false
end)
