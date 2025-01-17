using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class AerodromRepository : IAerodromRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        //Metoda koja pronalazi sve aerodrome u gradu
        public IEnumerable<AerodromBO> GetByCity(string grad)
        {
            List<AerodromBO> aerodromiBO = new List<AerodromBO>();

            //Trazenje svih aerodroma u gradu iz baze
            List<Aerodrom> aerodromi = (from aero in rezervacijaEntities.Aerodroms
                                         where aero.Grad == grad
                                         select aero).ToList();

            //Popunjavanje liste biznis objekata
            foreach (Aerodrom aerodrom in aerodromi)
            {
                AerodromBO noviAeordrom = new AerodromBO();
                noviAeordrom.IcaoKodAerodroma = aerodrom.IcaoKodAerodroma;
                noviAeordrom.Grad = aerodrom.Grad;
                noviAeordrom.Ime = aerodrom.Ime;
                noviAeordrom.Drzava = aerodrom.Drzava;

                aerodromiBO.Add(noviAeordrom);
            }

            return aerodromiBO;
        }

        public AerodromBO? GetByICAOkod(string ICAOkod)
        {
            Aerodrom? aerodromIzBaze = rezervacijaEntities.Aerodroms.Where(a => a.IcaoKodAerodroma == ICAOkod).FirstOrDefault();

            if (aerodromIzBaze == null)
            {
                return null;
            }
            else
            {
                AerodromBO noviAeordrom = new AerodromBO();
                noviAeordrom.IcaoKodAerodroma = aerodromIzBaze.IcaoKodAerodroma;
                noviAeordrom.Grad = aerodromIzBaze.Grad;
                noviAeordrom.Ime = aerodromIzBaze.Ime;
                noviAeordrom.Drzava = aerodromIzBaze.Drzava;

                return noviAeordrom;
            }
        }
    }
}
