using Microsoft.AspNetCore.Mvc;
using OnlineRezervacijaAvioKarata.Filters;
using OnlineRezervacijaAvioKarata.Models;
using OnlineRezervacijaAvioKarata.Models.EFRepository;
using System.Text.RegularExpressions;

namespace OnlineRezervacijaAvioKarata.Controllers
{
    [ServiceFilter(typeof(AdminRequiredFilter))]
    public class AdminController : Controller
    {
        KorisnikRepository _korisnikRepository;
        RezervacijaRepository _rezervacijaRepository;

        public AdminController()
        {
            _korisnikRepository = new KorisnikRepository();
            _rezervacijaRepository = new RezervacijaRepository();
        }

        //Stranica za pregled korisnika, pocetna stranica admin panela
        public IActionResult PregledKorisnika(string greska)
        {
            List<KorisnikBO> korisnici = _korisnikRepository.GetAllRegular().ToList();
            ViewData["Greska"] = greska;


            return View("PregledKorisnika", korisnici);
        }

        //Parcijalni pogled za navigaciju stranica admin panela
        public IActionResult NavigacijaAdmin()
        {
            return PartialView();
        }

        //Metoda za pretragu korisnika po ID-u ili korisnickom imenu
        [HttpPost]
        public IActionResult PretraziKorisnike(string pretragaPolje)
        {
            //U slucaju ne unosenja podataka, vraca se pretraga svih korisnika
            if (string.IsNullOrEmpty(pretragaPolje))
            {
                return RedirectToAction("PregledKorisnika");
            }

            //Provera da li je admin uneo ID ili ime/deo imena
            int IdKorisnika = 0;
            bool jeBroj;
            jeBroj = int.TryParse(pretragaPolje, out IdKorisnika);

            if (jeBroj)
            {
                //Pretraga po ID-u
                List<KorisnikBO> korisnici = new List<KorisnikBO>();
                KorisnikBO? korisnik = _korisnikRepository.getByID(IdKorisnika);

                if (korisnik != null)
                {
                    korisnici.Add(korisnik);
                }
                return View("PregledKorisnika", korisnici);

            }
            else
            {
                //Pretraga po imenu
                List<KorisnikBO> korisnici = _korisnikRepository.GetAllCointaining(pretragaPolje).ToList();
                return View("PregledKorisnika", korisnici);
            }
        }

        //Metoda za gasenje korisnickog naloga
        public IActionResult UgasiNalog(int id)
        {
            KorisnikBO? korisnik = _korisnikRepository.getByID(id);

            //Ako korisnik ne postoji (Protekcija za direktan unos linka) vraca gresku, ako postoji gasi nalog
            if (korisnik == null)
            {
                return RedirectToAction("PregledKorisnika", new { greska = "Ne postojeci korisnik!" });
            }
            else
            {
                //Otkazivanje rezervacija za nalog koji se gasi
                List<RezervacijaBO> rezervacijeBO = _rezervacijaRepository.getReservationsByUserID(korisnik.IdKorisnika).ToList();
                foreach (RezervacijaBO rezervacijaBO in rezervacijeBO.Where(r => r.Otkazana != 1).ToList())
                {
                    _rezervacijaRepository.CancelReservation(rezervacijaBO);
                }

                //Gasenje naloga
                _korisnikRepository.ShutDownAcount(korisnik);
                return RedirectToAction("PregledKorisnika");
            }
        }

        //Metoda za vracanje(reaktiviranje) korisnickog naloga od strane admina
        public IActionResult VratiNalog(int id)
        {
            KorisnikBO? korisnik = _korisnikRepository.getByID(id);

            //Ako korisnik ne postoji (Protekcija za direktan unos linka) vraca gresku, ako postoji reaktivira nalog
            if (korisnik == null)
            {
                return RedirectToAction("PregledKorisnika", new { greska = "Ne postojeci korisnik!" });
            }
            else
            {
                //Vracanje naloga
                _korisnikRepository.ReactivateAccount(korisnik);
                return RedirectToAction("PregledKorisnika");
            }
        }

        //Metoda za trajno brisanje naloga
        public IActionResult ObrisiNalog(int id)
        {
            KorisnikBO? korisnik = _korisnikRepository.getByID(id);

            //Ako korisnik ne postoji (Protekcija za direktan unos linka) vraca gresku, ako postoji reaktivira nalog
            if (korisnik == null)
            {
                return RedirectToAction("PregledKorisnika", new { greska = "Ne postojeci korisnik!" });
            }
            else
            {
                //Brisanje rezervacija i korisnika
                _rezervacijaRepository.DeleteAllForUser(id);
                _korisnikRepository.DeleteAccount(korisnik);

                return RedirectToAction("PregledKorisnika");
            }
        }

        public IActionResult PromeniKorisnickoIme(int id, string novoKorisnickoIme)
        {
            KorisnikBO? korisnik = _korisnikRepository.getByID(id);

            //Ako korisnik ne postoji (Protekcija za direktan unos linka) vraca gresku, ako postoji reaktivira nalog
            if (korisnik == null)
            {
                return RedirectToAction("PregledKorisnika", new { greska = "Ne postojeci korisnik!" });
            }
            else
            {
                //Validacija unosa
                if (string.IsNullOrEmpty(novoKorisnickoIme))
                {
                    return RedirectToAction("PregledKorisnika", new { greska = "Polje ne sme da bude prazno" });
                }
                if (Regex.IsMatch(novoKorisnickoIme, "\\s"))
                {
                    return RedirectToAction("PregledKorisnika", new { greska = "Korisničko ime ne sme da ima razmak" });
                }
                if (novoKorisnickoIme == korisnik.KorisnickoIme)
                {
                    return RedirectToAction("PregledKorisnika", new { greska = "Novo ime je isto kao i staro" });
                }

                //Menjanje korisnickog imena
                _korisnikRepository.EditUsername(korisnik, novoKorisnickoIme);
                return RedirectToAction("PregledKorisnika");
            }
        }

        //Metoda za ispis stranice za pregled rezervacija admina, u klasi AdminPogledRezervacija sa dodatnim informacijama
        public IActionResult PregledRezervacija()
        {
            List<AdminPogledRezervacija> rezervacije = _rezervacijaRepository.GetAllForAdmin().ToList();

            return View("PregledRezervacija", rezervacije);
        }

        //Metoda za pretragu rezervacija po korisnickom imenu
        [HttpPost]
        public IActionResult PretraziRezervacije(string pretragaPolje)
        {
            List<AdminPogledRezervacija> rezervacije = _rezervacijaRepository.GetAllForAdmin().ToList();
            //Pretraga po korisnickom imenu
            if (!string.IsNullOrEmpty(pretragaPolje))
            {
                rezervacije = rezervacije.Where(r => r.KorisnickoIme.Contains(pretragaPolje, StringComparison.OrdinalIgnoreCase)).ToList();
            }

            return View("PregledRezervacija", rezervacije);
        }

        //Metoda za otkazivanje rezervacije, klasa predstavlja id korisnika ali nisam hteo da pravim novu rutu za jednu akciju
        public IActionResult OtkaziRezervaciju(string brLeta, DateOnly datumPolaska, int klasa)
        {
            int id = klasa;

            RezervacijaBO rezervacija = _rezervacijaRepository.GetReservation(brLeta, datumPolaska, id);
            _rezervacijaRepository.CancelReservation(rezervacija);

            return RedirectToAction("PregledRezervacija");
        }
    }
}
