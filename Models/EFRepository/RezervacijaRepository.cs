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

        //Metoda za otkazivanje rezervacije. Takodje brise sva rezervisana sedista vezana za rezervaciju
        public void CancelReservation(RezervacijaBO rezervacijaBO)
        {
            Rezervacija rezervacijaIzBaze = rezervacijaEntities.Rezervacijas.Where(r => r.IdKorisnika == rezervacijaBO.IdKorisnika && r.BrLeta == rezervacijaBO.BrLeta && r.DatumPolaska == rezervacijaBO.DatumPolaska).Include(r => r.Sedistes).FirstOrDefault();

            rezervacijaIzBaze.Otkazana = 1;
            rezervacijaIzBaze.Sedistes.Clear();

            rezervacijaEntities.Rezervacijas.Update(rezervacijaIzBaze);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda za brisanje rezervacija korisnika, prvo brise relevantne naloge.
        public void DeleteAllForUser(int id)
        {
            //Brisanje naloga
            NalogRepository _nalogRepository = new NalogRepository();
            _nalogRepository.DeleteAllForUser(id);

            //Brisanje rezervacija
            foreach (Rezervacija rezervacija in rezervacijaEntities.Rezervacijas.Where(r => r.IdKorisnika == id).Include(r => r.Sedistes).ToList())
            {
                //Prvo brisanje rezervisanih sedista
                rezervacija.Sedistes.Clear();
                rezervacijaEntities.Rezervacijas.Update(rezervacija);
                rezervacijaEntities.SaveChanges();

                rezervacijaEntities.Rezervacijas.Remove(rezervacija);
                rezervacijaEntities.SaveChanges();
            }
        }

        //Metoda koja vraca rezervacije zajedno sa korisnickim imenom
        public IEnumerable<AdminPogledRezervacija> GetAllForAdmin()
        {
            List<AdminPogledRezervacija> rezervacije = new List<AdminPogledRezervacija>();

            foreach(Rezervacija rezervacijeIzBaze in rezervacijaEntities.Rezervacijas.ToList())
            {
                //Stavljanje svih rezervacija u biznis objekat
                RezervacijaBO rezervacijaBO = new RezervacijaBO()
                {
                    BrLeta = rezervacijeIzBaze.BrLeta,
                    DatumPolaska = rezervacijeIzBaze.DatumPolaska,
                    IcaoKod = rezervacijeIzBaze.IcaoKod,
                    IdKorisnika = rezervacijeIzBaze.IdKorisnika,
                    BrKarata = rezervacijeIzBaze.BrKarata,
                    Klasa = rezervacijeIzBaze.Klasa,
                    Otkazana = rezervacijeIzBaze.Otkazana,
                    Ime = rezervacijeIzBaze.Ime,
                    Prezime = rezervacijeIzBaze.Prezime,
                    Adresa = rezervacijeIzBaze.Adresa,
                };

                //Racunanje dana do izvrsenja rezervacije i trazenje korisnickog imena
                TimeSpan danaDO = rezervacijaBO.DatumPolaska.ToDateTime(TimeOnly.MinValue) - DateTime.Now;
                Korisnik korisnik = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == rezervacijaBO.IdKorisnika).FirstOrDefault();

                //Konstrukcija admin pogled objekta
                AdminPogledRezervacija rezervacija = new AdminPogledRezervacija()
                {
                    Rezervacija = rezervacijaBO,
                    DanaDO = danaDO,
                    KorisnickoIme = korisnik.KorisnickoIme
                };

                rezervacije.Add(rezervacija);
            }

            return rezervacije;
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
                    IcaoKod = rezervacijaIzBaze.IcaoKod,
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

        //Metoda koja vraca sve rezervacije korisnika
        public IEnumerable<RezervacijaBO> getReservationsByUserID(int IDkorisnika)
        {
            List<RezervacijaBO> rezervacije = new List<RezervacijaBO>();

            foreach (Rezervacija rezervacijaIzBaze in rezervacijaEntities.Rezervacijas.Where(r => r.IdKorisnika == IDkorisnika).Include(r => r.Sedistes).ToList())
            {
                RezervacijaBO novaRezervacija = new RezervacijaBO()
                {
                    IdKorisnika = rezervacijaIzBaze.IdKorisnika,
                    BrLeta = rezervacijaIzBaze.BrLeta,
                    DatumPolaska = rezervacijaIzBaze.DatumPolaska,
                    IcaoKod = rezervacijaIzBaze.IcaoKod,
                    Klasa = rezervacijaIzBaze.Klasa,
                    BrKarata = rezervacijaIzBaze.BrKarata,
                    Ime = rezervacijaIzBaze.Ime,
                    Prezime = rezervacijaIzBaze.Prezime,
                    Adresa = rezervacijaIzBaze.Adresa,
                    Otkazana = rezervacijaIzBaze.Otkazana,
                    Sedistes = rezervacijaIzBaze.Sedistes
                };

                rezervacije.Add(novaRezervacija);
            }

            return rezervacije;
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
