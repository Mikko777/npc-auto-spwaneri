-- ok broidi eeekoo


local npcModel = "npc_model"

local npcCoords = vector3(coords)

function SpawnNPCAndApproach(npcModel, npcCoords)
    local playerPed = PlayerPedId()

            local npc = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z, 0.0, true, false)
            SetEntityHeading(npc, GetHeadingFromEntity(playerPed))
            FreezeEntityPosition(npc, true)
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)

            TriggerServerEvent("carSelectionMenu", npc)
        end
    end)
end



-- NPc osotus juttu
Citizen.CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()
        local target, distance = ESX.Game.GetClosestEntity()

        if DoesEntityExist(target) and IsEntityHuman(target) and distance <= 3.0 then
            exports["ox_target"]:PointAt(target, function(result)
                if result then
                    TriggerServerEvent("carSelectionMenu", target)
                end
            end)
        end
    end
end)

function OpenCarSelectionMenu(carModels, npc)
    local elements = {}

    for _, car in ipairs(carModels) do
        table.insert(elements, {
            label = car.model,
            value = car
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_selection_menu',
        {
            title = 'Valitse auto:',
            align = 'top-left',
            elements = elements
        },
        function(data, menu)
            local selectedCar = data.current.value
            TriggerServerEvent("spawnSelectedCar", selectedCar.model, selectedCar.parkingCoords)
            ESX.UI.Menu.CloseAll()
        end,
        function(data, menu)
            menu.close()
        end
    )
end

RegisterNetEvent("openCarSelectionMenu")
AddEventHandler("openCarSelectionMenu", function(carModels, npc)
    OpenCarSelectionMenu(carModels, npc)
end)
