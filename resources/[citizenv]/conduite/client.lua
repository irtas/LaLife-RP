
local permis_auto = {
  {name="Permis auto", id=457, x=-745.300, y=-1038.203, z=11.666},
}


local arrivee_auto = {
  {x=1233.53, y=-3330.7, z=4.60},


}
local voiture_sorti = false
local car_auto = nil
local pointArrivee = nil
local tropvite = "false"
local vehiculeabime ="false" 
local gotpermisauto = "false"

local ArgentJoueur = 0

RegisterNetEvent("conduite:f_getCash")
AddEventHandler("conduite:f_getCash", function(argent)
  ArgentJoueur = argent
end)



RegisterNetEvent("conduite:getPermisauto")
AddEventHandler("conduite:getPermisauto", function(returned)
  
     gotpermisauto = returned


end)






function IsNearArriveeAuto()

  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(arrivee_auto) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 4) then
      return true
    end
  end
end




function IsNearPermisAuto()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(permis_auto) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 4) then
      return true
    end
  end
end


function ShowInfoPermis(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end
function DrawMissionTextAuto(m_text, showtime)
  ClearPrints()
  SetTextEntry_2("STRING")
  AddTextComponentString(m_text)
  DrawSubtitleTimed(showtime, 1)
end





function StopPermis()
  

end 




   











Citizen.CreateThread(function()
    for _, item in pairs(permis_auto) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      SetBlipColour(item.blip, 3)
      SetBlipScale(item.blip, 0.9)
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
end)



 

function DemarrerPermis()
               

              local car = GetHashKey("Brioso")
              local cplate = "APPRENTI"
              RequestModel(car)
              while not HasModelLoaded(car) do
              Citizen.Wait(0)
              end
              veh = CreateVehicle(car, -745.300,-1034.203,11.666, 0.0, true, false)
              
              SetVehicleNumberPlateText(veh, cplate)
              SetVehicleOnGroundProperly(veh)
              SetVehicleColours(veh,64,64)
              SetPedIntoVehicle(GetPlayerPed(-1),  veh,  -1)

               DrawMissionTextAuto("Conduisez jusqu'au point ~h~~y~jaune prudemment~w~ pour obtenir votre permis.", 10000)

              pointArrivee= AddBlipForCoord(1233.36,-3326.87,5.52)
              N_0x80ead8e2e1d5d52e(pointArrivee)
              SetBlipRoute(pointArrivee, 1)
             

              voiture_sorti = true
              car_auto = veh

               
             

          
  
    
end



Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)
    for i = 1, #permis_auto do
      if (IsNearPermisAuto()) then
        TriggerServerEvent("conduite:getCash_s")
               DrawMarker(1,-745.300,-1038.203,11.666,0,0,0,0,0,0,2.001,2.0001,0.5001,255,100,100,200,0,0,0,0)
           
        ShowInfoPermis("Appuyez sur ~INPUT_CONTEXT~ pour passer votre ~b~permis auto~w~.", 0)
        if IsControlJustPressed(1,38) then
            TriggerServerEvent("conduite:verifpermis")

           
      
            if (ArgentJoueur>=3000)then
              if(gotpermisauto=="false")then
                DemarrerPermis()
               TriggerServerEvent("job:removeMoney",3000)
             else
               DrawMissionTextAuto("Vous avez déjà votre ~h~~g~permis auto~w~ !", 10000)
             end

            else

              DrawMissionTextAuto("Vous n'avez pas assez d'argent pour passer votre ~h~~r~permis auto~w~ (3000 €) !", 10000)

            end


             



            


        end


      end
    end 
  end
end)


Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)
    if voiture_sorti then 

        
         local kmh = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6
         local vitesse = math.ceil(kmh)

         

        local vehiclehealth = GetEntityHealth(GetVehiclePedIsIn(GetPlayerPed(-1), false))
        local max = GetEntityMaxHealth(GetVehiclePedIsIn(GetPlayerPed(-1), false)) 
        local pourcentage = (vehiclehealth / max) * 100


         if(vitesse>90)then
          tropvite="true"
         end

         if pourcentage < 99 then
          vehiculeabime = "true"

         end
        

         

              -- DrawMissionTextAuto("Speed : "..vitesse.." "..tropvite.." PV : "..vehiclehealth.." MAx :  ".. max .. " pourcentage : " .. pourcentage .."..", 50000)


        if IsNearArriveeAuto() then 
       DrawMarker(1,1233.53,-3330.7,4.60,0,0,0,0,0,0,2.001,2.0001,0.5001,255,100,100,200,0,0,0,0)
       ShowInfoPermis("Appuyez sur ~INPUT_CONTEXT~ pour valider votre ~b~permis auto~w~.", 0)
       if IsControlJustPressed(1,38) then

          local caissei = GetClosestVehicle(1233.53,-3330.7,4.60, 3.000, 0, 70)
          SetEntityAsMissionEntity(caissei, true, true)
          local plate = GetVehicleNumberPlateText(caissei)
          if DoesEntityExist(caissei) then
            if plate=="APPRENTI" then
                 SetEntityAsMissionEntity(caissei, true, true)
                 Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))

                 
                 if (tropvite~="true")then 


                  if(vehiculeabime~="true")then 
                       TriggerServerEvent("job:addMoney",1500)
                       DrawMissionTextAuto("Vous avez eu votre ~h~~g~permis auto~w~ !", 10000)

                       RemoveBlip(pointArrivee)
                       TriggerServerEvent('conduite:donnerpermisauto')

                       pointArrivee = nil
                       voiture_sorti = false
                       car_auto = nil
                       tropvite="false"
                       vehiculeabime = "false"

                    else
                         DrawMissionTextAuto("Vous n'avez pas eu votre ~h~~r~permis auto~w~, votre vehicule est ~r~ trop abîmé ~w~ !", 10000)
                            RemoveBlip(pointArrivee)

                           pointArrivee = nil
                           voiture_sorti = false
                           car_auto = nil
                           tropvite="false"
                            vehiculeabime = "false"
        

                    end

                else
                   DrawMissionTextAuto("Vous n'avez pas eu votre ~h~~r~permis auto~w~, vous roulez ~r~trop vite ~w~ !", 10000)

                 RemoveBlip(pointArrivee)

                 pointArrivee = nil
                 voiture_sorti = false
                 car_auto = nil
                 tropvite="false"
                 vehiculeabime = "false"

                end
              else

                DrawMissionTextAuto("Ce n'est pas le véhicule de ~h~~r~permis auto~w~ !", 10000)

                
               end
          else  
             DrawMissionTextAuto("Vous devez déposer une voiture d'auto école !", 10000)


            end

       end

       end


    end

  end
end)


