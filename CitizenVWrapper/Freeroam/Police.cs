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
        private bool Jailed1 = false;
        private bool Jailed2 = false;
        private bool Jailed3 = false;

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

            EventHandlers[Events.JAIL] += new Action<int>(Jail);
            EventHandlers[Events.FJAIL] += new Action<int>(Fjail);

            EventHandlers[Events.UNJAIL] += new Action<int, int, int>(unJail);
            EventHandlers[Events.FUNJAIL] += new Action<int>(Funjail);

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
                    TriggerEvent("citizenv:notif", Strings.NO_TARGET);
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
                    TriggerEvent("citizenv:notif", Strings.NO_TARGET);
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
                    TriggerEvent("citizenv:notif", Strings.NO_TARGET);
                }
        }

        private void FVerifP(string a, string b, string c, string d)
        {
                TriggerEvent("citizenv:notif", a);
                TriggerEvent("citizenv:notif", b);
                TriggerEvent("citizenv:notif", c);
                TriggerEvent("citizenv:notif", d);
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
                    TriggerEvent("citizenv:notif", "~g~Contravention de " + amount.ToString() + "$ envoyé");
                }
                else
                {
                    TriggerEvent("citizenv:notif", Strings.NO_TARGET);
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
                    TriggerEvent("citizenv:notif", "Aucun véhicule a inspecter.");
                }
        }

        private void FSearchVeh(dynamic vehitems)
        {
                TriggerEvent("citizenv:notif", vehitems.name.ToString());
                if (vehitems.name == "Véhicule volé")
                {
                    TriggerEvent("citizenv:notif", vehitems.name.ToString());
                }
		        else
                {
                    TriggerEvent("citizenv:notif", "Véhicule à: "+vehitems.name.ToString());
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
                    TriggerEvent("citizenv:notif", Strings.NO_TARGET);
                }
        }

        private void FSearchCiv(dynamic civitems, int civlenght)
        {
                for (int i = 0; i < civlenght; i++)
                {
                    if (civitems[i].quantity > 0)
                        TriggerEvent("citizenv:notif", civitems[i].libelle +" "+ civitems[i].quantity);
                }
        }

        private void FCuff()
        {
                handCuffed = true;
                TriggerEvent("handsup:toggle", false);
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
                    TriggerEvent("citizenv:notif", "Aucun civil à proximité n'est menotté");
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
                    TriggerEvent("citizenv:notif", "Aucun civil à proximité n'est menotté");
                }
        }

        private void FUnCuff()
        {
                handCuffed = false;
                TriggerEvent("handsup:toggle", true);
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

        private async void FCivUnCar()
        {
                if (handCuffed)
                {
                    TriggerEvent("menupolice:f_uncuff");
                    handCuffed = false;
                    int v = Function.Call<int>(Hash.GET_VEHICLE_PED_IS_IN, Game.PlayerPed, true);
                    Function.Call(Hash.TASK_LEAVE_VEHICLE, Game.PlayerPed, v, 0);
                    await Delay(2000);
                    handCuffed = true;
                    TriggerEvent("menupolice:f_cuff");
                }
        }

        private async void Unlock()
        {
                Vector3 Playerpos = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, Game.PlayerPed);
                Vector3 entityWorld = Function.Call<Vector3>(Hash.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS, Game.PlayerPed, 0.0, 20.0, 0.0);
                var rayHandle = Function.Call<int>(Hash._CAST_RAY_POINT_TO_POINT, Playerpos.X, Playerpos.Y, Playerpos.Z, entityWorld.X, entityWorld.Y, entityWorld.Z, 10, Game.PlayerPed, 0);
                RaycastResult vehicleHandle = new RaycastResult(rayHandle);
                Entity veh = vehicleHandle.HitEntity;
                if (Function.Call<bool>(Hash.DOES_ENTITY_EXIST, veh))
                {
                    await Delay(3000);
                    Function.Call(Hash.SET_VEHICLE_DOORS_LOCKED, veh, 1);
                    TriggerEvent("citizenv:notif", "~g~Véhicule déverouillé");
                    TriggerEvent("InteractSound_CL:PlayOnOne", "unlock", 1.0);
                }
                else
                {
                    TriggerEvent("citizenv:notif", "~r~Aucun véhicle à proximité.");
                }
        }

        private void Jail(int target)
        {
            TriggerServerEvent("menupolice:jail_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target));
        }

        private void Fjail(int jailNumber)
        {
            if (handCuffed)
            {
                TriggerEvent("menupolice:f_uncuff");
                handCuffed = false;
                switch (jailNumber)
                {
                    case 1:
                        Jailed1 = true;
                        break;
                    case 2:
                        Jailed2 = true;
                        break;
                    case 3:
                        Jailed3 = true;
                        break;
                    default:
                        Jailed1 = true;
                        break;
                }
            }
        }

        private async void unJail(int target, int jailNumber, int police)
        {
            TriggerEvent("citizenv:notif", "~g~ Ouverture de la cellule...");
            if (police >= 1)
            {
                TriggerServerEvent("menupolice:unjail_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target), jailNumber);
                TriggerEvent("citizenv:notif", "~g~Cellule ouverte");
            }
            else
            {
                await Delay(5000);
                TriggerServerEvent("menupolice:civunjail_s", Function.Call<int>(Hash.GET_PLAYER_SERVER_ID, target), jailNumber);
                TriggerEvent("citizenv:notif", "~g~Cellule ouverte");
            }
        }

        private void Funjail(int jailNumber)
        {
            TriggerEvent("citizenv:notif", "~g~Vous avez été libéré");
            if (jailNumber == 1)
            {
                TriggerEvent("menupolice:cuff");
                handCuffed = true;
                Jailed1 = false;
            }
            else if (jailNumber == 2)
            {
                TriggerEvent("menupolice:cuff");
                handCuffed = true;
                Jailed2 = false;
            }
            else if (jailNumber == 3)
            {
                TriggerEvent("menupolice:cuff");
                handCuffed = true;
                Jailed3 = false;
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

            //if (Game.IsControlJustReleased(1, Control.Aim))
            //{
            //    TriggerEvent("citizenv:notif", "Allo");
            //    Jailed1 = true;
            //}

            //if (Game.IsControlJustReleased(1, Control.Attack))
            //{
            //    TriggerEvent("citizenv:notif", "Allo");
            //    Jailed1 = false;
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

            if (Jailed1)
            {
                Vector3 Jail = new Vector3(459.39462280273f, -994.36492919922f, 24.714873123169f);
                if(Function.Call<float>(Hash.GET_DISTANCE_BETWEEN_COORDS, Game.PlayerPed.Position.X, Game.PlayerPed.Position.Y, Game.PlayerPed.Position.Z, Jail.X, Jail.Y, Jail.Z) > 2.01)
                {
                    Function.Call(Hash.SET_ENTITY_COORDS, Game.PlayerPed, Jail.X, Jail.Y, Jail.Z, 1, 0, 0, 1);
                }
            }

            if (Jailed2)
            {
                Vector3 Jail = new Vector3(458.20806884766f, -997.88726806641f, 24.914875030518f);
                if (Function.Call<float>(Hash.GET_DISTANCE_BETWEEN_COORDS, Game.PlayerPed.Position.X, Game.PlayerPed.Position.Y, Game.PlayerPed.Position.Z, Jail.X, Jail.Y, Jail.Z) > 2.01)
                {
                    Function.Call(Hash.SET_ENTITY_COORDS, Game.PlayerPed, Jail.X, Jail.Y, Jail.Z, 1, 0, 0, 1);
                }
            }

            if (Jailed3)
            {
                Vector3 Jail = new Vector3(458.60348510742f, -1001.6125488281f, 24.914875030518f);
                if (Function.Call<float>(Hash.GET_DISTANCE_BETWEEN_COORDS, Game.PlayerPed.Position.X, Game.PlayerPed.Position.Y, Game.PlayerPed.Position.Z, Jail.X, Jail.Y, Jail.Z) > 2.01)
                {
                    Function.Call(Hash.SET_ENTITY_COORDS, Game.PlayerPed, Jail.X, Jail.Y, Jail.Z, 1, 0, 0, 1);
                }
            }

            await Task.FromResult(0);
        }

    }
}

