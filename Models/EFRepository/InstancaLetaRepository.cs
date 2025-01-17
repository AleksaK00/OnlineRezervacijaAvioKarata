using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class InstancaLetaRepository : IInstancaLetaRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        //Metoda koja vraca instancu leta na osnovu br leta i datuma polaska
        public InstancaLetaBO? GetExactInstance(string brLeta, DateOnly datumPolaska)
        {
            InstancaLetum? letIzBaze = rezervacijaEntities.InstancaLeta.Where(il => il.BrLeta == brLeta && il.DatumPolaska == datumPolaska).FirstOrDefault();

            //Vracanje instance leta u slucaju da postoji
            if (letIzBaze != null)
            {
                InstancaLetaBO instancaLeta = new InstancaLetaBO();

                instancaLeta.BrLeta = brLeta;
                instancaLeta.DatumPolaska = letIzBaze.DatumPolaska;
                instancaLeta.IcaoKod = letIzBaze.IcaoKod;
                instancaLeta.Registracija = letIzBaze.Registracija;
                instancaLeta.CenaEkonomija = letIzBaze.CenaEkonomija;
                instancaLeta.CenaPremiumEkonomija = letIzBaze.CenaPremiumEkonomija;
                instancaLeta.CenaBiznis = letIzBaze.CenaBiznis;
                instancaLeta.BenefitiEkonomija = letIzBaze.BenefitiEkonomija;
                instancaLeta.BenefitiPremiumEkonomija = letIzBaze.BenefitiPremiumEkonomija;
                instancaLeta.BenefitiBiznis = letIzBaze.BenefitiBiznis;

                return instancaLeta;
            }
            else
            {
                return null;
            }
        }

        //Metoda koja vraca sve instance nekog leta
        public IEnumerable<InstancaLetaBO> GetFutureByFlightNumber(string brLeta)
        {
            List<InstancaLetaBO> letovi = new List<InstancaLetaBO>();

            //Prolazenje kroz sva odrzavanja leta koje tek treba de se odrze i dodavanje u biznis objekat
            Let? let = rezervacijaEntities.Lets.Where(l => l.BrLeta == brLeta).FirstOrDefault();

            List<InstancaLetum> instanceLeta = rezervacijaEntities.InstancaLeta.Where(il => il.BrLeta == brLeta).ToList(); 

            foreach (InstancaLetum instancaLeta in instanceLeta)
            {
                if (instancaLeta.DatumPolaska > DateOnly.FromDateTime(DateTime.Now))
                {
                    InstancaLetaBO trenutniLet = new InstancaLetaBO();

                    trenutniLet.BrLeta = brLeta;
                    trenutniLet.DatumPolaska = instancaLeta.DatumPolaska;
                    trenutniLet.IcaoKod = instancaLeta.IcaoKod;
                    trenutniLet.Registracija = instancaLeta.Registracija;
                    trenutniLet.CenaEkonomija = instancaLeta.CenaEkonomija;
                    trenutniLet.CenaPremiumEkonomija = instancaLeta.CenaPremiumEkonomija;
                    trenutniLet.CenaBiznis = instancaLeta.CenaBiznis;
                    trenutniLet.BenefitiEkonomija = instancaLeta.BenefitiEkonomija;
                    trenutniLet.BenefitiPremiumEkonomija = instancaLeta.BenefitiPremiumEkonomija;
                    trenutniLet.BenefitiBiznis = instancaLeta.BenefitiBiznis;

                    letovi.Add(trenutniLet);
                }
            }

            return letovi;
        }

        public float? minimalnaCena(string brLeta)
        {
            List<InstancaLetum> instanceLeta = (from il in rezervacijaEntities.InstancaLeta
                                               where il.BrLeta == brLeta
                                               select il).ToList();

            float? cenaOd = (float?)(from il in instanceLeta
                           select il.CenaEkonomija).Min();

            return cenaOd;
        }
    }
}
