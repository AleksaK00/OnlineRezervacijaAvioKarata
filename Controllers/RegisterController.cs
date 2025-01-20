using Azure.Core;
using Microsoft.AspNetCore.Mvc;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;
using System.Text.RegularExpressions;

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
            //validacija unosa
            if (string.IsNullOrEmpty(podaci["username"]) || string.IsNullOrEmpty(podaci["email"]) || string.IsNullOrEmpty(podaci["password"]) || string.IsNullOrEmpty(podaci["password_confirm"]) || string.IsNullOrEmpty(podaci["name"]) || string.IsNullOrEmpty(podaci["surname"]) || string.IsNullOrEmpty(podaci["address"]))
            {
                return RedirectToAction("Index", new {greska = "Sva polja su obavezna!"});
            }
            if (Regex.IsMatch(podaci["username"], "\\s"))
            {
                return RedirectToAction("Index", new { greska = "Korisničko ime ne sme da ime razmak!" });
            }
            if (!Regex.IsMatch(podaci["email"], "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,6}$"))
            {
                return RedirectToAction("Index", new { greska = "Unesite ispravan email!"});
            }
            if (!Regex.IsMatch(podaci["password"], "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$"))
            {
                return RedirectToAction("Index", new { greska = "Šifra mora da ima minimum osam karaktera. Bar jedno veliko, jedno malo slovo i broj!" });
            }
            if (podaci["password"] != podaci["password_confirm"])
            {
                return RedirectToAction("Index", new { greska = "Šifre se ne poklapaju!" });
            }

            //Provera da li upisani email pripada obrisanom nalogu, u slucaju da pripada nalog se reaktivira sa novim informacijama
            KorisnikBO? korisnikEmail = _korisnikRepository.getByEmail(podaci["email"]);

            if (korisnikEmail != null)
            {
                if (korisnikEmail.IsDeleted == 1)
                {
                    //Proverava da li je neki drugi korisnik vec zauzeo korisnicko ime, azurira i aktivira nalog ako nije
                    if (_korisnikRepository.checkUsernameAvailability(podaci["email"], podaci["username"]))
                    {
                        KorisnikBO azuriraniKorisnik = new KorisnikBO();
                        azuriraniKorisnik.KorisnickoIme = podaci["username"];
                        azuriraniKorisnik.Email = podaci["email"];
                        azuriraniKorisnik.Ime = podaci["name"];
                        azuriraniKorisnik.Prezime = podaci["surname"];
                        azuriraniKorisnik.Adresa = podaci["address"];

                        _korisnikRepository.edit(azuriraniKorisnik, podaci["password"]);

                        //Ulogovanje putem kolacica
                        Response.Cookies.Append("Korisnik", azuriraniKorisnik.KorisnickoIme, new CookieOptions
                        {
                            Secure = true,
                            HttpOnly = true,
                            Expires = DateTime.UtcNow.AddDays(7),
                            SameSite = SameSiteMode.Strict
                        });
                        return RedirectToAction("MessagePage", "Home", new { poruka = "Uspesno ste reaktivirali nalog! Dobrodošli nazad " + azuriraniKorisnik.KorisnickoIme, dugmePoruka = "Nazad na početnu stranu", kontroler = "Home", akcija = "Index" });
                    }
                    else
                    {
                        return RedirectToAction("Index", new { greska = "Korisničko ime je već zauzeto!" });
                    }
                }
                else
                {
                    return RedirectToAction("Index", new { greska = "Email je zauzet!" });
                }
            }

            //Proverava da li je korisnicko ime vec zauzeto
            KorisnikBO? korisnikIme = _korisnikRepository.getByUsername(podaci["username"]);
            if (korisnikIme != null)
            {
                return RedirectToAction("Index", new { greska = "Korisničko ime je već zauzeto!" });
            }

            //Kreiranje novog korisnika ukoliko nije
            KorisnikBO noviKorisnik = new KorisnikBO();
            noviKorisnik.KorisnickoIme = podaci["username"];
            noviKorisnik.Email = podaci["email"];
            noviKorisnik.Ime = podaci["name"];
            noviKorisnik.Prezime = podaci["surname"];
            noviKorisnik.Adresa = podaci["address"];

            _korisnikRepository.add(noviKorisnik, podaci["password"]);

            //Ulogovanje putem kolacica
            Response.Cookies.Append("Korisnik", noviKorisnik.KorisnickoIme, new CookieOptions
            {
                Secure = true,
                HttpOnly = true,
                Expires = DateTime.UtcNow.AddDays(7),
                SameSite = SameSiteMode.Strict
            });
            return RedirectToAction("MessagePage", "Home", new { poruka = "Uspesna registracija! Dobrodošli " + noviKorisnik.KorisnickoIme, dugmePoruka = "Nazad na početnu stranu", kontroler = "Home", akcija = "Index" });
        }
    }
}
