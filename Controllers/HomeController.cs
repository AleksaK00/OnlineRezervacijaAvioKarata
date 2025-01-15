using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;

namespace OnlineRezervacijaAvioKarata.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private PromocijaRepository _promocijaRepository;

        //Instanciranje repositorija sa promocijama
        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
            _promocijaRepository = new PromocijaRepository();
        }

        public IActionResult Index()
        {
            ViewData["Promocije"] = _promocijaRepository.GetActive();
            return View();
        }

        //Parcijalni pogled, karusela sa trenutno aktivnim promocijama
        public IActionResult Promocije()
        {  
            return PartialView("Promocije", _promocijaRepository.GetActive());
        }

        //Pogled stranice sa obavestenjima, potrebna poruka se prenosi po zavrsetku drugih akcija po potrebi
        public IActionResult MessagePage(string poruka, string dugmePoruka, string kontroler, string akcija)
        {
            ViewData["Poruka"] = poruka;
            ViewData["DugmePoruka"] = dugmePoruka;
            ViewData["Kontroler"] = kontroler;
            ViewData["Akcija"] = akcija;
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
