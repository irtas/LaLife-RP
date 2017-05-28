local blips = {
  {name="Pole Emploi", colour=2, scale=1.2, id=351, x=-601.59295654297, y=-116.45598602295, z=41.734840393066},
   -- Airport and Airfield
   {name="Aéroport", colour=15, scale=1.0, id=90, x=-1032.690, y=-2728.141, z=13.757},
   {name="Aéroport", colour=15, scale=1.0, id=90, x=1743.6820, y=3286.2510, z=40.087},
   -- barbers
   --{name="Barber", id=71, x=-827.333, y=-190.916, z=37.599},
   --{name="Barber", id=71, x=130.512, y=-1715.535, z=29.226},
   --{name="Barber", id=71, x=-1291.472, y=-1117.230, z=6.641},
   {name="Coiffeur", colour=9, scale=1.0, id=71, x = 1933.6905517578, y = 3730.6245117188, z = 32.854434967041},
   {name="Coiffeur", colour=9, scale=1.0, id=71, x = 1211.2866210938, y = -474.07333374023, z = 66.218040466309},
   --{name="Barber", id=71, x=-30.109, y=-141.693, z=57.041},
   --{name="Barber", id=71, x=-285.238, y=6236.365, z=31.455},
   -- House
   --{name="Condo", id=162, x=-269.457214355469, y=-955.855529785156, z=31.2231330871582},
   --{name="Condo", id=162, x=-44.6460037231445, y=-587.163024902344, z=38.1613159179688},
   --{name="Condo", id=162, x=-43.9314346313477, y=-584.379028320313, z=38.1618614196777},
   --{name="Condo", id=162, x=-480.583343505859, y=-688.393371582031, z=33.2119483947754},
   --{name="Condo", id=162, x=-796.283264160156, y=336.186981201172, z=85.7004165649414},
   --{name="Hotel", id=162, x=414.587738037109, y=-217.593215942383, z=559.9104766845703},
   --{name="Hotel", id=162, x=-98.5413970947266, y=367.420593261719, z=113.274826049805},
   --{name="Hotel", id=162, x=-107.244064331055, y=369.226196289063, z=112.880752563477},
   --{name="Hotel", id=162, x=-116.21142578125, y=372.935424804688, z=112.88077545166},
   --{name="Maison Premium", id=162, x=-119.249359130859, y=564.305969238281, z=3183.96142578125},
   --{name="Maison Premium", id=162, x=374.177398681641, y=427.730651855469, z=145.684204101563},
   --{name="Maison Premium", id=162, x=-174.349594116211, y=502.55615234375, z=137.42024230957},
   --{name="Maison Premium", id=162, x=346.176666259766, y=440.199554443359, z=148.08430480957},
   --{name="Bureau sur Plage", id=162, x=-1910.7265625, y=-576.919189453125, z=19.0969314575195},
   --{name="Condo", id=162, x=-776.924255371094, y=318.661376953125, z=85.6626510620117},
   --{name="Condo", id=162, x=-635.626892089844, y=44.2951354980469, z=42.6980400085449},
   --{name="Bureau du Maire", id=58, x=-1581.46313476563, y=-558.558898925781, z=34.9528388977051},
   --{name="Condo", id=162, x=-1443.81750488281, y=-536.080017089844, z=34.7401390075684},
   --{name="Condo", id=162, x=-1450.7607421875, y=-540.988159179688, z=34.7401390075684},
   --{name="Condo", id=162, x=-1447.42456054688, y=-537.894348144531, z=34.7402763366699},
   --{name="Condo", id=162, x=-889.443298339844, y=-333.081909179688, z=34.6838188171387},
   --{name="Condo", id=162, x=-901.707275390625, y=-339.162506103516, z=34.6806182861328},
   --{name="Condo", id=162, x=-894.848999023438, y=-353.67626953125, z=34.6796798706055},
   --{name="Condo", id=162, x=-844.5498046875, y=-391.217437744141, z=31.4693260192871},
   --{name="Condo", id=162, x=-837.708801269531, y=-405.888824462891, z=31.4716987609863},
   --{name="Appartement plage 1er", id=162, x=-3093.06884765625, y=349.211853027344, z=7.53054094314575},
   --{name="Appartement plage 2e", id=162, x=-3100.38256835938, y=360.864776611328, z=7.59101963043213},
   --{name="Grange de Fortune", id=162, x=80.8491439819336, y=-6643.9287109375, z=31.9288063049316},
   --{name="Grange de Fortune", id=162, x=1929.818359375, y=4635.51953125, z=40.4547843933105},
   --{name="Grange Centre Ville", id=162, x=837.951599121094, y=-1375.06799316406, z=26.3081645965576},
   -- Informateurs
   --{name="Informateur", id=205, x=912.501, y=-298.260, z=65.634},
   --{name="Informateur", id=205, x=-100.464, y=-853.659, z=40.554},
   --{name="Informateur", id=205, x=209.358, y=-664.188, z=43.140},
   --{name="Informateur", id=205, x=-779.703, y=13.990, z=40.654},
   -- Stores
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = 25.66304397583, ['y'] = -1344.9215087891, ['z'] = 29.497022628784},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = -47.392501831055, ['y'] = -1756.6900634766, ['z'] = 29.420999526978},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = 374.37109375, ['y'] = 328.38735961914, ['z'] = 103.56639099121},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = 1135.5574951172, ['y'] = -981.91650390625, ['z'] = 46.415813446045},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = 1699.5518798828, ['y'] = 4923.439453125, ['z'] = 42.063678741455},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = 2676.59765625, ['y'] = 3281.6723632813, ['z'] = 55.241138458252},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = 1959.9449462891, ['y'] = 3742.8532714844, ['z'] = 32.343746185303},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = -2967.8518066406, ['y'] = 391.29086303711, ['z'] = 15.043312072754},
   {name="Magasin", colour=0, scale=0.9, id=52,  ['x'] = 1163.3321533203, ['y'] = -322.37133789063, ['z'] = 69.205078125},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = -1487.3131103516, ['y'] = -379.00604248047, ['z'] = 40.163421630859},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = -1222.7650146484, ['y'] = -907.10675048828, ['z'] = 12.326354026794},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = -707.35272216797, ['y'] = -913.16015625, ['z'] = 19.215595245361},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = -1821.3205566406, ['y'] = 793.60162353516, ['z'] = 138.11497497559},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = 1730.1866455078, ['y'] = 6417.048828125, ['z'] = 35.037227630615},
   {name="Magasin", colour=0, scale=0.9, id=52, ['x'] = 2555.2375488281, ['y'] = 382.17391967773, ['z'] = 108.62296295166},
    -- Clothing
   {name="Vêtements", colour=9, scale=0.9, id=73, x = 1696.5310058594, y = 4828.109375, z = 42.063121795654},
   {name="Vêtements", colour=9, scale=0.9, id=73, x = -162.85632324219, y = -303.03753662109, z = 39.733276367188},
   {name="Vêtements", colour=9, scale=0.9, id=73, x= 72.531211853027, y= -1396.3240966797, z= 29.376146316528},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=-718.985, y=-158.059, z=36.996},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=-151.204, y=-306.837, z=38.724},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=414.646, y=-807.452, z=29.338},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=-815.193, y=-1083.333, z=11.022},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=-1208.098, y=-782.020, z=17.163},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=-1457.954, y=-229.426, z=49.185},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=1681.586, y=4820.133, z=42.046},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=130.216, y=-202.940, z=54.505},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=618.701, y=2740.564, z=41.905},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=1199.169, y=2694.895, z=37.866},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=-3164.172, y=1063.927, z=20.674},
  --  {name="Vêtements", colour=9, scale=0.9, id=73, x=-1091.373, y=2702.356, z=19.422},
  --     --{name="Clothing", id=73, x=-2.777, y=6518.491, z=31.533},
  --   -- ammunationblips
  --  {name="Ammunition", colour=9, scale=0.9, id=110, x=1701.292, y=3750.450, z=34.365},
  --  {name="Ammunition", colour=9, scale=0.9, id=110, x=237.428, y=-43.655, z=69.698},
  --  {name="Ammunition", colour=9, scale=0.9, id=110, x=843.604, y=-1017.784, z=27.546},
  --  {name="Ammunition", colour=9, scale=0.9, id=110, x=-664.218, y=-950.097, z=21.509},
  --  {name="Ammunition", colour=9, scale=0.9, id=110, x=-1320.983, y=-389.260, z=36.483},
  --  {name="Ammunition", colour=9, scale=0.9, id=110, x=-1109.053, y=2686.300, z=18.775},
  --  {name="Ammunition", colour=9, scale=0.9, id=110, x=2568.379, y=309.629, z=108.461},
  --  {name="Ammunition", colour=9, scale=0.9, id=110, x=-3157.450, y=1079.633, z=20.692},
      --{name="Weapon store", id=110, x=-321.524, y=6072.479, z=31.299},
    -- Basic
   --{name="Comedy Club", id=102, x=377.088, y=-991.869, z=-97.604},
    --{name="Franklin", id=210, x=7.900, y=548.100, z=175.500},
    --{name="Franklin", id=210, x=-14.128,	y=-1445.483,	z=30.648},
    --{name="Michael", id=124, x=-852.400, y=160.000, z=65.600},
    --{name="Trevor", id=208, x=1985.700, y=3812.200, z=32.200},
    --{name="Trevor", id=208, x=-1159.034,	y=-1521.180, z=10.633},
   --{name="FIB", id=106, x=105.455, y=-745.483, z=44.754},
   --{name="Lifeinvader", id=77, x=-1047.900, y=-233.000, z=39.000},
   --{name="Cluckin Bell", id=357, x=-72.68752, y=6253.72656, z=31.08991},
   --{name="Tequil-La La", id=93, x=-565.171, y=276.625, z=83.286},
   --{name="O'Neil Ranch", id=438, x=2441.200, y=4968.500, z=51.700},
   --{name="Play Boy Mansion", id=439, x=-1475.234, y=167.088, z=55.841},
    --{name="Hippy Camp", id=140, x=2476.712, y=3789.645, z=41.226},
   --{name="Chop shop", id=446, x=479.056, y=-1316.825, z=28.203},
   --{name="Rebel Radio", id=136, x=736.153, y=2583.143, z=79.634},
   --{name="Morgue", id=310, x=243.351, y=-1376.014, z=39.534},
   --{name="Golf", id=109, x=-1336.715, y=59.051, z=55.246 },
   --{name="Jewelry Store", id=52,  x=-630.400, y=-236.700, z=40.00},
    -- Propperty
   --{name="Casino", id=207, x=925.329, y=46.152, z=80.908 },
   --{name="Maze Bank Arena", id=135, x=-250.604, y=-2030.000, z=30.000},
   --{name="Stripbar", id=121, x=134.476, y=-1307.887, z=28.983},
   --{name="Smoke on the Water", id=140, x=-1171.42, y=-1572.72, z=3.6636},
    --{name="Weed Farm", id=140, x=2208.777, y=5578.235, z=53.735},
   --{name="Downtown Cab Co", id=375, x=900.461, y=-181.466, z=73.89},
   --{name="Theater", id=135, x=293.089, y=180.466, z=104.301},
    -- Gangs
    --{name="Gang", id=437, x=298.68, y=-2010.10, z=20.07},
    --{name="Gang", id=437, x=86.64, y=-1924.60, z=20.79},
    --{name="Gang", id=437, x=-183.52, y=-1632.62, z=33.34},
    --{name="Gang", id=437, x=989.37, y=-1777.56, z=31.32},
    --{name="Gang", id=437, x=960.24, y=-140.31, z=74.50},
    --{name="Gang", id=437, x=-1042.29, y=4910.17, z=94.92},
    -- Gas stations
   {name="Gas Station", colour=76, scale=0.7, id=361, x=49.4187,   y=2778.793,  z=58.043},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=263.894,   y=2606.463,  z=44.983},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=1039.958,  y=2671.134,  z=39.550},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=1207.260,  y=2660.175,  z=37.899},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=2539.685,  y=2594.192,  z=37.944},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=2679.858,  y=3263.946,  z=55.240},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=2005.055,  y=3773.887,  z=32.403},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=1687.156,  y=4929.392,  z=42.078},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=1701.314,  y=6416.028,  z=32.763},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=179.857,   y=6602.839,  z=31.868},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=-94.4619,  y=6419.594,  z=31.489},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=-2554.996, y=2334.40,  z=33.078},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=-1800.375, y=803.661,  z=138.651},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=-1437.622, y=-276.747,  z=46.207},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=-2096.243, y=-320.286,  z=13.168},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=-724.619, y=-935.1631,  z=19.213},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=-526.019, y=-1211.003,  z=18.184},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=-70.2148, y=-1761.792,  z=29.534},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=265.648,  y=-1261.309,  z=29.292},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=819.653,  y=-1028.846,  z=26.403},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=1208.951, y= -1402.567, z=35.224},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=1181.381, y= -330.847,  z=69.316},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=620.843,  y= 269.100,  z=103.089},
   {name="Gas Station", colour=76, scale=0.7, id=361, x=2581.321, y=362.039, 108.468},
    -- Police Stations
   {name="Commisariat", colour=3, scale=1.0, id=60, x=425.130, y=-979.558, z=30.711},
   --{name="Police Station", id=60, x=1859.234, y= 3678.742, z=33.690},
   --{name="Police Station", id=60, x=-438.862, y=6020.768, z=31.490},
   --{name="Police Station", id=60, x=818.221, y=-1289.883, z=26.300},
   --{name="Prison", id=285, x=1679.049, y=2513.711, z=45.565},
    -- Hospitals
   --{name="Hospital", id=61, x= 1839.6, y= 3672.93, z= 34.28},
   --{name="Hospital", id=61, x= -247.76, y= 6331.23, z=32.43},
   --{name="Hospital", id=61, x= -449.67, y= -340.83, z= 34.50},
   --{name="Hospital", id=61, x= 357.43, y= -593.36, z= 28.79},
   {name="Hôpital", colour=3, scale=1.0, id=61, x= 295.83, y= -1446.94, z= 29.97},
   --{name="Hospital", id=61, x= -676.98, y= 310.68, z= 83.08},
   --{name="Hospital", id=61, x= 1151.21, y= -1529.62, z= 35.37},
   --{name="Hospital", id=61, x= -874.64, y= -307.71, z= 39.58},
    -- Vehicle Shop (Simeon)
   --{name="Simeon", id=120, x=-33.803, y=-1102.322, z=25.422},
    -- LS Customs
   --{name="LS Customs", id=72, x= -362.796, y= -132.400, z= 38.252},
   --{name="LS Customs", id=72, x= -1140.19, y= -1985.478, z= 12.729},
   --{name="LS Customs", id=72, x= 716.464, y= -1088.869, z= 21.929},
   --{name="LS Customs", id=72, x= 1174.81, y= 2649.954, z= 37.371},
   --{name="LS Customs", id=72, x= 118.485, y= 6619.560, z= 31.802},
    -- Lester
    --{name="Lester", id=77, x=1248.183, y=-1728.104, z=56.000},
    --{name="Lester", id=77, x=719.000, y=-975.000, y=25.000},
    -- Survivals
    --{name="Survival", id=305, x=2351.331, y=3086.969, z=48.057},
    --{name="Survival", id=305, x=-1695.803, y=-1139.190, z=13.152},
    --{name="Survival", id=305, x=1532.52, y=-2138.682, z=77.120},
    --{name="Survival", id=305, x=-593.724, y=5283.231, z=70.230},
    --{name="Survival", id=305, x=1891.436, y=3737.409, z=32.513},
    --{name="Survival", id=305, x=195.572, y=-942.493, z=30.692},
    --{name="Survival", id=305, x=1488.579, y=3582.804, z=35.345},

    --{name="Safehouse", id=357, x=-952.35943603516, y= -1077.5021972656, z=2.6772258281708},
    --{name="Safehouse", id=357, x=-59.124889373779, y= -616.55456542969, z=37.356777191162},
    --{name="Safehouse", id=357, x=-255.05390930176, y= -943.32885742188, z=31.219989776611},
    --{name="Safehouse", id=357, x=-771.79888916016, y= 351.59423828125, z=87.998191833496},
    --{name="Safehouse", id=357, x=-3086.428, y=339.252, z=6.371},
    --{name="Safehouse", id=357, x=-917.289, y=-450.206, z=39.600},


   --{name="Race", id=316, x=-1277.629, y=-2030.913, z=1.2823},
   --{name="Race", id=316, x=2384.969, y=4277.583, z=30.379},
   --{name="Race", id=316, x=1577.881, y=3836.107, z=30.7717},
    -- Yacht
   --{name="Yacht", id=410, x=-2045.800, y=-1031.200, z=11.900},
   --{name="Cargoship", id=410, x=-90.000, y=-2365.800, z=14.300},
  }

Citizen.CreateThread(function()

    for _, item in pairs(blips) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      SetBlipColour(item.blip, item.colour)
      SetBlipScale(item.blip, item.scale)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end

  --load unloaded ipl's
  LoadMpDlcMaps()
  EnableMpDlcMaps(true)
  RequestIpl("chop_props")
  RequestIpl("FIBlobby")
  RemoveIpl("FIBlobbyfake")
  RequestIpl("FBI_colPLUG")
  RequestIpl("FBI_repair")
  RequestIpl("v_tunnel_hole")
  RequestIpl("TrevorsMP")
  RequestIpl("TrevorsTrailer")
  RequestIpl("TrevorsTrailerTidy")
  RemoveIpl("farm_burnt")
  RemoveIpl("farm_burnt_lod")
  RemoveIpl("farm_burnt_props")
  RemoveIpl("farmint_cap")
  RemoveIpl("farmint_cap_lod")
  RequestIpl("farm")
  RequestIpl("farmint")
  RequestIpl("farm_lod")
  RequestIpl("farm_props")
  RequestIpl("facelobby")
  RemoveIpl("CS1_02_cf_offmission")
  RequestIpl("CS1_02_cf_onmission1")
  RequestIpl("CS1_02_cf_onmission2")
  RequestIpl("CS1_02_cf_onmission3")
  RequestIpl("CS1_02_cf_onmission4")
  RequestIpl("v_rockclub")
  RemoveIpl("hei_bi_hw1_13_door")
  RequestIpl("bkr_bi_hw1_13_int")
  RequestIpl("ufo")
  RemoveIpl("v_carshowroom")
  RemoveIpl("shutter_open")
  RemoveIpl("shutter_closed")
  RemoveIpl("shr_int")
  RemoveIpl("csr_inMission")
  RequestIpl("v_carshowroom")
  RequestIpl("shr_int")
  RequestIpl("shutter_closed")
  RequestIpl("smboat")
  RequestIpl("cargoship")
  RequestIpl("railing_start")
  RemoveIpl("sp1_10_fake_interior")
  RemoveIpl("sp1_10_fake_interior_lod")
  RequestIpl("sp1_10_real_interior")
  RequestIpl("sp1_10_real_interior_lod")
  RemoveIpl("id2_14_during_door")
  RemoveIpl("id2_14_during1")
  RemoveIpl("id2_14_during2")
  RemoveIpl("id2_14_on_fire")
  RemoveIpl("id2_14_post_no_int")
  RemoveIpl("id2_14_pre_no_int")
  RemoveIpl("id2_14_during_door")
  RequestIpl("id2_14_during1")
  RequestIpl("coronertrash")
  RequestIpl("Coroner_Int_on")
  RemoveIpl("Coroner_Int_off")
  RemoveIpl("bh1_16_refurb")
  RemoveIpl("jewel2fake")
  RemoveIpl("bh1_16_doors_shut")
  RequestIpl("refit_unload")
  RequestIpl("post_hiest_unload")
  RequestIpl("Carwash_with_spinners")
  RequestIpl("ferris_finale_Anim")
  RemoveIpl("ch1_02_closed")
  RequestIpl("ch1_02_open")
  RequestIpl("AP1_04_TriAf01")
  RequestIpl("CS2_06_TriAf02")
  RequestIpl("CS4_04_TriAf03")
  RemoveIpl("scafstartimap")
  RequestIpl("scafendimap")
  RemoveIpl("DT1_05_HC_REMOVE")
  RequestIpl("DT1_05_HC_REQ")
  RequestIpl("DT1_05_REQUEST")
  RequestIpl("FINBANK")
  RemoveIpl("DT1_03_Shutter")
  RemoveIpl("DT1_03_Gr_Closed")
  RequestIpl("ex_sm_13_office_01a")
  RequestIpl("ex_sm_13_office_01b")
  RequestIpl("ex_sm_13_office_02a")
  RequestIpl("ex_sm_13_office_02b")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local players = {}

    for i = 0, 31 do
      if NetworkIsPlayerActive(i) then
        table.insert(players, i)
      end
    end

    for k, v in pairs(players) do
      if not GetBlipFromEntity(GetPlayerPed(v)) then
        if GetPlayerPed(v) == GetPlayerPed(-1) then return end
        local blip = AddBlipForEntity(GetPlayerPed(v))
        SetBlipColour(blip, 1)
      end
    end
  end
end)
