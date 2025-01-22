using AspNetCoreGeneratedDocument;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using OnlineRezervacijaAvioKarata.Filters;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;
using System.Globalization;
using System.Text.Json;

namespace OnlineRezervacijaAvioKarata.Controllers
{
    [ServiceFilter(typeof(LoginRequiredFilter))]
    public class RezervacijaController : Controller
    {
        private InstancaLetaRepository _instancaLetaRepository;
        private AvioKompanijaRepository _avioKompanijaRepository;
        private AerodromRepository _aerodromRepository;
        private LetRepository _letRepository;
        private RezervacijaRepository _rezervacijaRepository;
        private AvionRepository _avionRepository;
        private KorisnikRepository _korisnikRepository;
        private NalogRepository _nalogRepository;

        public RezervacijaController()
        {
            _instancaLetaRepository = new InstancaLetaRepository();
            _avioKompanijaRepository = new AvioKompanijaRepository();
            _aerodromRepository = new AerodromRepository();
            _letRepository = new LetRepository();
            _rezervacijaRepository = new RezervacijaRepository();
            _avionRepository = new AvionRepository();
            _korisnikRepository = new KorisnikRepository();
            _nalogRepository = new NalogRepository();
        }

        //Parcijalni pogled za navigaciju procesa rezervacije
        public IActionResult Navigacija()
        {
            return PartialView();
        }

        //Metoda koja ispisuje stranicu za odabir datuma polaska.
        public IActionResult IzaberiLet(string id)
        {
            //Autorizacija
            if (string.IsNullOrEmpty(HttpContext.Request.Cookies["Korisnik"]))
            {
                return RedirectToAction("MessagePage", "Home", new { poruka = "Morati biti prijavljeni da bi ste pristupili strani!", dugmePoruka = "Prijavi se", kontroler = "Login", akcija = "Index" });
            }

            //Pretraga svih buducih odrzavanja odabranog leta
            List<InstancaLetaBO> letovi = _instancaLetaRepository.GetFutureByFlightNumber(id).ToList();
            
            //Cuvanje polaznog i dolaznog aerodroma u sesuju da bi korisnik mogao da se vrati nazad na pretragu bez form resubmission
            LetBO? let = _letRepository.GetByFlightNumber(id);
            AerodromBO? polazniAerodrom = _aerodromRepository.GetByICAOkod(let.PolazniAerodrom);
            AerodromBO? dolazniAerodrom = _aerodromRepository.GetByICAOkod(let.DolazniAerodrom);
            HttpContext.Session.SetString("PolazniAerodrom", polazniAerodrom.Grad);
            HttpContext.Session.SetString("DolazniAerodrom", dolazniAerodrom.Grad);

            //Dodatne informacije za user friendly ispis
            ViewBag.AvioKompanija = _avioKompanijaRepository.GetByICAOkod(let.IcaoKod);
            ViewBag.Let = let.BrLeta;
            CultureInfo culture = new CultureInfo("fr-FR");
            ViewBag.Culture = culture;

            //Informacije za navigaciju
            SideNavData nav = new SideNavData
            {
                BrLeta = let.BrLeta,
                Korak = 1
            };
            ViewBag.SideNavData = nav;

            return View("OdabirLeta", letovi);
        }

        //Metoda koja se poziva ako korisnik zapocinje rezervaciju preko promocije, cuva kolacic za popust pre nastavka rezervacije
        public IActionResult RezervisiSaPopustom(string id)
        {
            Response.Cookies.Append("PopustZa", id, new CookieOptions
            {
                Secure = true,
                HttpOnly = true,
                Expires = DateTime.UtcNow.AddDays(7),
                SameSite = SameSiteMode.Strict
            });

            return RedirectToAction("IzaberiLet", new { id = id});
        }

        //Metoda koja prikazuje stanu za odabir klase po odabiru datuma polaska
        public IActionResult OdaberiKlasu(string brLeta, DateOnly datumPolaska)
        {
            InstancaLetaBO? instancaLeta = _instancaLetaRepository.GetExactInstance(brLeta, datumPolaska);

            //Obavestenje o ne postojanju leta ukoliko ne postoji, zatim formatiranje teksta o benefitima za html
            if (instancaLeta == null)
            {
                return RedirectToAction("MessagePage", "Home", new { poruka = "Nismo pronasli let!", dugmePoruka = "Nazad na početnu", kontroler = "Home", akcija = "Index" });
            }
            instancaLeta.BenefitiEkonomija = instancaLeta.BenefitiEkonomija.Replace("\\r\\n", "<br>");
            instancaLeta.BenefitiPremiumEkonomija = instancaLeta.BenefitiPremiumEkonomija.Replace("\\r\\n", "<br>");
            instancaLeta.BenefitiBiznis = instancaLeta.BenefitiBiznis.Replace("\\r\\n", "<br>");

            //Informacije za navigaciju
            SideNavData nav = new SideNavData
            {
                BrLeta = brLeta,
                DatumPolaska = datumPolaska,
                Korak = 2
            };
            ViewBag.SideNavData = nav;

            return View("OdabirKlase", instancaLeta);
        }

        //Parcijalan pogled za kartice za odabir klase
        public IActionResult KarticeZaKlasu()
        {
            return PartialView("KarticeZaKlasu");
        }

        //Metoda koja vraca informacije za odaber karte i rezervaciju sedista, koristi isti pogled kao odabirKlase
        public IActionResult OdabirKarata(string brLeta, DateOnly datumPolaska, string klasa)
        {
            InstancaLetaBO? instancaLeta = _instancaLetaRepository.GetExactInstance(brLeta, datumPolaska);

            //Obavestenje o ne postojanju leta ukoliko ne postoji, zatim formatiranje teksta o benefitima za html
            if (instancaLeta == null)
            {
                return RedirectToAction("MessagePage", "Home", new { poruka = "Nismo pronasli let!", dugmePoruka = "Nazad na početnu", kontroler = "Home", akcija = "Index" });
            }
            instancaLeta.BenefitiEkonomija = instancaLeta.BenefitiEkonomija.Replace("\\r\\n", "<br>");
            instancaLeta.BenefitiPremiumEkonomija = instancaLeta.BenefitiPremiumEkonomija.Replace("\\r\\n", "<br>");
            instancaLeta.BenefitiBiznis = instancaLeta.BenefitiBiznis.Replace("\\r\\n", "<br>");

            //Informacije za navigaciju
            SideNavData nav = new SideNavData
            {
                BrLeta = brLeta,
                DatumPolaska = datumPolaska,
                Klasa = klasa,
                Korak = 2
            };
            ViewBag.SideNavData = nav;

            //Hvatanje nerezervisanih sedista, vracanje modela aviona i odabrane klase
            ViewBag.Klasa = klasa;
            ViewBag.Sedista = _rezervacijaRepository.GetUnreservedSeatsForFlight(brLeta, datumPolaska);
            AvionBO? avion = _avionRepository.getByRegistration(instancaLeta.Registracija);
            ViewBag.Avion = avion.Model;

            //Stavljanje odabrane cene odabrane klase u viewBag za ispisivanje cene na stranici
            switch(klasa)
            {
                case "Ekonomija": 
                    ViewBag.Cena = instancaLeta.CenaEkonomija;
                    break;
                case "Premium_Ekonomija":
                    ViewBag.Cena = instancaLeta.CenaPremiumEkonomija;
                    break;
                case "Biznis":
                    ViewBag.Cena = instancaLeta.CenaBiznis;
                    break;
            }
            //Dodavanje popusta ukoliko postoji
            if (HttpContext.Request.Cookies["PopustZa"] == instancaLeta.BrLeta)
            {
                ViewBag.Cena = ViewBag.Cena * 0.9;
            }

            //Format za ispisivanje cene
            CultureInfo culture = new CultureInfo("fr-FR");
            ViewBag.Culture = culture;

            return View("OdabirKlase", instancaLeta);
        }

        //Metoda koja uzima podatke za klasu, karte i sedista koji je korisnik upisao, cuva sta je potrebno u sesiju, i daje licen podatke za potvrdi/promenu
        [HttpPost]
        public IActionResult IspisInformacija(string brLeta, DateOnly datumPolaska, string klasa, IFormCollection podaci)
        {
            //Postavljanje informacija u sesiju
            int brKarata = Convert.ToInt32(podaci["brojKarata"]);
            List<string> izabranaSedista = new List<string>();
            for (int i = 1; i <= brKarata; i++)
            {
                if (podaci["sediste" + i] != "")
                {
                    izabranaSedista.Add(podaci["sediste" + i]);
                }          
            }
            HttpContext.Session.SetString("Sedista", JsonSerializer.Serialize(izabranaSedista));
            HttpContext.Session.SetString("BrKarata", brKarata.ToString());
            HttpContext.Session.SetString("CenaKarte", podaci["cenaKarte"]);
            HttpContext.Session.SetString("CenaDoplate", podaci["cenaDoplate"]);

            //Informacije za navigaciju
            SideNavData nav = new SideNavData
            {
                BrLeta = brLeta,
                DatumPolaska = datumPolaska,
                Klasa = klasa,
                Korak = 3
            };
            ViewBag.SideNavData = nav;

            //Uzimanje podataka o ulogovanom korisniku
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);

            return View("IspisInformacija", korisnik);
        }

        //Get verzija metode za navigaciju nazad i ispis gresaka
        [HttpGet]
        public IActionResult IspisInformacija(string brLeta, DateOnly datumPolaska, string klasa, string greska)
        {
            //Informacije za navigaciju
            SideNavData nav = new SideNavData
            {
                BrLeta = brLeta,
                DatumPolaska = datumPolaska,
                Klasa = klasa,
                Korak = 3
            };
            ViewBag.SideNavData = nav;
            ViewData["Greska"] = greska;

            //Uzimanje podataka o ulogovanom korisniku
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);

            return View("IspisInformacija", korisnik);
        }

        //Metoda za ispis stranice o potvrdi rezervacije
        [HttpPost]
        public IActionResult PrikaziPotvrduRezervacije(string brLeta, DateOnly datumPolaska, string klasa, IFormCollection podaci)
        {
            //Validacija da li su polja uneta i vracanje greske ako nisu
            if (String.IsNullOrEmpty(podaci["ime"]) || String.IsNullOrEmpty(podaci["prezime"]) || String.IsNullOrEmpty(podaci["adresa"]))
            {
                return RedirectToAction("IspisInformacija", new { brLeta = brLeta, datumPolaska = datumPolaska, klasa = klasa, greska = "Sva polja su obavezna!" });
            }

            //Skladistenje podataka iz forme za ispis
            ViewBag.Ime = podaci["ime"];
            ViewBag.Prezime = podaci["prezime"];
            ViewBag.Adresa = podaci["adresa"];

            //Preuzimanja nekih podataka o letu koji korisniku sluze dobar pregled podataka o rezervaciji
            InstancaLetaBO instancaLeta = _instancaLetaRepository.GetExactInstance(brLeta, datumPolaska);
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);
            AvioKompanijaBO avioKompanija = _avioKompanijaRepository.GetByICAOkod(instancaLeta.IcaoKod);
            ViewBag.Korisnik = korisnik;
            ViewBag.AvioKompanija = avioKompanija;

            //Lokalizacija valute
            CultureInfo culture = new CultureInfo("fr-FR");
            ViewBag.Culture = culture;

            //Deserializacija liste sedista iz sesije za ispis
            List<string> sedista = new List<string>();
            var sedistaSession = HttpContext.Session.GetString("Sedista");
            if (!string.IsNullOrEmpty(sedistaSession))
            {
                sedista = JsonSerializer.Deserialize<List<string>>(HttpContext.Session.GetString("Sedista"));
            }    
            ViewBag.Sedista = sedista;

            //Informacije za navigaciju
            SideNavData nav = new SideNavData
            {
                BrLeta = brLeta,
                DatumPolaska = datumPolaska,
                Klasa = klasa,
                Korak = 4
            };
            ViewBag.SideNavData = nav;

            return View("Potvrda", instancaLeta);
        }

        //Metoda za kreiranje rezervacije, rezervisanih sedista i naloga
        [HttpPost]
        public IActionResult Rezervisi(string brLeta, DateOnly datumPolaska, string klasa, IFormCollection podaci)
        {
            //Provera da li korisnik vec ima rezervaciju za let
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);
            RezervacijaBO? rezervacijaProvera = _rezervacijaRepository.GetReservation(brLeta, datumPolaska, korisnik.IdKorisnika);
            if (rezervacijaProvera != null)
            {
                return RedirectToAction("MessagePage", "Home", new { poruka = "Već imate rezervaciju za let, maksimalno 1 rezervacija po letu!", dugmePoruka = "Nazad na početnu", kontroler = "Home", akcija = "Index" });
            }

            //Kreiranje Biznis objekta rezervacije i dodavanje u bazu podataka
            string brojKarata = HttpContext.Session.GetString("BrKarata");
            RezervacijaBO rezervacija = new RezervacijaBO()
            {
                DatumPolaska = datumPolaska,
                BrLeta = brLeta,
                IcaoKod = podaci["ICAO_Kod"],
                IdKorisnika = korisnik.IdKorisnika,
                Klasa = klasa,
                Ime = podaci["ime"],
                Prezime = podaci["prezime"],
                Adresa = podaci["adresa"],
                BrKarata = Convert.ToInt32(brojKarata)
            };
            _rezervacijaRepository.Add(rezervacija);

            //Kreiranje biznis objekta za nalog i dodavanje u bazu podataka
            string cenaKarte = HttpContext.Session.GetString("CenaKarte");
            string cenaDoplate = HttpContext.Session.GetString("CenaDoplate");
            double ukupnaCena = Convert.ToInt32(brojKarata) * Convert.ToDouble(cenaKarte) + Convert.ToDouble(cenaDoplate);
            NalogBO nalog = new NalogBO()
            {
                BrLeta = rezervacija.BrLeta,
                DatumPolaska = rezervacija.DatumPolaska,
                IcaoKod = rezervacija.IcaoKod,
                IdKorisnika = rezervacija.IdKorisnika,
                Iznos = ukupnaCena
            };
            _nalogRepository.Add(nalog);

            //Rezervacija sedista ukoliko su izabrana
            List<string> sedista = new List<string>();
            var sedistaSession = HttpContext.Session.GetString("Sedista");
            if (!string.IsNullOrEmpty(sedistaSession))
            {
                sedista = JsonSerializer.Deserialize<List<string>>(HttpContext.Session.GetString("Sedista"));
            }
            InstancaLetaBO instancaLeta = _instancaLetaRepository.GetExactInstance(brLeta, datumPolaska);
            _rezervacijaRepository.ReserveSeats(sedista, instancaLeta.Registracija, rezervacija);

            return RedirectToAction("MessagePage", "Home", new { poruka = "Uspešna rezervacija!", dugmePoruka = "Nazad na početnu", kontroler = "Home", akcija = "Index" });
        }
    }
}
