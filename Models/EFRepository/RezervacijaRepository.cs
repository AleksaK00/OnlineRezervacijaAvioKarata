using Microsoft.EntityFrameworkCore;
using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class RezervacijaRepository : IRezervacijaRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        //Hvata sva nerezervisana sedista na letu
        public IEnumerable<SedisteBO> GetUnreservedSeatsForFlight(string brLeta, DateOnly datumPolaska)
        {
            List<SedisteBO> nerezervisanaSedista = new List<SedisteBO>();

            //Hvatanje registracije aviona koji izvodi let
            InstancaLetaRepository _instancaLetaRepository = new InstancaLetaRepository();
            InstancaLetaBO instancaLeta = _instancaLetaRepository.GetExactInstance(brLeta, datumPolaska);
            //Vracanje prazne liste ukoliko let ne postoji
            if (instancaLeta == null)
            {
                return nerezervisanaSedista;
            }

            string registracija = instancaLeta.Registracija;

            //Prolazenje kroz sve postojece rezervacije za let i pronalazenje vec rezervisanih sedista
            List<Rezervacija> rezervacijeIzBaze = rezervacijaEntities.Rezervacijas.Where(r => r.BrLeta == brLeta && r.DatumPolaska == datumPolaska).Include(r => r.Sedistes).ToList();
            List<string> rezervisanaSedista = new List<string>();
            foreach (Rezervacija rez in rezervacijeIzBaze)
            {
                foreach (Sediste rezervisanoSediste in rez.Sedistes.ToList())
                {
                    rezervisanaSedista.Add(rezervisanoSediste.BrSedista);
                }
            }

            //Pronalazenje svih nerezervisanih sedista
            List<Sediste> nerezervisanaSedistaIzBaze = rezervacijaEntities.Sedistes.Where(s => s.Registracija == registracija && !rezervisanaSedista.Contains(s.BrSedista)).ToList();
            //Dodavanje u listu biznis objekata
            foreach (Sediste nerezervisanoSediste in nerezervisanaSedistaIzBaze)
            {
                SedisteBO novoSediste = new SedisteBO();

                novoSediste.BrSedista = nerezervisanoSediste.BrSedista;
                novoSediste.Registracija = nerezervisanoSediste.Registracija;
                novoSediste.Klasa = nerezervisanoSediste.Klasa;
                novoSediste.Doplata = nerezervisanoSediste.Doplata;

                nerezervisanaSedista.Add(novoSediste);
            }

            return nerezervisanaSedista;
        }
    }
}
