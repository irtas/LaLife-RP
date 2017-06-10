resource_type "gametype" { name = "Citizen V"}

description "itinerance"

-- Requiring essentialmode
dependency "essentialmode"

client_scripts {
  "map.lua",
  "stores/vehshop.lua"
}

server_scripts {
  "stores/vehshop_s.lua"
}
