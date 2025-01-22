using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class PromocijaRepository : IPromocijaRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        public void Add(PromocijaBO promocija)
        {
            Promocija novaPromocija = new Promocija()
            {
                Destinacija = promocija.Destinacija,
                Tekst = promocija.Tekst,
                AktivanSlot = null
            };

            rezervacijaEntities.Add(novaPromocija);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda koja menja aktivne promocije sa novim
        public void ChangeActivePromos(int promo1, int promo2, int promo3)
        {
            //Prvo se deaktiviraju trenutno aktivne promocije
            foreach (Promocija promocija in rezervacijaEntities.Promocijas.ToList())
            {
                if (promocija.AktivanSlot > 0)
                {
                    promocija.AktivanSlot = null;
                    rezervacijaEntities.Promocijas.Update(promocija);
                }
            }
            rezervacijaEntities.SaveChanges();

            //Zatim postavljaju nove
            Promocija promocija1 = rezervacijaEntities.Promocijas.Where(p => p.Id == promo1).FirstOrDefault();
            promocija1.AktivanSlot = 1;
            Promocija promocija2 = rezervacijaEntities.Promocijas.Where(p => p.Id == promo2).FirstOrDefault();
            promocija2.AktivanSlot = 2;
            Promocija promocija3 = rezervacijaEntities.Promocijas.Where(p => p.Id == promo3).FirstOrDefault();
            promocija3.AktivanSlot = 3;

            rezervacijaEntities.Promocijas.UpdateRange(promocija1, promocija2, promocija3);
            rezervacijaEntities.SaveChanges();
        }

        //Proverava da li vec postoji promocija za destinaciju
        public bool CheckIfExists(string destinacija)
        {
            Promocija? promocijaProvera = rezervacijaEntities.Promocijas.Where(p => p.Destinacija == destinacija).FirstOrDefault();

            if (promocijaProvera == null)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        //Metoda za brisanje promocije. (Sliku obrisati odvojeno u kontroleru)
        public void Delete(PromocijaBO promocijaBO)
        {
            Promocija? promocija = rezervacijaEntities.Promocijas.Where(p => p.Id == promocijaBO.Id).FirstOrDefault();

            //Brisanje promocije ako postoji
            if (promocija != null)
            {
                rezervacijaEntities.Promocijas.Remove(promocija);
                rezervacijaEntities.SaveChanges();
            }
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

        //Metoda koja hvata sve promocije iz baze
        public IEnumerable<PromocijaBO> GetAll()
        {
            List<PromocijaBO> promocije = new List<PromocijaBO>();

            foreach (Promocija promocija in rezervacijaEntities.Promocijas.ToList())
            {
                PromocijaBO novaPromocija = new PromocijaBO();

                novaPromocija.Id = promocija.Id;
                novaPromocija.Destinacija = promocija.Destinacija;
                novaPromocija.Tekst = promocija.Tekst;
                novaPromocija.AktivanSlot = promocija.AktivanSlot;

                promocije.Add(novaPromocija);
            }

            return promocije;
        }

        public PromocijaBO? GetById(int id)
        {
            Promocija? promocijaIzBaze = rezervacijaEntities.Promocijas.Where(p => p.Id == id).FirstOrDefault();

            if (promocijaIzBaze == null)
            {
                return null;
            }
            else
            {
                PromocijaBO promocija = new PromocijaBO()
                {
                    Id = promocijaIzBaze.Id,
                    Destinacija = promocijaIzBaze.Destinacija,
                    Tekst = promocijaIzBaze.Tekst,
                    AktivanSlot = promocijaIzBaze.AktivanSlot
                };

                return promocija;
            }
        }
    }
}
