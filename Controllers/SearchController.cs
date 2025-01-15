using Microsoft.AspNetCore.Mvc;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;
using System.Globalization;

namespace OnlineRezervacijaAvioKarata.Controllers
{
    //Kontroler koji obavlja funkciju pretrage
    public class SearchController : Controller
    {
        private PromocijaRepository _promocijaRepository;
        private AerodromRepository _aerodromRepository;
        private LetRepository _letRepository;
        private AvioKompanijaRepository _avioKompanijaRepository;
        private InstancaLetaRepository _instancaLetaRepository;

        public SearchController()
        {
            _promocijaRepository = new PromocijaRepository();
            _aerodromRepository = new AerodromRepository();
            _letRepository = new LetRepository();
            _avioKompanijaRepository = new AvioKompanijaRepository();
            _instancaLetaRepository = new InstancaLetaRepository();
        }

        //Indeks pogled je identican pocetnoj stranici
        public IActionResult Index()
        {
            RezultatPretrage rezultatPretrage = new RezultatPretrage();
            ViewData["Promocije"] = _promocijaRepository.GetActive();
            ViewData["Greska"] = "";
            return View("Index", rezultatPretrage);
        }

        //Metoda koja vrsi pretragu na osnovu unesenih podataka za polazni i dolazni grad
        [HttpPost]
        public IActionResult Index(string polazniAerodrom, string dolazniAerodrom)
        {
            RezultatPretrage rezultatPretrage = new RezultatPretrage();
            ViewData["Promocije"] = _promocijaRepository.GetActive();

            //Validacija unosa
            if (string.IsNullOrEmpty(polazniAerodrom) || string.IsNullOrEmpty(polazniAerodrom))
            {
                ViewData["Greska"] = "Unesite polazni i dolazni grad!";
                return View("Index", rezultatPretrage);
            }

            //Hvatanje svih aerodroma u gradovima
            List<AerodromBO> polazniAerodromi = _aerodromRepository.GetByCity(polazniAerodrom).ToList();
            List<AerodromBO> dolazniAerodromi = _aerodromRepository.GetByCity(dolazniAerodrom).ToList();

            //Vracanje obavestenja ukoliko nema aerodroma zapisanog u bazi
            if (polazniAerodrom.Count() == 0 || polazniAerodrom.Count() == 0)
            {
                ViewData["Greska"] = "Nema dostupnih letova između dva grada!";
                return View("Index", rezultatPretrage);
            }

            rezultatPretrage.MinCena = 0;
            rezultatPretrage.MaxCena = 0;
            //Pretrazivanje letova izmedju svih kombinacija aerodroma, uz dodavanje potebnih informacija u informacije za filtere
            foreach (AerodromBO polazni in polazniAerodromi)
            {
                rezultatPretrage.PolazniAerodromi.Add(polazni);

                foreach (AerodromBO dolazni in dolazniAerodromi)
                {
                    rezultatPretrage.DolazniAerodromi.Add(dolazni);

                    List<LetBO> letovi = _letRepository.GetByAirports(polazni.IcaoKodAerodroma, dolazni.IcaoKodAerodroma).ToList();
                    foreach(LetBO letbo in letovi)
                    {
                        //Kreiranje novog pojedinacnog rezultata
                        PojedinacniRezultat trenutniRezultat = new PojedinacniRezultat();

                        trenutniRezultat.Let = letbo;
                        trenutniRezultat.PolazniAerodrom = polazni;
                        trenutniRezultat.DolazniAeordrom = dolazni;
                        trenutniRezultat.AvioKompanija = _avioKompanijaRepository.GetByICAOkod(letbo.IcaoKod);
                        trenutniRezultat.CenaOd = (float)_instancaLetaRepository.minimalnaCena(letbo.BrLeta);

                        //Promena filtera ukoliko je potrebno
                        if (rezultatPretrage.MinCena == 0 || trenutniRezultat.CenaOd < rezultatPretrage.MinCena)
                        {
                            rezultatPretrage.MinCena = trenutniRezultat.CenaOd;
                        }
                        if (rezultatPretrage.MaxCena == 0 || trenutniRezultat.CenaOd > rezultatPretrage.MaxCena)
                        {
                            rezultatPretrage.MaxCena = trenutniRezultat.CenaOd;
                        }
                        if (!rezultatPretrage.AvioKompanije.Exists(ak => ak.IcaoKod == trenutniRezultat.AvioKompanija.IcaoKod))
                        {
                            rezultatPretrage.AvioKompanije.Add(trenutniRezultat.AvioKompanija);
                        }

                        //Dodavanje trenutnog rezultata u listu svih rezultata pretrage
                        rezultatPretrage.RezultatiPretrage.Add(trenutniRezultat);
                    }
                }
            }

            //CultureInfo za formatiranje cene u evrima
            CultureInfo culture = new CultureInfo("fr-FR");
            ViewBag.culture = culture;

            //Ispisivanje pogleda sa sortiranim rezultatima po minimalnoj ceni
            ViewData["Greska"] = "";
            rezultatPretrage.RezultatiPretrage = rezultatPretrage.RezultatiPretrage.OrderBy(rezultat => rezultat.CenaOd).ToList();
            return View("Index", rezultatPretrage);
        }
    }
}
