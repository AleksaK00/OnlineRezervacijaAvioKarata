using Microsoft.AspNetCore.Mvc;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace OnlineRezervacijaAvioKarata.Controllers
{
    public class LoginController : Controller
    {
        private KorisnikRepository _korisnikRepository;
        public LoginController()
        {
            _korisnikRepository = new KorisnikRepository();
        }

        public IActionResult Index(string greska)
        {
            if (!string.IsNullOrEmpty(greska))
            {
                ViewData["Greska"] = greska;
            }
            return View();
        }

        //Metoda koja uloguje korisnika ako korisnicko ime postoji i sifra se podudara
        [HttpPost]
        public IActionResult Login(string username, string password)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                return RedirectToAction("Index", new { greska = "Sva polja su obavezna!"});
            }

            //Provera da li je korisnik sa istim imenom nadjen, i ako jeste da li je u pitanju obrisan nalog
            KorisnikBO? korisnik = _korisnikRepository.getByUsername(username);
            if (korisnik == null || korisnik.IsDeleted == 1)
            {
                return RedirectToAction("Index", new { greska = "Ne ispravna lozinka ili korisničko ime" });
            }

            if(!_korisnikRepository.checkPassword(korisnik, password))
            {
                return RedirectToAction("Index", new { greska = "Ne ispravna lozinka ili korisničko ime" });
            }

            //Ulogovanje putem kolacica
            Response.Cookies.Append("Korisnik", korisnik.KorisnickoIme, new CookieOptions
            {
                Secure = true,
                HttpOnly = true,
                Expires = DateTime.UtcNow.AddDays(7),
                SameSite = SameSiteMode.Strict
            });
            return RedirectToAction("Index", "Home");
        }

        //Odjavljivanje korisnika
        public IActionResult Odjava()
        {
            Response.Cookies.Delete("Korisnik");

            return RedirectToAction("Index", "Home");
        }
    }
}
