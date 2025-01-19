using Microsoft.EntityFrameworkCore;
using OnlineRezervacijaAvioKarata.Models.Interfaces;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class RezervacijaRepository : IRezervacijaRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        //Metoda koja dodaje rezervaciju u bazu
        public void Add(RezervacijaBO rezervacijaBO)
        {
            Rezervacija rezervacija = new Rezervacija()
            {
                BrLeta = rezervacijaBO.BrLeta,
                IcaoKod = rezervacijaBO.IcaoKod,
                DatumPolaska = rezervacijaBO.DatumPolaska,
                IdKorisnika = rezervacijaBO.IdKorisnika,
                BrKarata = rezervacijaBO.BrKarata,
                Ime = rezervacijaBO.Ime,
                Prezime = rezervacijaBO.Prezime,
                Adresa = rezervacijaBO.Adresa,
                Klasa = rezervacijaBO.Klasa
            };

            rezervacijaEntities.Rezervacijas.Add(rezervacija);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda koja vraca rezervaciju na osnovu njenog primarnog kljuca
        public RezervacijaBO? GetReservation(string brLeta, DateOnly datumPolaska, int IDkorisnika)
        {
            Rezervacija? rezervacijaIzBaze = rezervacijaEntities.Rezervacijas.Where(r => r.BrLeta == brLeta && r.DatumPolaska == datumPolaska && r.IdKorisnika == IDkorisnika).Include(r => r.Sedistes).FirstOrDefault();

            if (rezervacijaIzBaze == null)
            {
                return null;
            }
            else
            {
                RezervacijaBO rezervacija = new RezervacijaBO()
                {
                    BrLeta = rezervacijaIzBaze.BrLeta,
                    DatumPolaska = rezervacijaIzBaze.DatumPolaska,
                    IdKorisnika = rezervacijaIzBaze.IdKorisnika,
                    BrKarata = rezervacijaIzBaze.BrKarata,
                    Klasa = rezervacijaIzBaze.Klasa,
                    Ime = rezervacijaIzBaze.Ime,
                    Prezime = rezervacijaIzBaze.Prezime,
                    Adresa = rezervacijaIzBaze.Adresa,
                    Otkazana = rezervacijaIzBaze.Otkazana,
                    Sedistes = rezervacijaIzBaze.Sedistes
                };

                return rezervacija;
            }
        }

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

        //Metoda koja rezervise sedista no osnovu liste broja sedista i datog aviona, za datu rezervaciju
        public void ReserveSeats(List<string> sedista, string registracija, RezervacijaBO rezervacijaBO)
        {
            //Pronalazenje rezervacije u bazi
            Rezervacija rezervacijaIzBaze = rezervacijaEntities.Rezervacijas.Where(r => r.BrLeta == rezervacijaBO.BrLeta && r.DatumPolaska == rezervacijaBO.DatumPolaska && r.IdKorisnika == rezervacijaBO.IdKorisnika).Include(r => r.Sedistes).FirstOrDefault();

            //Dodavanje sedista u tabelu relacije vise na vise
            foreach (string brojSedista in sedista)
            {
                Sediste sediste = rezervacijaEntities.Sedistes.Where(s => s.BrSedista == brojSedista && s.Registracija == registracija).FirstOrDefault();
                rezervacijaIzBaze.Sedistes.Add(sediste);
            }

            rezervacijaEntities.Update(rezervacijaIzBaze);
            rezervacijaEntities.SaveChanges();
        }
    }
}
