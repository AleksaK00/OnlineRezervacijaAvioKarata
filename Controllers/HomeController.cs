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

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
