using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenVWrapper.Utils;
using System;
using System.Threading.Tasks;

namespace CitizenVWrapper.Police
{

    class Police : BaseScript
    {

        private bool PhandCuffed = false;
        private bool PEscorthandCuffed = false;
        private string PhandCuffedName = "";

        private bool handCuffed = false;
        private bool EscorthandCuffed = false;

        public Police()
        {
            //Différents type d'event handler possible.

            //1. EventHandlers[Events.XP_ADD] += new Action<int>(AddXP);

            //2. EventHandlers["onClientMapStart"] += new Action<dynamic>(ecksdee => TriggerServerEvent(Events.PLAYER_JOINED, Game.Player.Handle));

            //3. EventHandlers[Events.PLAYERSPAWNED] += new Action<dynamic>(lol =>
            //   {
            //       Function.Call(Hash.SET_CAN_ATTACK_FRIENDLY, Game.PlayerPed.Handle, true, false);
            //       Function.Call(Hash.NETWORK_SET_FRIENDLY_FIRE_OPTION, true);
            //   });

            EventHandlers[Events.VERIFP] += new Action<int>(VerifP);
            EventHandlers[Events.FVERIFP] += new Action<string, string, string, string>(FVerifP);

            EventHandlers[Events.GIVECON] += new Action<int, int>(GiveCon);

            EventHandlers[Events.SEARCHVEH] += new Action<int>(SearchVeh);
            EventHandlers[Events.FSEARCHVEH] += new Action<dynamic>(FSearchVeh);

            EventHandlers[Events.SEARCHCIV] += new Action<int>(SearchCiv);
            EventHandlers[Events.FSEARCHCIV] += new Action<dynamic, int>(FSearchCiv);

            EventHandlers[Events.CUFF] += new Action<int>(Cuff);
            EventHandlers[Events.FCUFF] += new Action(FCuff);

            EventHandlers[Events.ESCORTCUFF] += new Action<int>(EscortCuff);
            EventHandlers[Events.FESCORTCUFF] += new Action<int, string, bool>(FEscortCuff);

            EventHandlers[Events.UNCUFF] += new Action<int>(UnCuff);
            EventHandlers[Events.FUNCUFF] += new Action(FUnCuff);

            EventHandlers[Events.CIVTOCAR] += new Action<int>(CivToCar);
            EventHandlers[Events.FCIVTOCAR] += new Action<float, int>(FCivToCar);

            EventHandlers[Events.CIVUNCAR] += new Action<int>(CivUnCar);
            EventHandlers[Events.FCIVUNCAR] += new Action(FCivUnCar);

            EventHandlers[Events.UNLOCK] += new Action(Unlock);

            EventHandlers[Events.SEIZECASH] += new Action<int>(SeizeCash);
            EventHandlers[Events.SEIZEDRUG] += new Action<int>(SeizeDrug);

            Tick += OnTick;

        }

        private async void SeizeCash(int target)
        {
                if (target != -1)
                {
                    Function.Call(Hash.TASK_START_SCENARIO_IN_PLACE, Game.PlayerPed, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, 1);
                    Function.Call(Hash._PLAY_AMBIENT_SPEECH1, Game.PlayerPed, "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE");
                    await Delay(5000);
                    Function.Call(Hash.CLEAR_PED_TASKS_IMMEDIATELY, Game.PlayerPed);

                    TriggerServerEvent("menupolice:seizecash_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target));
                }
                else
                {
                    TriggerEvent("es_freeroam:notif", Strings.NO_TARGET);
                }
        }

        private async void SeizeDrug(int target)
        {
                if (target != -1)
                {
                    Function.Call(Hash.TASK_START_SCENARIO_IN_PLACE, Game.PlayerPed, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, 1);
                    Function.Call(Hash._PLAY_AMBIENT_SPEECH1, Game.PlayerPed, "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE");
                    await Delay(5000);
                    Function.Call(Hash.CLEAR_PED_TASKS_IMMEDIATELY, Game.PlayerPed);

                    TriggerServerEvent("menupolice:seizedrug_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target));
                }
                else
                {
                    TriggerEvent("es_freeroam:notif", Strings.NO_TARGET);
                }
        }

        private async void VerifP(int target)
        {
                if (target != -1)
                {
                    Function.Call(Hash.TASK_START_SCENARIO_IN_PLACE, Game.PlayerPed, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, 1);
                    Function.Call(Hash._PLAY_AMBIENT_SPEECH1, Game.PlayerPed, "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE");
                    await Delay(5000);
                    Function.Call(Hash.CLEAR_PED_TASKS_IMMEDIATELY, Game.PlayerPed);

                    TriggerServerEvent("menupolice:verifp_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target));
                }
                else
                {
                    TriggerEvent("es_freeroam:notif", Strings.NO_TARGET);
                }
        }

        private void FVerifP(string a, string b, string c, string d)
        {
                TriggerEvent("es_freeroam:notif", a);
                TriggerEvent("es_freeroam:notif", b);
                TriggerEvent("es_freeroam:notif", c);
                TriggerEvent("es_freeroam:notif", d);
        }

        private async void GiveCon(int target, int amount)
        {
                if (target != -1)
                {
                    Function.Call(Hash.TASK_START_SCENARIO_IN_PLACE, Game.PlayerPed, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, 1);
                    Function.Call(Hash._PLAY_AMBIENT_SPEECH1, Game.PlayerPed, "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE");
                    await Delay(5000);
                    Function.Call(Hash.CLEAR_PED_TASKS_IMMEDIATELY, Game.PlayerPed);
                    TriggerServerEvent("menupolice:givecon_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target), amount);
                    TriggerEvent("es_freeroam:notif", "~g~Contravention de " + amount.ToString() + "$ envoyé");
                }
                else
                {
                    TriggerEvent("es_freeroam:notif", Strings.NO_TARGET);
                }
        }

        private async void SearchVeh(int target)
        {
                Vector3 plyCoords = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, Game.PlayerPed, 0);
                await Delay(1);
                int car = Function.Call<int>(Hash.GET_CLOSEST_VEHICLE, plyCoords.X, plyCoords.Y, plyCoords.Z, 5.000, 0, 70);
                Function.Call(Hash.SET_ENTITY_AS_MISSION_ENTITY, car, true, true);
                if (Function.Call<bool>(Hash.DOES_ENTITY_EXIST, car))
                {
                    var platecar = Function.Call<string>(Hash.GET_VEHICLE_NUMBER_PLATE_TEXT, car);
                    if (platecar != null)
                    {
                        Function.Call(Hash.TASK_START_SCENARIO_IN_PLACE, Game.PlayerPed, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, 1);
                        Function.Call(Hash._PLAY_AMBIENT_SPEECH1, Game.PlayerPed, "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE");
                        await Delay(5000);
                        Function.Call(Hash.CLEAR_PED_TASKS_IMMEDIATELY, Game.PlayerPed);

                        TriggerServerEvent("menupolice:searchveh_s", platecar);
                    }

                }
                else
                {
                    TriggerEvent("es_freeroam:notif", "Aucun véhicule a inspecter.");
                }
        }

        private void FSearchVeh(dynamic vehitems)
        {
                TriggerEvent("es_freeroam:notif", vehitems.name.ToString());
                if (vehitems.name == "Véhicule volé")
                {
                    TriggerEvent("es_freeroam:notif", vehitems.name.ToString());
                }
		        else
                {
                    TriggerEvent("es_freeroam:notif", "Véhicule à: "+vehitems.name.ToString());
                }
        }

        private async void SearchCiv(int target)
        {
                if (target != -1)
                {
                    Function.Call(Hash.TASK_START_SCENARIO_IN_PLACE, Game.PlayerPed, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, 1);
                    Function.Call(Hash._PLAY_AMBIENT_SPEECH1, Game.PlayerPed, "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE");
                    await Delay(5000);
                    Function.Call(Hash.CLEAR_PED_TASKS_IMMEDIATELY, Game.PlayerPed);
                    TriggerServerEvent("menupolice:searchciv_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target));
                }
                else
                {
                    TriggerEvent("es_freeroam:notif", Strings.NO_TARGET);
                }
        }

        private void FSearchCiv(dynamic civitems, int civlenght)
        {
                for (int i = 0; i < civlenght; i++)
                {
                    if (civitems[i].quantity > 0)
                        TriggerEvent("es_freeroam:notif", civitems[i].libelle +" "+ civitems[i].quantity);
                }
        }

        private void FCuff()
        {
                 handCuffed = true;
        }

        private void Cuff(int target)
        {
                  PhandCuffed = true;
                //TriggerServerEvent("menupolice:cuff_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target));
        }

        private void EscortCuff(int target)
        {
                if (PEscorthandCuffed || PhandCuffed)
                {
                    string pname = Function.Call<string>(Hash.GET_PLAYER_NAME, Game.PlayerPed);
                    PhandCuffed = !PhandCuffed;
                    PEscorthandCuffed = !PEscorthandCuffed;
                    TriggerServerEvent("menupolice:escortcuff_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target), pname);
                }
                else
                {
                    TriggerEvent("es_freeroam:notif", "Aucun civil à proximité n'est menotté");
                }
        }

        private void FEscortCuff(int civitem, string pname, bool lebool)
        {          
                if (lebool)
                {
                    PhandCuffedName = pname;
                    EscorthandCuffed = !EscorthandCuffed;
                    handCuffed = !handCuffed;
                }              
        }

        private void UnCuff(int target)
        {
                if (PhandCuffed)
                {
                    PhandCuffed = false;
                    //TriggerServerEvent("menupolice:uncuff_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target));
                }
                else
                {
                    TriggerEvent("es_freeroam:notif", "Aucun civil à proximité n'est menotté");
                }
        }

        private void FUnCuff()
        {
                handCuffed = false;
        }

        private void CivToCar(int target)
        {
                float pos = Function.Call<float>(Hash.GET_ENTITY_HEADING, Game.PlayerPed);
                int v = Function.Call<int>(Hash.GET_VEHICLE_PED_IS_IN, Game.PlayerPed, true);
                TriggerServerEvent("menupolice:civtocar_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target), pos, v);
        }

        private float getHead(float param)
        {
            float head = param - 90;
            if (head < 0)
            {
                head -= 1;
            }
            return head;
        }

        private async void FCivToCar(float pos, int v)
        {
                if (handCuffed)
                {
                    TriggerEvent("menupolice:f_uncuff");
                    handCuffed = false;
                    await Delay(1000);
                    float head = getHead(pos);
                    Function.Call(Hash.SET_ENTITY_HEADING, Game.PlayerPed, head);
                    Vector3 Playerpos = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, Game.PlayerPed, 0);
                    Vector3 entityWorld = Function.Call<Vector3>(Hash.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS, Game.PlayerPed, 0.0, 20.0, 0.0);
                    var rayHandle = Function.Call<int>(Hash._CAST_RAY_POINT_TO_POINT, Playerpos.X, Playerpos.Y, Playerpos.Z, entityWorld.X, entityWorld.Y, entityWorld.Z, 10, Game.PlayerPed, 0);
                    RaycastResult vehicleHandle = new RaycastResult(rayHandle);
                    if (vehicleHandle.DitHitEntity)
                    {
                        Entity veh = vehicleHandle.HitEntity;

                        //Vector3 plyCoords = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, Game.PlayerPed, 0);
                        //await Delay(1);
                        //int veh = Function.Call<int>(Hash.GET_CLOSEST_VEHICLE, plyCoords.X, plyCoords.Y, plyCoords.Z, 10.001, 0, 70);
                        //Function.Call(Hash.SET_ENTITY_AS_MISSION_ENTITY, veh, true, true);

                        //if (Function.Call<bool>(Hash.DOES_ENTITY_EXIST, car))


                        //if (Function.Call<bool>(Hash.DOES_ENTITY_EXIST, car))

                        //Vector3 Playerpos = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, Game.PlayerPed);
                        //int veh = Function.Call<int>(Hash.GET_CLOSEST_VEHICLE, Playerpos.X, Playerpos.Y, Playerpos.Z, 10.0, 0, 70);
                        //Function.Call(Hash.TASK_ENTER_VEHICLE, Game.PlayerPed, veh, -1, 2, 2.0001, 1);
                        await Delay(100);

                        //Vehicle vehi = new Vehicle(veh);
                        if (Function.Call<bool>(Hash.IS_VEHICLE_SEAT_FREE, veh, 1))
                        {
                            Function.Call(Hash.TASK_ENTER_VEHICLE, Game.PlayerPed, veh, -1, 1, 2.0001, 1);
                            while (Function.Call<bool>(Hash.IS_VEHICLE_SEAT_FREE, veh, 1))
                            {
                                await Delay(0);
                            }
                        }
                        else
                        {
                            Function.Call(Hash.TASK_ENTER_VEHICLE, Game.PlayerPed, veh, -1, 2, 2.0001, 1);
                            while (Function.Call<bool>(Hash.IS_VEHICLE_SEAT_FREE, veh, 2))
                            {
                                await Delay(0);
                            }
                        }
                        
                    }
                    handCuffed = true;
                    TriggerEvent("menupolice:f_cuff");

                }
        }

        private void CivUnCar(int target)
        {
                TriggerServerEvent("menupolice:civuncar_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target));
        }

        private void FCivUnCar()
        {
                if (handCuffed)
                {
                    int v = Function.Call<int>(Hash.GET_VEHICLE_PED_IS_IN, Game.PlayerPed, true);
                    Function.Call(Hash.TASK_LEAVE_VEHICLE, Game.PlayerPed, v, 0);
                }
        }

        private void Unlock()
        {
                Vector3 Playerpos = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, Game.PlayerPed);
                Vector3 entityWorld = Function.Call<Vector3>(Hash.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS, Game.PlayerPed, 0.0, 20.0, 0.0);
                var rayHandle = Function.Call<int>(Hash._CAST_RAY_POINT_TO_POINT, Playerpos.X, Playerpos.Y, Playerpos.Z, entityWorld.X, entityWorld.Y, entityWorld.Z, 10, Game.PlayerPed, 0);
                RaycastResult vehicleHandle = new RaycastResult(rayHandle);
                Entity veh = vehicleHandle.HitEntity;
                if (Function.Call<bool>(Hash.DOES_ENTITY_EXIST, veh))
                {
                    Function.Call(Hash.SET_VEHICLE_DOORS_LOCKED, veh, 1);
                    TriggerEvent("es_freeroam:notif", "~g~Véhicule déverouillé");
                    TriggerEvent("InteractSound_CL:PlayOnOne", "unlock", 1.0);
                }
                else
                {
                    TriggerEvent("es_freeroam:notif", "~r~Aucun véhicle à proximité.");
                }
        }

        private async Task OnTick()
        {

            //foreach (Player player in Players)
            //{
            //    Ped playerPed = player.Character;
            //    if (player != Game.Player && playerPed != null && playerPed.AttachedBlip == null)
            //    {
            //        Blip playerBlip = playerPed.AttachBlip();
            //        playerBlip.Sprite = BlipSprite.Standard;
            //        playerBlip.Scale = 0.8f;
            //        Function.Call(Hash.SET_BLIP_NAME_TO_PLAYER_NAME, playerBlip.Handle, player.Handle);
            //        Function.Call(Hash._SET_BLIP_SHOW_HEADING_INDICATOR, playerBlip.Handle, true);
            //    }
            //}

            if (handCuffed)
            {
                Function.Call(Hash.REQUEST_ANIM_DICT, "mp_arresting");


                while (!Function.Call<bool>(Hash.HAS_ANIM_DICT_LOADED, "mp_arresting"))
                {
                    await Delay(0);
                }

                var myPed = Game.PlayerPed;
                var animation = "idle";
                var flags = 16;

                Function.Call(Hash.TASK_PLAY_ANIM, myPed, "mp_arresting", animation, 8.0, -8, -1, flags, 0, 0, 0, 0);
            }

            if (EscorthandCuffed)
            {
                var playerPed = Game.PlayerPed;
                for (int i = 0; i < 31; i++)
                {
                    var ped = Function.Call<int>(Hash.GET_PLAYER_PED, i);
 
                    if (Function.Call<bool>(Hash.NETWORK_IS_PLAYER_CONNECTED, i))
                    {
                 
                        if (Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, i) != Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, Function.Call<int>(Hash.PLAYER_ID)))
                        {
                     
                            Vector3 pos = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, playerPed);
                            Vector3 pos2 = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, ped);
                            if (Function.Call<float>(Hash.GET_DISTANCE_BETWEEN_COORDS, pos.X, pos.Y, pos.Z, pos2.X, pos2.Y, pos2.Z) < 5.001)
                            {
                            
                                //if (Function.Call<string>(Hash.GET_PLAYER_NAME, i) == PhandCuffedName)
                                //{
                                    
                                    Function.Call(Hash.TASK_FOLLOW_TO_OFFSET_OF_ENTITY, playerPed, ped, 1.5, 1.5, 1.5, 1, 1, 2, 1);
                                    //Function.Call(Hash.TASK_GO_TO_ENTITY, Game.PlayerPed, ped, -1, 0.1, 10.0, 1073741824.0, 0);
                                    //Function.Call(Hash.SET_PED_KEEP_TASK, Game.PlayerPed, true);
                                //}
                            }
                        }
                    }
                }
            }

            await Task.FromResult(0);
        }

    }
}

