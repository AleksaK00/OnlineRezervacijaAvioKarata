using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;

namespace OnlineRezervacijaAvioKarata.Filters
{
    //Filter za proveru admin privilegija korisnika
    public class AdminRequiredFilter : IAuthorizationFilter
    {
        private KorisnikRepository _korisnikRepository;


        public void OnAuthorization(AuthorizationFilterContext context)
        {
            //Provera da li je korisnik uopste ulogovan
            var korisnik = context.HttpContext.Request.Cookies["Korisnik"];
            if (string.IsNullOrEmpty(korisnik))
            {
                context.Result = new RedirectToActionResult("MessagePage", "Home", new { poruka = "Morate biti prijavljeni da bi ste pristupili strani!", dugmePoruka = "Prijavi se", kontroler = "Login", akcija = "Index" });
            }
            else
            {
                //Provera admin privilegija
                _korisnikRepository = new KorisnikRepository();
                KorisnikBO korisnikProvera = _korisnikRepository.getByUsername(korisnik);
                if (korisnikProvera.Administrator != 1)
                {
                    context.Result = new RedirectToActionResult("MessagePage", "Home", new { poruka = "Nemate privilegije da pristupite ovoj stranici", dugmePoruka = "Nazad na početnu", kontroler = "Home", akcija = "Index" });
                }
            }            
        }
    }
}
