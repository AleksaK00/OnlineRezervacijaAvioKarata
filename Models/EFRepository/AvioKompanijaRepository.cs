using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class AvioKompanijaRepository : IAvioKompanijaRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        //Metoda koja vraca avio kompaniju na osnovu njenog ICAO koda(primarni kljuc)
        public AvioKompanijaBO GetByICAOkod(string ICAOkod)
        {
            AvioKompanijaBO avioKompanijaBO = new AvioKompanijaBO();

            //Nalazenje aviokompanije u bazi
            AvioKompanija avioKompanija = (from ak in rezervacijaEntities.AvioKompanijas
                                          where ak.IcaoKod == ICAOkod
                                          select ak).Single();

            //prepisivanje u biznis objekat
            avioKompanijaBO.IcaoKod = avioKompanija.IcaoKod;
            avioKompanijaBO.DrzavaPorekla = avioKompanija.DrzavaPorekla;
            avioKompanijaBO.Ime = avioKompanija.Ime;

            return avioKompanijaBO;
        }
    }
}
