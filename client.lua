
-- created by AyoPunky
-- Hospital Healing
ESX = nil
local PlayerData = {}

canDraw = false

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



local emsHeal = {
 { ["x"] = 1147.19, ["y"] = -1525.92, ["z"] = 34.84},
}


RegisterNetEvent("createEms")
AddEventHandler("createEms", function()
Citizen.CreateThread(function() -- Create Ems Doctor
 local model = GetHashKey("s_m_m_doctor_01")
 local pedHere = false

      RequestModel(model)
   while not HasModelLoaded(model) do
   	         Citizen.Wait(0)
   end
   
   if DoesEntityExist(emsPed) then
   	pedHere = false
   else     
   emsPed = CreatePed(20, model, 1147.19, -1525.92, 34.84, 0, true, true)
   pedHere = true
        end
     end)
  end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	TriggerServerEvent("check:ems")
       end
	end)


Citizen.CreateThread(function() -- draw marker near ems doctor
   while true do
  	Citizen.Wait(0)
  for k in pairs(emsHeal) do
  	Citizen.Wait(0)
    if DoesEntityExist(emsPed) then
  	DrawMarker(-1, emsHeal[k].x, emsHeal[k].y, emsHeal[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 0, 255, 200, 0, 0, 0, 0)
  else
     canDraw = false 
     end
    end
   end
  end)

Citizen.CreateThread(function()
   while true do
     Citizen.Wait(0)
   for k  in pairs(emsHeal) do
   	local plyCoords = GetEntityCoords(GetPlayerPed(player), true)
   	local dist = Vdist2(plyCoords, emsHeal[k].x, emsHeal[k].y, emsHeal[k].z)
    
    if dist <= 1.5 and DoesEntityExist(emsPed) then 
    	ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to heal for ~g~$4,000~w~!')
    if IsControlJustPressed(0, 38) then
    TriggerServerEvent("healPlayer")
  else
    canDraw = false
         end
       end
     end
   end
 end)

-----Event Handlers
RegisterNetEvent("esx:emsOn")
AddEventHandler("esx:emsOn", function()
       Citizen.CreateThread(function()
local emsOn = true

if emsOn then
    SetPedAsNoLongerNeeded(emsPed)
    DeleteEntity(emsPed)
    emsOn = false
   end
   end)
end)

       RegisterNetEvent("esx:cantPurchase")
       AddEventHandler("esx:cantPurchase",function()
       	       Citizen.CreateThread(function()
       	 local noPurchase = true

       	 if noPurchase then
       	 	ESX.ShowNotification("~r~You do not have enough money!")
       	 	Wait(3000)
       	 	noPurchase = false
     end
   end)
 end)




       	  RegisterNetEvent("esx:Heal")
       	  AddEventHandler("esx:Heal", function()
       	  	Citizen.CreateThread(function()
       	  	local ped = GetPlayerPed(-1)
       	  	local pHealth = GetEntityHealth(ped)
       	  	local maxHealth = GetEntityMaxHealth(ped)
            local healed = false

          
       	  if pHealth < maxHealth then
       	     SetEntityHealth(ped, maxHealth)
       	     ESX.ShowNotification("~r~You been Healed!")
       	     Wait(3000)
       	     healed = false
           else
            ESX.ShowNotification("~r~You Have Full Health!")
            TriggerServerEvent("esx:giveBack")
       end
       end) 
 end)

       	   
       	   RegisterNetEvent("esx:playanim")
       	   AddEventHandler("esx:playanim", function()
       	   	local dict = "amb@medic@standing@kneel@enter"
       	   	 RequestAnimDict(dict)
       	   	 while (not HasAnimDictLoaded(dict)) do
       	   	 	Wait(100)
       	   	 end

           TaskPlayAnim(emsPed, dict,"enter", 1.0,-1.0, 5000, 1, 1, true, true, true)
         end)