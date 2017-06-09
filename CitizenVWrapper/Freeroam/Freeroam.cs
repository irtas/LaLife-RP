using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenVWrapper.Utils;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FreeCitizenVWrapperroam
{
    class Freeroam : BaseScript
    {

        public Freeroam()
        {
            //TriggerServerEvent(Events.FIRSTTIME, Game.Player.ServerId);
            SetPauseMenuTitle();

            EventHandlers[Events.PLAYERSPAWNED] += new Action(PlayerSpawned);
            EventHandlers[Events.VEHPERSIST] += new Action<Vehicle>(vehPersist);

            Tick += OnTick;
        }

        private void PlayerSpawned()
        {

        }

        private void vehPersist(Vehicle veh)
        {
            veh.IsPersistent.Equals(true);
        }

        private void SetPauseMenuTitle()
        {
            Function.Call((Hash)Util.GetHashKey("ADD_TEXT_ENTRY"), "FE_THDR_GTAO", "Propulsé by La Life");
        }

        private async Task OnTick()
        {

            await Task.FromResult(0);
        }
    }
}
