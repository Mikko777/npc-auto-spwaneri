local carModels = {
    { model = "nero", parkingCoords = vector3(coordit) },
    { model = "taipan", parkingCoords = vector3(coordit) },
    { model = "cycle", parkingCoords = vector3(coordit) },
}

RegisterNetEvent("carSelectionMenu")
AddEventHandler("carSelectionMenu", function(npc)
    TriggerClientEvent("openCarSelectionMenu", -1, carModels, npc)
end)

RegisterNetEvent("spawnSelectedCar")
AddEventHandler("spawnSelectedCar", function(model, parkingCoords)
    local playerPed = PlayerPedId()
    local heading = GetEntityHeading(playerPed)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(model, parkingCoords, heading, true, false)

    local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
    SetEntityCoords(vehicle, offset)

    SetEntityCoordsNoOffset(vehicle, parkingCoords, true, true, false)

    SetPedIntoVehicle(playerPed, vehicle, -1)
end)