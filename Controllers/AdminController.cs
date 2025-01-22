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
        PromocijaRepository _promocijaRepository;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public AdminController(IWebHostEnvironment webHost)
        {
            _korisnikRepository = new KorisnikRepository();
            _rezervacijaRepository = new RezervacijaRepository();
            _promocijaRepository = new PromocijaRepository();
            _webHostEnvironment = webHost;
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

        //Metoda za prikaz stranice za upravljanje promocijama
        public IActionResult UpravljanjePromocijama(string greska)
        {
            ViewData["Greska"] = greska;
            List<PromocijaBO> promocije = _promocijaRepository.GetAll().ToList();

            return View("UpravljanjePromocija", promocije);
        }

        //Metoda za dodavanje nove promocije u bazu
        [HttpPost]
        public IActionResult NovaPromocija(string destinacijaUnos, string tekstUnos, IFormFile slikaUnos)
        {
            //Validacija unosa
            if (string.IsNullOrEmpty(destinacijaUnos) || string.IsNullOrEmpty(tekstUnos) || slikaUnos == null)
            {
                return RedirectToAction("UpravljanjePromocijama", new { greska = "Sva polja su obavezna!" });
            }
            if (slikaUnos.ContentType.ToLower() != "image/jpg" && slikaUnos.ContentType.ToLower() != "image/jpeg")
            {
                return RedirectToAction("UpravljanjePromocijama", new { greska = "Slika mora da bude jpg formata!" });
            }

            //Cuvanje u bazi
            if (_promocijaRepository.CheckIfExists(destinacijaUnos))
            {
                return RedirectToAction("UpravljanjePromocijama", new { greska = "Promocija za datu destinaciju već postoji!" });
            }
            else
            {
                PromocijaBO novaPromocija = new PromocijaBO()
                {
                    Destinacija = destinacijaUnos,
                    Tekst = tekstUnos,
                    AktivanSlot = null
                };

                _promocijaRepository.Add(novaPromocija);
            }

            //Cuvanje slike
            string putanja = Path.Combine(_webHostEnvironment.WebRootPath, "images\\Promo\\" + destinacijaUnos + ".jpg");
            using (FileStream stream = new FileStream(putanja, FileMode.Create))
            {
                slikaUnos.CopyTo(stream);
            }

            return RedirectToAction("UpravljanjePromocijama");
        }

        //Metoda za promenu aktivnih promocija
        [HttpPost]
        public IActionResult PromeniAktivne(int slot1Select, int slot2Select, int slot3Select)
        {
            //Validacija unosa
            if (slot1Select == 0 || slot2Select == 0 || slot3Select == 0)
            {
                return RedirectToAction("UpravljanjePromocijama", new { greska = "Sva 3 slota moraju da imaju promociju!" });
            }
            if (slot1Select == slot2Select || slot1Select == slot3Select || slot2Select == slot3Select)
            {
                return RedirectToAction("UpravljanjePromocijama", new { greska = "Ista promocija ne može da bude u više od jednog slota!" });
            }

            //Izvrsavanje promena
            _promocijaRepository.ChangeActivePromos(slot1Select, slot2Select, slot3Select);

            return RedirectToAction("UpravljanjePromocijama");
        }

        //Motoda za brisanje promocije
        public IActionResult ObrisiPromociju(int id)
        {
            PromocijaBO? promocija = _promocijaRepository.GetById(id);

            //Ako promocija ne postoji ili je aktivna (Protekcija za direktan unos linka) vraca gresku, ako postoji brise je
            if (promocija == null || promocija.AktivanSlot > 0)
            {
                return RedirectToAction("UpravljanjePromocijama", new { greska = "Ne postojeća/aktivna promocija!" });
            }
            else
            {
                //Brisanje slike
                FileInfo slika = new FileInfo(Path.Combine(_webHostEnvironment.WebRootPath, "images\\Promo\\" + promocija.Destinacija + ".jpg"));
                if (slika.Exists)
                {
                    slika.Delete();
                }
               
                //Brisanje promocije
                _promocijaRepository.Delete(promocija);
            }

            return RedirectToAction("UpravljanjePromocijama");
        }

        //Metoda za prikaz stranice za unos novog korisnika
        public IActionResult NoviKorisnik(string greska)
        {
            ViewData["Greska"] = greska;

            return View("NoviKorisnik");
        }

        //Metoda za dodavanje novog korisnika u bazu
        [HttpPost]
        public IActionResult NoviKorisnik(IFormCollection podaci)
        {
            //validacija unosa
            if (string.IsNullOrEmpty(podaci["username"]) || string.IsNullOrEmpty(podaci["email"]) || string.IsNullOrEmpty(podaci["password"]) || string.IsNullOrEmpty(podaci["password_confirm"]) || string.IsNullOrEmpty(podaci["name"]) || string.IsNullOrEmpty(podaci["surname"]) || string.IsNullOrEmpty(podaci["address"]))
            {
                return RedirectToAction("NoviKorisnik", new { greska = "Sva polja su obavezna!" });
            }
            if (Regex.IsMatch(podaci["username"], "\\s"))
            {
                return RedirectToAction("NoviKorisnik", new { greska = "Korisničko ime ne sme da ime razmak!" });
            }
            if (!Regex.IsMatch(podaci["email"], "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,6}$"))
            {
                return RedirectToAction("NoviKorisnik", new { greska = "Unesite ispravan email!" });
            }
            if (!Regex.IsMatch(podaci["password"], "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$"))
            {
                return RedirectToAction("NoviKorisnik", new { greska = "Šifra mora da ima minimum osam karaktera. Bar jedno veliko, jedno malo slovo i broj!" });
            }
            if (podaci["password"] != podaci["password_confirm"])
            {
                return RedirectToAction("NoviKorisnik", new { greska = "Šifre se ne poklapaju!" });
            }

            //Provera da li je email vec zauzet
            KorisnikBO? korisnikEmail = _korisnikRepository.getByEmail(podaci["email"]);

            if (korisnikEmail != null)
            {
                return RedirectToAction("NoviKorisnik", new { greska = "Email je već zauzet!" });
            }

            //Proverava da li je korisnicko ime vec zauzeto
            KorisnikBO? korisnikIme = _korisnikRepository.getByUsername(podaci["username"]);
            if (korisnikIme != null)
            {
                return RedirectToAction("NoviKorisnik", new { greska = "Korisničko ime je već zauzeto!" });
            }

            //Kreiranje novog korisnika ukoliko su osnovne informacije slobodne
            KorisnikBO noviKorisnik = new KorisnikBO();
            noviKorisnik.KorisnickoIme = podaci["username"];
            noviKorisnik.Email = podaci["email"];
            noviKorisnik.Ime = podaci["name"];
            noviKorisnik.Prezime = podaci["surname"];
            noviKorisnik.Adresa = podaci["address"];
            if (podaci["administrator"] == "admin")
            {
                noviKorisnik.Administrator = 1;
            }
            else
            {
                noviKorisnik.Administrator = 0;
            }    

            _korisnikRepository.add(noviKorisnik, podaci["password"]);

            return RedirectToAction("MessagePage", "Home", new { poruka = "Uspešno ste dodali novog korisnka: " + noviKorisnik.KorisnickoIme, dugmePoruka = "Nazad na pregled korisnika", kontroler = "Admin", akcija = "PregledKorisnika" });
        }
    }
}
