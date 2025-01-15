using Azure.Core;
using Microsoft.AspNetCore.Mvc;
using OnlineRezervacijaAvioKarata.Models.EFRepository;

namespace OnlineRezervacijaAvioKarata.Controllers
{
    public class RegisterController : Controller
    {
        private KorisnikRepository _korisnikRepository;

        public RegisterController()
        {
            _korisnikRepository = new KorisnikRepository();
        }

        public IActionResult Index(string greska)
        {
            ViewData["Greska"] = greska;
            return View();
        }

        //Metoda koja proverava unete informacije i registruje novog korisnika ako je sve ok
        [HttpPost]
        public IActionResult Index(IFormCollection podaci)
        {
            if (string.IsNullOrEmpty(podaci["username"]) || string.IsNullOrEmpty(podaci["email"]) || string.IsNullOrEmpty(podaci["password"]) || string.IsNullOrEmpty(podaci["password_confirm"]) || string.IsNullOrEmpty(podaci["name"]) || string.IsNullOrEmpty(podaci["surname"]) || string.IsNullOrEmpty(podaci["address"]))
            {
                return RedirectToAction("Index", new {greska = "Sva polja su obavezna!"});
            }

            return View();
        }
    }
}
