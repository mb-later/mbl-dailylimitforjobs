local QBCore = nil

TriggerEvent("QBCore:GetObject", function (obje)
	QBCore = obje
end)

RegisterNetEvent("günlüklimit:update")
AddEventHandler("günlüklimit:update" , function (boolean, value, player)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src) or player or nil
	local citizenid = xPlayer.PlayerData.citizenid
	if xPlayer == nil then TriggerClientEvent("QBCore:Notify", src, "Bir hata oluştu, hata kodu 503 lütfen ticket atıp ulaşın.") return end
		if boolean then
			QBCore.Functions.ExecuteSql(false, "SELECT `gunluklimit` WHERE `citizenid` = '" .. citizenid, function (count)
			QBCore.Functions.ExecuteSql(false, "UPDATE `players` SET `gunluklimit` = '" .. count+value .. "' WHERE `citizenid`='" .. citizenid .. "'")
			end)
		else
			QBCore.Functions.ExecuteSql(false, "SELECT `gunluklimit` WHERE `citizenid` = '" .. citizenid, function (count)
			QBCore.Functions.ExecuteSql(false, "UPDATE `players` SET `gunluklimit` = '" .. count-value .. "' WHERE `citizenid`='" .. citizenid .. "'")
		end)
	end
end)



exports["ghmattimysql"]:ready(function()
	QBCore.Functions.ExecuteSql(false, "UPDATE `players` SET `gunluklimit` = 0")
end)


exports("gunluklimitçek", function(source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local result = exports.ghmattimysql:executeSync("SELECT gunluklimit FROM players WHERE citizenid = "..xPlayer.PlayerData.citizenid)
    if result then
        if result[1] <= MBL.Maks then
            return true
        end
    end
    if result[1] == MBL.Maks or result[1] > MBL.Maks then TriggerClientEvent("QBCore:Notify", source, "Günlük limiti aştın.") return end
	return false
end)


QBCore.Functions.CreateCallback("mbl:gunluklimitçek", function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local result = exports.ghmattimysql:executeSync("SELECT gunluklimit FROM players WHERE citizenid = "..xPlayer.PlayerData.citizenid)
    if result then
        if result[1] <= MBL.Maks then
            cb(true)
        end
    end
    if result[1] > MBL.Maks then TriggerClientEvent("QBCore:Notify", source, "Günlük limiti aştın.") return end
	cb(nil)
end)
