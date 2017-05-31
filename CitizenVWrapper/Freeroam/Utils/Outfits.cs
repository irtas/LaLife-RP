using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenVWrapper.Utils;
using System;
using System.Threading.Tasks;

namespace CitizenVWrapper.Utils
{

    class Outfits : BaseScript
    {

        public string m_name;
        public int m_id;
        public int[] zero;
        public int[] one;
        public int[] two;
        public int[] three;
        public int[] four;
        public int[] five;
        public int[] six;
        public int[] seven;
        public int[] eight;
        public int[] nine;
        public int[] ten;
        public int[] eleven;

        public int[] pzero;
        public int[] pone;
        public int[] ptwo;
        public int[] pthree;
        public int[] pfour;
        public int[] pfive;
        public int[] psix;
        public int[] pseven;
        public int[] peight;
        public int[] pnine;

        public Outfits()
        {
            m_name = "Default";
            m_id = 100;
            zero = new int[] { -1, -1 };
            one = new int[] { -1, -1 };
            two = new int[] { -1, -1 };
            three = new int[] { -1, -1 };
            four = new int[] { -1, -1 };
            five = new int[] { -1, -1 };
            six = new int[] { -1, -1 };
            seven = new int[] { -1, -1 };
            eight = new int[] { -1, -1 };
            nine = new int[] { -1, -1 };
            ten = new int[] { -1, -1 };
            eleven = new int[] { -1, -1 };
            pzero = new int[] { -1, -1 };
            pone = new int[] { -1, -1 };
            ptwo = new int[] { -1, -1 };
            pthree = new int[] { -1, -1 };
            pfour = new int[] { -1, -1 };
            pfive = new int[] { -1, -1 };
            psix = new int[] { -1, -1 };
            pseven = new int[] { -1, -1 };
            peight = new int[] { -1, -1 };
            pnine = new int[] { -1, -1 };
        }

        public Outfits(string p_name, int p_id, int[] p_pzero, int[] p_pone, int[] p_ptwo, int[] p_pthree, int[] p_pfour, int[] p_pfive, int[] p_psix, int[] p_pseven, int[] p_peight, int[] p_pnine, int[] p_zero, int[] p_one, int[] p_two, int[] p_three, int[] p_four, int[] p_five, int[] p_six, int[] p_seven, int[] p_eight, int[] p_nine, int[] p_ten, int[] p_eleven)
        {
            m_name = p_name;
            m_id = p_id;
            zero = p_zero;
            one = p_one;
            two = p_two;
            three = p_three;
            four = p_four;
            five = p_five;
            six = p_six;
            seven = p_seven;
            eight = p_eight;
            nine = p_nine;
            ten = p_ten;
            eleven = p_eleven;
            pzero = p_pzero;
            pone = p_pone;
            ptwo = p_ptwo;
            pthree = p_pthree;
            pfour = p_pfour;
            pfive = p_pfive;
            psix = p_psix;
            pseven = p_pseven;
            peight = p_peight;
            pnine = p_pnine;
        }

    }

}
