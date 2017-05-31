namespace CitizenVWrapper.Utils
{
    static class Events
    {
        public const string HASHIT = "hashit:draziak";



        public const string VERIFP = "menupolice:verifp";
        public const string FVERIFP = "menupolice:f_verifp";
        public const string SEARCHVEH = "menupolice:searchveh";
        public const string FSEARCHVEH = "menupolice:f_searchveh";
        public const string SEARCHCIV = "menupolice:searchciv";
        public const string FSEARCHCIV = "menupolice:f_searchciv";
        public const string GIVECON = "menupolice:givecon";
        public const string CUFF = "menupolice:wcuff";
        public const string FCUFF = "menupolice:wf_cuff";
        public const string ESCORTCUFF = "menupolice:wescortcuff";
        public const string FESCORTCUFF = "menupolice:wf_escortcuff";
        public const string UNCUFF = "menupolice:wuncuff";
        public const string FUNCUFF = "menupolice:wf_uncuff";
        public const string CIVTOCAR = "menupolice:civtocar";
        public const string FCIVTOCAR = "menupolice:wf_civtocar";
        public const string CIVUNCAR = "menupolice:civuncar";
        public const string FCIVUNCAR = "menupolice:f_civuncar";
        public const string UNLOCK = "menupolice:unlock";
        public const string SEIZECASH = "menupolice:seizecash";
        public const string SEIZEDRUG = "menupolice:seizedrug";

        public const string FIRSTTIME = "freeroam:newplayer";
        public const string PLAYER_JOINED = "freeroam:playerjoined";
        public const string PLAYER_LEFT = "freeroam:playerleft";

        public const string PLAYERSPAWNED = "playerSpawned";

        public const string MONEY_ADD = "freeroam:addmoney";
        public const string MONEY_REMOVE = "freeroam:removemoney";

        public const string XP_ADD = "freeroam:addxp";

        public const string DISPLAY_DRAW = "freeroam:drawdisplay";

        public const string PLAYERSKIN_CHANGE = "freeroam:changeskin";

        public const string CHALLENGE_START = "freeroam:startchallenge";
        public const string CHALLENGE_STOP = "freeroam:stopchallenge";

        public const string MISSION_START = "freeroam:startmission";
        public const string MISSION_STOP = "freeroam:stopmission";
        public const string MISSION_RUNNING = "freeroam:missionrunning";
    }
}
