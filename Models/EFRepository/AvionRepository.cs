using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class AvionRepository : IAvionRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        //Metoda koja vraca avion po registraciji
        public AvionBO? getByRegistration(string registracija)
        {
            Avion? avionIzBaze = rezervacijaEntities.Avions.Where(a => a.Registracija == registracija).FirstOrDefault();

            //Vracanje null ako ne postoji, biznis objekta ako postoji
            if (avionIzBaze == null)
            {
                return null;
            }
            else
            {
                AvionBO avion = new AvionBO();

                avion.Registracija = avionIzBaze.Registracija;
                avion.Proizvodjac = avionIzBaze.Proizvodjac;
                avion.Model = avionIzBaze.Model;
                avion.IcaoKod = avionIzBaze?.IcaoKod;

                return avion;
            }
        }
    }
}
