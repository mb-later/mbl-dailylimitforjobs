local RLCore = nil

TriggerEvent("RLCore:GetObject", function (obje)
	RLCore = obje
end)

RegisterNetEvent("günlüklimit:update")
AddEventHandler("günlüklimit:update" , function (boolean, value, player)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src) or player or nil
	local citizenid = xPlayer.PlayerData.citizenid
	if xPlayer == nil then TriggerClientEvent("RLCore:Notify", src, "Bir hata oluştu, hata kodu 503 lütfen ticket atıp ulaşın.") return end
		if boolean then
			RLCore.Functions.ExecuteSql(false, "SELECT `gunluklimit` WHERE `citizenid` = '" .. citizenid, function (count)
			RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `gunluklimit` = '" .. count+value .. "' WHERE `citizenid`='" .. citizenid .. "'")
			end)
		else
			RLCore.Functions.ExecuteSql(false, "SELECT `gunluklimit` WHERE `citizenid` = '" .. citizenid, function (count)
			RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `gunluklimit` = '" .. count-value .. "' WHERE `citizenid`='" .. citizenid .. "'")
		end)
	end
end)



exports["ghmattimysql"]:ready(function()
	RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `gunluklimit` = 0")
end)


exports("gunluklimitçek", function(source)
	local xPlayer = RLCore.Functions.GetPlayer(source)
	local result = exports.ghmattimysql:executeSync("SELECT gunluklimit FROM players WHERE citizenid = "..xPlayer.PlayerData.citizenid)
	return result[1]
end)


RLCore.Functions.CreateCallback("mbl:gunluklimitçek", function(source, cb)
	local xPlayer = RLCore.Functions.GetPlayer(source)
	if xPlayer == nil then return end
	local result = exports.ghmattimysql:executeSync("SELECT gunluklimit FROM players WHERE citizenid = "..xPlayer.PlayerData.citizenid)
	if result then
		cb(result[1])
	end
end)
