ESX              = nil
local PlayerData = {}
-- local ped = PlayerPedId()
local isNearStove = false
local isNearToaster = false
local isNearMicro = false
local isUsing = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

-- Functions

function FindNearestStove()
	local coords = GetEntityCoords(PlayerPedId())
	local stoves = {}
	local handle, object = FindFirstObject()
	local success

	repeat
		if Config.StoveModels[GetEntityModel(object)] then
			table.insert(stoves, object)
		end

		success, object = FindNextObject(handle, object)
	until not success

	EndFindObject(handle)

	local stoveObject = 0
	local stoveDistance = 1000

	for k,v in pairs(stoves) do
		local distanceCheck = GetDistanceBetweenCoords(coords, GetEntityCoords(v))

		if distanceCheck < stoveDistance then
			stoveDistance = distanceCheck
			stoveObject = v
		end
	end

	return stoveObject, stoveDistance
end

function FindNearestToaster()
	local coords = GetEntityCoords(PlayerPedId())
	local toaster = {}
	local handle, object = FindFirstObject()
	local success

	repeat
		if Config.ToasterModels[GetEntityModel(object)] then
			table.insert(toaster, object)
		end

		success, object = FindNextObject(handle, object)
	until not success

	EndFindObject(handle)

	local toasterObject = 0
	local toasterDistance = 1000

	for k,v in pairs(toaster) do
		local distanceCheck = GetDistanceBetweenCoords(coords, GetEntityCoords(v))
		if distanceCheck < toasterDistance then
			toasterDistance = distanceCheck
			toasterObject = v
		end
	end

	return toasterObject, toasterDistance
end

function FindNearestMicro()
	local coords = GetEntityCoords(PlayerPedId())
	local micros = {}
	local handle, object = FindFirstObject()
	local success

	repeat
		if Config.MicroModels[GetEntityModel(object)] then
			table.insert(micros, object)
		end

		success, object = FindNextObject(handle, object)
	until not success

	EndFindObject(handle)

	local microObject = 0
	local microDistance = 1000

	for k,v in pairs(micros) do
		local distanceCheck = GetDistanceBetweenCoords(coords, GetEntityCoords(v))

		if distanceCheck < microDistance then
			microDistance = distanceCheck
			microObject = v
		end
	end

	return microObject, microDistance
end

function OpenStoveMenu()
    local ped = PlayerPedId()
    local itable = {}
    for k, v in ipairs(Config.StoveRecipes) do
        table.insert(itable, {['label'] = v['recipe'], ['value'] = v})
    end
    isUsing = true
    ESX.UI.Menu.Open('default',GetCurrentResourceName(),'stove_menu',
        {
            ['title'] = Config.Strings.StoveMenu,
            ['align'] = Config.MenuAlign, 
            ['elements'] = itable
        },
        function(ev, menu)
            if ev.current.value then
                ESX.TriggerServerCallback('dotsoft_cooking:checkStoveIngredients', function(status)
					if status then
						menu.close()
						FreezeEntityPosition(ped, true)
						TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BBQ', 0, false)
						Citizen.Wait(Config.CookingTime)
						-- Give the final product here
						TriggerServerEvent('dotsoft_cooking:finalProduct', ev.current.value.item)
						local objCloseBy = GetClosestObjectOfType('prop_fish_slice_01', GetEntityCoords(PlayerPedId()))
						if DoesEntityExist(objCloseBy) then
							DeleteEntity(objCloseBy)
						end
						ClearPedTasks(ped)
						FreezeEntityPosition(ped, false)
						isUsing = false
					else
						if Config.UseOkOkNotify then
							exports['okokNotify']:Alert("Stove", Config.Strings.WrongIngredients, 2500, 'info')
						else
							ESX.ShowNotification(Config.Strings.WrongIngredients)
						end
					end
                end, ev.current.value)
            end
        end,
        function(d, menu)
            menu.close()
            isUsing = false
        end)
end

function OpenToasterMenu()
    local ped = PlayerPedId()
    local itable = {}
    for k, v in ipairs(Config.ToasterRecipes) do
        table.insert(itable, {['label'] = v['recipe'], ['value'] = v})
    end
    isUsing = true
    ESX.UI.Menu.Open('default',GetCurrentResourceName(),'toaster_menu',
        {
            ['title'] = Config.Strings.ToasterMenu,
            ['align'] = Config.MenuAlign, 
            ['elements'] = itable
        },
        function(ev, menu)
            if ev.current.value then
                ESX.TriggerServerCallback('dotsoft_cooking:checkToasterIngredients', function(status)
					if status then
						menu.close()
						FreezeEntityPosition(ped, true)
						TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BBQ', 0, false)
						Citizen.Wait(Config.CookingTime)
						-- Give the final product here
						TriggerServerEvent('dotsoft_cooking:finalProduct', ev.current.value.item)
						ClearPedTasks(ped)
						FreezeEntityPosition(ped, false)
						isUsing = false
					else
						if Config.UseOkOkNotify then
							exports['okokNotify']:Alert("Toaster", Config.Strings.WrongIngredients, 2500, 'info')
						else
							ESX.ShowNotification(Config.Strings.WrongIngredients)
						end
					end
                end, ev.current.value)
            end
        end,
        function(d, menu)
            menu.close()
            isUsing = false
        end)
end

function OpenMicroMenu()
    local ped = PlayerPedId()
    local itable = {}
    for k, v in ipairs(Config.MicroRecipes) do
        table.insert(itable, {['label'] = v['recipe'], ['value'] = v})
    end
    isUsing = true
    ESX.UI.Menu.Open('default',GetCurrentResourceName(),'microwave_menu',
        {
            ['title'] = Config.Strings.MicroMenu,
            ['align'] = Config.MenuAlign, 
            ['elements'] = itable
        },
        function(ev, menu)
            if ev.current.value then
                ESX.TriggerServerCallback('dotsoft_cooking:checkMIngredients', function(status)
					if status then
						menu.close()
						FreezeEntityPosition(ped, true)
						TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BBQ', 0, false)
						Citizen.Wait(Config.CookingTime)
						-- Give the final product here
						TriggerServerEvent('dotsoft_cooking:finalProduct', ev.current.value.item)
						ClearPedTasks(ped)
						FreezeEntityPosition(ped, false)
						isUsing = false
					else
						if Config.UseOkOkNotify then
							exports['okokNotify']:Alert("Microwave", Config.Strings.WrongIngredients, 2500, 'info')
						else
							ESX.ShowNotification(Config.Strings.WrongIngredients)
						end
					end
                end, ev.current.value)
            end
        end,
        function(d, menu)
            menu.close()
            isUsing = false
        end)
end

-- Threads

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)

		-- Find nearest stove
		local stoveObject, stoveDistance = FindNearestStove()

		if stoveDistance < Config.Distance then
			isNearStove = stoveObject
		else
			isNearStove = false

			Citizen.Wait(math.ceil(stoveDistance * 20))
		end

		-- Find nearest toaster
		local toasterObject, toasterDistance = FindNearestToaster()

		if toasterDistance < Config.Distance then
			isNearToaster = toasterObject
		else
			isNearToaster = false

			Citizen.Wait(math.ceil(toasterDistance * 20))
		end

		-- Find nearest microwave
		local microObject, microDistance = FindNearestMicro()

		if microDistance < Config.Distance then
			isNearMicro = microObject
		else
			isNearMicro = false

			Citizen.Wait(math.ceil(microDistance * 20))
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(4)

		if not isUsing and (isNearStove and GetEntityHealth(isNearStove) > 0) or (isNearToaster and GetEntityHealth(isNearToaster) > 0) or (isNearMicro and GetEntityHealth(isNearMicro) > 0) then
			if isNearStove then
				local stringCoords = GetEntityCoords(isNearStoves)
				DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 0.4, Config.Strings.EToCookStove)
				if IsControlJustReleased(0, Config.Keybinds) then
					OpenStoveMenu()
					-- print('Works!')
				end
			elseif isNearToaster then
				local tstringCoords = GetEntityCoords(isNearToaster)
				DrawText3Ds(tstringCoords.x, tstringCoords.y, tstringCoords.z + 0.4, Config.Strings.EToCookToaster)
				if IsControlJustReleased(0, Config.Keybinds) then
					OpenToasterMenu()
					-- print('Works!')
				end
			elseif isNearMicro then
				local mstringCoords = GetEntityCoords(isNearMicro)
				DrawText3Ds(mstringCoords.x, mstringCoords.y, mstringCoords.z + 0.4, Config.Strings.EToCookMicro)
				if IsControlJustReleased(0, Config.Keybinds) then
					OpenMicroMenu()
					-- print('Works!')
				end
			else
				Citizen.Wait(250)
			end
		else
			Citizen.Wait(250)
		end
	end
end)

-- Utils

function DrawText3Ds(x, y, z, text)
	if text then
		local onScreen, _x, _y = World3dToScreen2d(x, y, z)
		local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextEntry("STRING")
		SetTextCentre(true)
		SetTextColour(255, 255, 255, 215)
		AddTextComponentString(text)
		DrawText(_x, _y)
		local factor = (string.len(text)) / 700
		DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100)
	end
end