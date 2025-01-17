using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace OnlineRezervacijaAvioKarata.Filters
{
    public class LoginRequiredFilter : IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var korisnik = context.HttpContext.Request.Cookies["Korisnik"];
            if (string.IsNullOrEmpty(korisnik))
            {
                context.Result = new RedirectToActionResult("MessagePage", "Home", new { poruka = "Morate biti prijavljeni da bi ste pristupili strani!", dugmePoruka = "Prijavi se", kontroler = "Login", akcija = "Index" });
            }
        }
    }
}
