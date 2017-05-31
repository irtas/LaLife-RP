using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;


namespace CitizenVWrapper
{
    class Cellphone_controller : BaseScript
    {
        public static Prop cellphone;
        public bool cellInHand = false;
        public bool noCellInHand = false;

        public Cellphone_controller()
        {
            //If your fishing rod doesn't appear. Type /clearhands. SHOULD FIX.
            EventHandlers["wrapper:cellphoneAnimOn"] += new Action(cellOn);
            EventHandlers["wrapper:cellphoneAnimOff"] += new Action(cellOff);

            Tick += OnTick;
        }

        //Wonderful function to clear the hands.
        void clearHands()
        {
            cellphone.Detach();
            cellphone.Delete();
        }

        void cellOn()
        {
            cellInHand = true;
        }

        void cellOff()
        {
            noCellInHand = true;
        }

        public async Task OnTick()
        {
            if (cellInHand)
            {
                cellphone = await World.CreateProp(new Model("prop_npc_phone"), Vector3.Zero, false, false);
                cellphone.AttachTo(Game.PlayerPed.Bones[73], new Vector3(0.03f, -0.04f, 0.01f), new Vector3(90f, 80f, 60f));
                cellInHand = false;
            }
            if(noCellInHand)
            {
                clearHands();
                noCellInHand = false;
            }

            await Task.FromResult(0);
        }
    }
}

