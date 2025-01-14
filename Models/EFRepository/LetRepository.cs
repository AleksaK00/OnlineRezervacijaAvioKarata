using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class LetRepository : ILetRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        //Metoda koja pronalazi sve letove izmedju dva aerodroma
        public IEnumerable<LetBO> GetByAirports(string polazniAerodrom, string dolazniAerodrom)
        {
            List<LetBO> letoviBO = new List<LetBO>();

            //Pronalazenje svih letova izmedju dva aerodroma iz baze
            List<Let> letovi = (from l in rezervacijaEntities.Lets
                               where l.PolazniAerodrom == polazniAerodrom && l.DolazniAerodrom == dolazniAerodrom
                               select l).ToList();

            //Dodavanje letova u listu
            foreach (Let letIzBaze in letovi)
            {
                LetBO noviLet = new LetBO();

                noviLet.BrLeta = letIzBaze.BrLeta;
                noviLet.PolazniAerodrom = letIzBaze.PolazniAerodrom;
                noviLet.DolazniAerodrom = letIzBaze.DolazniAerodrom;
                noviLet.IcaoKod = letIzBaze.IcaoKod;
                noviLet.VremePolaska = letIzBaze.VremePolaska;

                letoviBO.Add(noviLet);
            }

            return letoviBO;
        }
    }
}
