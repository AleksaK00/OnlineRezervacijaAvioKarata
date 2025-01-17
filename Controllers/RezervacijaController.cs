using AspNetCoreGeneratedDocument;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using OnlineRezervacijaAvioKarata.Filters;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;
using System.Globalization;

namespace OnlineRezervacijaAvioKarata.Controllers
{
    [ServiceFilter(typeof(LoginRequiredFilter))]
    public class RezervacijaController : Controller
    {
        private InstancaLetaRepository _instancaLetaRepository;
        private AvioKompanijaRepository _avioKompanijaRepository;
        private AerodromRepository _aerodromRepository;
        private LetRepository _letRepository;

        public RezervacijaController()
        {
            _instancaLetaRepository = new InstancaLetaRepository();
            _avioKompanijaRepository = new AvioKompanijaRepository();
            _aerodromRepository = new AerodromRepository();
            _letRepository = new LetRepository();
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
    }
}
