using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class PromocijaRepository : IPromocijaRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        public void Add(PromocijaBO promocija)
        {
            throw new NotImplementedException();
        }

        public void Delete(PromocijaBO promocija)
        {
            throw new NotImplementedException();
        }

        //Metoda hvata sve promocije koje su trenutno podesene kao aktivne
        public IEnumerable<PromocijaBO> GetActive()
        {
            List<PromocijaBO> aktivnePromocije = new List<PromocijaBO>();

            foreach (Promocija promocija in rezervacijaEntities.Promocijas.ToList())
            {
                if (promocija.AktivanSlot > 0)
                {
                    PromocijaBO aktivnaPromocija = new PromocijaBO();

                    aktivnaPromocija.Id = promocija.Id;
                    aktivnaPromocija.Destinacija = promocija.Destinacija;
                    aktivnaPromocija.Tekst = promocija.Tekst;
                    aktivnaPromocija.AktivanSlot = promocija.AktivanSlot;

                    aktivnePromocije.Add(aktivnaPromocija);
                }
            }

            aktivnePromocije = aktivnePromocije.OrderBy(promo => promo.AktivanSlot).ToList();
            return aktivnePromocije;
        }

        public IEnumerable<PromocijaBO> GetAll()
        {
            throw new NotImplementedException();
        }
    }
}
