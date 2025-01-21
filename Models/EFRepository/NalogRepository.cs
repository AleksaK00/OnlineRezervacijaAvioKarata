using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class NalogRepository : INalogRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        //Metoda za dodavanje naloga na osnovu biznis objekta
        public void Add(NalogBO nalogBO)
        {
            Nalog nalog = new Nalog()
            {
                BrLeta = nalogBO.BrLeta,
                DatumPolaska = nalogBO.DatumPolaska,
                IcaoKod = nalogBO.IcaoKod,
                IdKorisnika = nalogBO.IdKorisnika,
                Iznos = nalogBO.Iznos
            };

            rezervacijaEntities.Add(nalog);
            rezervacijaEntities.SaveChanges();
        }

        public void DeleteAllForUser(int id)
        {
            foreach (Nalog nalog in rezervacijaEntities.Nalogs.Where(n => n.IdKorisnika == id).ToList())
            {
                rezervacijaEntities.Nalogs.Remove(nalog);
            }
            rezervacijaEntities.SaveChanges();
        }

        //Metoda hvata nalog za placanje rezervacije
        public NalogBO? GetForReservation(RezervacijaBO rezervacijaBO)
        {
            Nalog nalogIzBaze = rezervacijaEntities.Nalogs.Where(n => n.IdKorisnika == rezervacijaBO.IdKorisnika && n.BrLeta == rezervacijaBO.BrLeta && n.DatumPolaska == rezervacijaBO.DatumPolaska).FirstOrDefault();

            if (nalogIzBaze == null)
            {
                return null;
            }
            else
            {
                NalogBO nalog = new NalogBO()
                {
                    IdNaloga = nalogIzBaze.IdNaloga,
                    BrLeta = nalogIzBaze.BrLeta,
                    DatumPolaska = nalogIzBaze.DatumPolaska,
                    IcaoKod = nalogIzBaze.IcaoKod,
                    IdKorisnika = nalogIzBaze.IdKorisnika,
                    Iznos = nalogIzBaze.Iznos
                };

                return nalog;
            }
        }
    }
}
