local RLCore = nil

Citizen.CreateThread(function ()
    while RLCore == nil do
        Citizen.Wait(0)
        TriggerEvent("RLCore:GetObject", function (obje)
            RLCore = obje
        end)
    end
    print("script started")
end)
