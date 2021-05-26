local RLCore = nil

Citizen.CreateThread(function ()
    while RLCore == nil do
        TriggerEvent("RLCore:GetObject", function (obje)
            RLCore = obje
        end)
    end
    print("script started")
end)
