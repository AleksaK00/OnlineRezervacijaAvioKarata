using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class InstancaLetaRepository : IInstancaLetaRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

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
