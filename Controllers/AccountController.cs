using Microsoft.AspNetCore.Mvc;
using OnlineRezervacijaAvioKarata.Filters;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;
using System.Globalization;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace OnlineRezervacijaAvioKarata.Controllers
{
    [ServiceFilter(typeof(LoginRequiredFilter))]
    public class AccountController : Controller
    {
        private KorisnikRepository _korisnikRepository;
        private RezervacijaRepository _rezervacijaRepository;
        private LetRepository _letRepository;
        private AvioKompanijaRepository _avioKompanijaRepository;
        private AerodromRepository _aerodromRepository;
        private NalogRepository _nalogRepository;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public AccountController(IWebHostEnvironment webHost)
        {
            _korisnikRepository = new KorisnikRepository();
            _rezervacijaRepository = new RezervacijaRepository();
            _letRepository = new LetRepository();
            _avioKompanijaRepository = new AvioKompanijaRepository();
            _aerodromRepository = new AerodromRepository();
            _nalogRepository = new NalogRepository();
            _webHostEnvironment = webHost;
        }

        //Pokazuje pocetnu stranicu za upravljanje naloga, sa pregledom informacija
        public IActionResult Index()
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);
            List<RezervacijaBO> rezervacije = _rezervacijaRepository.getReservationsByUserID(korisnik.IdKorisnika).ToList();
            ViewBag.BrojRezervacija = rezervacije.Count;

            return View("Index", korisnik);
        }

        //Parcijalni pogled za navigaciju stranica upravljanja nalogom
        public IActionResult NavigacijaNalog()
        {
            return PartialView();
        }

        //Metoda za brisanje naloga, prvo brise sva rezervisana sedista i otkazuje rezervaciju
        public IActionResult ObrisiNalog()
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);

            //Hvatanje svih rezervacija i njihovo otkazivanje
            List<RezervacijaBO> rezervacije = _rezervacijaRepository.getReservationsByUserID(korisnik.IdKorisnika).ToList();
            foreach (RezervacijaBO rezervacija in rezervacije)
            {
                _rezervacijaRepository.CancelReservation(rezervacija);
            }

            //Brisanje naloga, korisnik moze samo da ga gasi, ne i permanento brise
            _korisnikRepository.ShutDownAcount(korisnik);
            Response.Cookies.Delete("Korisnik");

            return RedirectToAction("MessagePage", "Home", new { poruka = "Nalog uspešno ugašen!", dugmePoruka = "Nazad na početnu", kontroler = "Home", akcija = "Index" });
        }

        //Metoda koja vraca pogled sa korisnickim rezervacijama, spakovane u klasu UserFriendlyRezervacija sa dodatnim informacijama bitnim korisniku
        public IActionResult PregledRezervacija()
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);
            List<UserFriendlyRezervacija> rezervacije = new List<UserFriendlyRezervacija>();

            //Pakovanje svih rezervacija u listu sa dodatnim informacijama potrebnim korisniku
            List<RezervacijaBO> rezervacijeBO = _rezervacijaRepository.getReservationsByUserID(korisnik.IdKorisnika).ToList();
            foreach (RezervacijaBO rezervacijaBO in rezervacijeBO)
            {
                LetBO letBO = _letRepository.GetByFlightNumber(rezervacijaBO.BrLeta);
                AvioKompanijaBO avioKompanijaBO = _avioKompanijaRepository.GetByICAOkod(rezervacijaBO.IcaoKod);
                AerodromBO polazniAerodromBO = _aerodromRepository.GetByICAOkod(letBO.PolazniAerodrom);
                AerodromBO dolazniAerodromBO = _aerodromRepository.GetByICAOkod(letBO.DolazniAerodrom);
                NalogBO nalogBO = _nalogRepository.GetForReservation(rezervacijaBO);

                UserFriendlyRezervacija novaRezervacija = new UserFriendlyRezervacija()
                {
                    Rezervacija = rezervacijaBO,
                    IDkorisnika = korisnik.IdKorisnika,
                    VremePolaska = letBO.VremePolaska,
                    PolazniAerodrom = polazniAerodromBO.Ime,
                    DolazniAerodrom = dolazniAerodromBO.Ime,
                    ImeKompanije = avioKompanijaBO.Ime,
                    Iznos = nalogBO.Iznos,
                    DanaDO = rezervacijaBO.DatumPolaska.ToDateTime(TimeOnly.MinValue) - DateTime.Now
                };

                rezervacije.Add(novaRezervacija);
            }

            //Postavljanje kulture za ispis valute
            CultureInfo culture = new CultureInfo("fr-FR");
            ViewBag.Culture = culture;

            return View("Rezervacije", rezervacije);
        }

        //Metoda za otkazivanje rezervacije
        public IActionResult OtkaziRezervaciju(string brLeta, DateOnly datumPolaska)
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);
            RezervacijaBO rezervacija = _rezervacijaRepository.GetReservation(brLeta, datumPolaska, korisnik.IdKorisnika);

            //Pozivanje metode koja otkazuje rezervaciju i brise rezervacije sedista iz baze
            _rezervacijaRepository.CancelReservation(rezervacija);

            return RedirectToAction("MessagePage", "Home", new { poruka = "Rezervacija uspešno otkazana!", dugmePoruka = "Nazad na rezervacije", kontroler = "Account", akcija = "PregledRezervacija" });
        }

        //Metoda vraca stranicu za promenu informacija naloga
        public IActionResult PromenaInformacija(string greska)
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);
            ViewData["Greska"] = greska;

            return View("PromenaInformacija", korisnik);
        }

        //Metoda za promenu licnih informacija korisnika(ime, prezime, adresa)
        public IActionResult PromeniLicneInformacije(string name, string surname, string address)
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);

            //Validacija unosa
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(surname) || string.IsNullOrEmpty(address))
            {
                return RedirectToAction("PromenaInformacija", new { greska = "Sva polja su obavezna!" });
            }

            //Promena informacija
            _korisnikRepository.EditPersonalInfo(korisnik, name, surname, address);
            return RedirectToAction("MessagePage", "Home", new { poruka = "Uspešna promena ličnih informacija!", dugmePoruka = "Nazad na dashboard", kontroler = "Account", akcija = "Index" });
        }

        //Metoda za promenu osnovnih informacija o nalogu korisnika(korisnicko ime, email)
        public IActionResult PromeniOsnovneInformacije(string username, string email)
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);

            //Validacija unosa
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email))
            {
                return RedirectToAction("PromenaInformacija", new { greska = "Sva polja su obavezna!" });
            }
            if (Regex.IsMatch(username, "\\s"))
            {
                return RedirectToAction("PromenaInformacija", new { greska = "Korisničko ime ne sme da ime razmak!" });
            }
            if (!Regex.IsMatch(email, "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,6}$"))
            {
                return RedirectToAction("PromenaInformacija", new { greska = "Unesite ispravan email!" });
            }

            //Provera da li je korisnik uopste promenio informacije
            if (username == korisnik.KorisnickoIme && email == korisnik.Email)
            {
                return RedirectToAction("PromenaInformacija");
            }

            //Promena korisnickog imena
            if (username != korisnik.KorisnickoIme)
            {
                if (_korisnikRepository.checkUsernameAvailability(email, username))
                {
                    _korisnikRepository.EditUsername(korisnik, username);

                    //Menjanje kolacica sa novim korisnickim imenom
                    Response.Cookies.Append("Korisnik", username, new CookieOptions
                    {
                        Secure = true,
                        HttpOnly = true,
                        Expires = DateTime.UtcNow.AddDays(7),
                        SameSite = SameSiteMode.Strict
                    });
                }
                else
                {
                    return RedirectToAction("PromenaInformacija", new { greska = "Korisnicko ime je zauzeto!" });
                }
            }

            //Promena emaila
            if (email != korisnik.Email)
            {
                if (_korisnikRepository.checkEmailAvailability(email, username))
                {
                    _korisnikRepository.EditEmail(korisnik, email);
                }
                else
                {
                    return RedirectToAction("PromenaInformacija", new { greska = "Email je već u upotrebi!" });
                }
            }

            return RedirectToAction("MessagePage", "Home", new { poruka = "Uspešna promena informacija!", dugmePoruka = "Nazad na dashboard", kontroler = "Account", akcija = "Index" });
        }

        //Metoda generise token za reset sifre i salje ga korisniku(Za svrhu projekta, umesto maila pravi se txt file sa kodom koji korisnik dobija)
        public FileResult ZatraziResetSifre()
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);

            //Generisanje random byte koda
            Random rnd = new Random(Guid.NewGuid().GetHashCode());
            byte[] resetByte = new byte[16];
            rnd.NextBytes(resetByte);
            string resetKod = Convert.ToHexString(resetByte);

            //Cuvanje koda u bazi
            _korisnikRepository.StoreResetCode(korisnik, resetKod);

            //Upisivanje u fajl i citanje bajt niza fajla
            System.IO.File.WriteAllText(_webHostEnvironment.WebRootPath + "\\Files\\resetCode" + korisnik.IdKorisnika.ToString() + ".txt", resetKod);
            byte[] fileBytes = System.IO.File.ReadAllBytes(_webHostEnvironment.WebRootPath + "\\Files\\resetCode" + korisnik.IdKorisnika.ToString() + ".txt");

            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, "resetKod.txt");
        }

        //Proverava reset token, ako je ispravan salje korisnika na stranicu za promenu sifre i daje mu mogucnost da menja sifru na 5 minuta
        [HttpPost]
        public IActionResult ProveriResetToken(string resetCode)
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);

            if (_korisnikRepository.CheckResetCode(korisnik, resetCode))
            {
                //Kolacic koji istice za 5 minuta, oznacava da korisnik moze da menja sifru
                Response.Cookies.Append("MozeDaMenja", "Da", new CookieOptions
                {
                    Secure = true,
                    HttpOnly = true,
                    Expires = DateTime.UtcNow.AddMinutes(5),
                    SameSite = SameSiteMode.Strict
                });

                return RedirectToAction("PromenaSifre");
            }
            else
            {
                return RedirectToAction("PromenaInformacija", new { greska = "Ne važeći token!" });
            }
        }

        //Pogled za formu za promenu sifre
        public IActionResult PromenaSifre(string greska)
        {
            ViewData["Greska"] = greska;

            return View("PromenaSifre");
        }

        //Metoda za promenu sifre ukoliko je kod jos uvek validan
        [HttpPost]
        public IActionResult PromenaSifre(string password, string password_confirm)
        {
            KorisnikBO korisnik = _korisnikRepository.getByUsername(HttpContext.Request.Cookies["Korisnik"]);

            //Validacija unosa
            if (string.IsNullOrEmpty(password) || string.IsNullOrEmpty(password_confirm))
            {
                return RedirectToAction("PromenaSifre", new { greska = "Sva polja su obavezna!" });
            }
            if (password != password_confirm)
            {
                return RedirectToAction("PromenaSifre", new { greska = "Šifre se ne podudaraju!" });
            }
            if (!Regex.IsMatch(password, "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$"))
            {
                return RedirectToAction("PromenaSifre", new { greska = "Šifra mora da ima minimum osam karaktera. Bar jedno veliko, jedno malo slovo i broj!" });
            }

            //Provera da li je token istekao
            var mozeDaMenja = HttpContext.Request.Cookies["MozeDaMenja"];
            if (string.IsNullOrEmpty(mozeDaMenja))
            {
                return RedirectToAction("PromenaInformacija", new { greska = "Ne važeći token!" });
            }

            //Promena sifre
            _korisnikRepository.EditPassword(korisnik, password);

            return RedirectToAction("MessagePage", "Home", new { poruka = "Šifra je uspešno promenjena!", dugmePoruka = "Nazad na dashboard", kontroler = "Account", akcija = "Index" });
        }
    }
}
