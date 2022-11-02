ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Events

RegisterServerEvent('dotsoft_cooking:finalProduct')
AddEventHandler('dotsoft_cooking:finalProduct', function(product)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.OldESX then
        local xItem = xPlayer.getInventoryItem(product)
        local count = 1

        if xItem.limit ~= -1 then
            count = xItem.limit - xItem.count
        end

        if xItem.count < xItem.limit then
            xPlayer.addInventoryItem(product, Config.ProductAmount)
        else
            if Config.UseOkOkNotify then
                TriggerClientEvent('okokNotify:Alert', source, "Error", Config.Strings.NotEnoughSpace, 2500, 'error')
            else
                ESX.ShowNotification(Config.Strings.NotEnoughSpace, "error", 3000)
            end
        end
    else
        if xPlayer.canCarryItem(product, Config.ProductAmount) then
            xPlayer.addInventoryItem(product, Config.ProductAmount)
        else
            if Config.UseOkOkNotify then
                TriggerClientEvent('okokNotify:Alert', source, "Error", Config.Strings.NotEnoughSpace, 2500, 'error')
            else
                ESX.ShowNotification(Config.Strings.NotEnoughSpace, "error", 3000)
            end
        end
    end
end)
-- Callbacks

ESX.RegisterServerCallback("dotsoft_cooking:checkStoveIngredients", function(source, cb, recipe)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local enough = false
    for k, v in ipairs(Config['StoveRecipes']) do
        if v['recipe'] == recipe['recipe'] then
            local enough = false
            for k1, v1 in ipairs(v['ingredients']) do
                if not (xPlayer.getInventoryItem(Config.Items[v1.ingredient]).count >= v1["amount"]) then
                    enough = false
                    cb(false)
                    break
                else
                    enough = true
                end
            end
            if enough == true then
                for k2, v2 in ipairs(v['ingredients']) do
                    if enough == true then
                        xPlayer.removeInventoryItem(Config.Items[v2.ingredient], v2["amount"])
                    end
                end
                cb(true)
            end
            break
        end
    end
end)

ESX.RegisterServerCallback("dotsoft_cooking:checkToasterIngredients", function(source, cb, recipe)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local enough = false
    for k, v in ipairs(Config['ToasterRecipes']) do
        if v['recipe'] == recipe['recipe'] then
            for k1, v1 in ipairs(v['ingredients']) do
                if not (xPlayer.getInventoryItem(Config.Items[v1.ingredient]).count >= v1["amount"]) then
                    enough = false
                    cb(false)
                    break
                else
                    enough = true
                end
            end
            if enough == true then
                for k2, v2 in ipairs(v['ingredients']) do
                    if enough == true then
                        xPlayer.removeInventoryItem(Config.Items[v2.ingredient], v2["amount"])
                    end
                end
                cb(true)
            end
            break
        end
    end
end)

ESX.RegisterServerCallback("dotsoft_cooking:checkMIngredients", function(source, cb, recipe)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local enough = false
    for k, v in ipairs(Config['MicroRecipes']) do
        if v['recipe'] == recipe['recipe'] then
            for k1, v1 in ipairs(v['ingredients']) do
                if not (xPlayer.getInventoryItem(Config.Items[v1.ingredient]).count >= v1["amount"]) then
                    enough = false
                    cb(false)
                    break
                else
                    enough = true
                end
            end
            if enough == true then
                for k2, v2 in ipairs(v['ingredients']) do
                    if enough == true then
                        xPlayer.removeInventoryItem(Config.Items[v2.ingredient], v2["amount"])
                    end
                end
                cb(true)
            end
            break
        end
    end
end)

-- Usable Items

-- Ingredients

ESX.RegisterUsableItem('tomato', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tomato', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('lettuce', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lettuce', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('pickles', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pickles', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('mayo', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mayo', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

-- Recipes

ESX.RegisterUsableItem('gourmetburger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('gourmetburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('veganburger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('veganburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('chickensand', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('chickensand', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('toastedbread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('toastedbread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('peperonipizza', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('peperonipizza', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)