using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenVWrapper.Utils;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CitizenVWrapper.Itinerance
{
    class Itinerance : BaseScript
    {

        public Itinerance()
        {
            //TriggerServerEvent(Events.FIRSTTIME, Game.Player.ServerId);
            SetPauseMenuTitle();

            EventHandlers[Events.PLAYERSPAWNED] += new Action(PlayerSpawned);
            EventHandlers[Events.VEHPERSIST] += new Action<Vehicle>(vehPersist);

            EventHandlers[Events.ONCLIENTMAPSTART] += new Action(OnClientMapStart);
            EventHandlers[Events.DISPLAYTEXT] += new Action<string, int>(DisplayText);
            EventHandlers[Events.NOTIFY] += new Action<string, int, string, bool, string>(Notify);
            EventHandlers[Events.NOTIF] += new Action<string>(Notif);
            EventHandlers[Events.HELP] += new Action<string>(Help);


            Tick += OnTick;
        }

        private void PlayerSpawned()
        {

        }

        //Des petits tests
        private void vehPersist(Vehicle veh)
        {
            veh.IsPersistent.Equals(true);
        }

        private void SetPauseMenuTitle()
        {
            Function.Call((Hash)Util.GetHashKey("ADD_TEXT_ENTRY"), "FE_THDR_GTAO", "Propulsé by La Life");
        }

        private void OnClientMapStart()
        {
            Exports["spawnmanager"].setAutoSpawn(true);
            Exports["spawnmanager"].forceRespawn();
        }

        private void DisplayText(string text, int time)
        {
            CitizenFX.Core.UI.Screen.ShowSubtitle(text, time);
        }

        private void Notify(string icon, int type, string sender, bool title, string text)
        {
            Function.Call(Hash._SET_NOTIFICATION_TEXT_ENTRY, "STRING");
            Function.Call(Hash.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME, text);
            Function.Call(Hash._SET_NOTIFICATION_MESSAGE, icon, icon, true, type, sender, title, text);
            Function.Call(Hash._DRAW_NOTIFICATION, false, true);
        }

        private void Help(string text)
        {
            CitizenFX.Core.UI.Screen.DisplayHelpTextThisFrame(text);
        }

        private void Notif(string text)
        {
            CitizenFX.Core.UI.Screen.ShowNotification(text);
        }

        private async Task OnTick()
        {

            await Task.FromResult(0);
        }
    }
}
