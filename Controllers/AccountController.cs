using Microsoft.AspNetCore.Mvc;
using OnlineRezervacijaAvioKarata.Filters;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;
using System.Globalization;

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

        public AccountController()
        {
            _korisnikRepository = new KorisnikRepository();
            _rezervacijaRepository = new RezervacijaRepository();
            _letRepository = new LetRepository();
            _avioKompanijaRepository = new AvioKompanijaRepository();
            _aerodromRepository = new AerodromRepository(); 
            _nalogRepository = new NalogRepository();
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
    }
}
