ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("check:ems")
AddEventHandler("check:ems",function()
local ems = 0
local emsRequired = 1
local _source = source

local emsOn = false
xPlayers = ESX.GetPlayers()


for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if xPlayer.job.name == 'ems' then
        ems = ems + 1
  end
end

local emsOn = false

if ems < emsRequired then
  TriggerClientEvent("createEms", _source)
else
   TriggerClientEvent("esx:emsOn", _source)
	end
end)




RegisterNetEvent("healPlayer")
AddEventHandler("healPlayer", function()
  local price = 4000
  local _source = source

   if ESX.GetPlayerFromId(source).getMoney() == price or ESX.GetPlayerFromId(source).getMoney() > price  then
   TriggerClientEvent("esx:playanim", _source)
   ESX.GetPlayerFromId(source).removeMoney(price)
   Wait(5000)
   TriggerClientEvent("esx:Heal", _source)
else
 TriggerClientEvent("esx:cantPurchase", _source)
end
end)

RegisterNetEvent("esx:giveBack")
AddEventHandler("esx:giveBack", function()
 local notHealed = true
 local price = 4000

 if notHealed then
 	ESX.GetPlayerFromId(source).addMoney(price)
 end
end)