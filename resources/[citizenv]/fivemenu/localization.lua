lang = {} -- global array for an entire resource

--------- LOAD LANGUAGE
Citizen.CreateThread(function()
	TriggerEvent("getLang", function(language)
		lang = language
  	TriggerEvent("itinerance:notif", lang.common.loaded)
	end)
end)
