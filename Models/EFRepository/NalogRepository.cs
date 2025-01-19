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
    }
}
