using OnlineRezervacijaAvioKarata.Models.Interfaces;
using System.Security.Cryptography;
using System.Text;

namespace OnlineRezervacijaAvioKarata.Models.EFRepository
{
    public class KorisnikRepository : IKorisnikRepository
    {
        private OnlineRezervacijaKarataContext rezervacijaEntities = new OnlineRezervacijaKarataContext();

        //Metoda vraca korisnika sa datim korisnickim imenom.
        public KorisnikBO? getByUsername(string korisnickoIme)
        {
            KorisnikBO korisnikBo = new KorisnikBO();

            //Pretraga korisnika u bazi
            Korisnik? korisnik = (from k in rezervacijaEntities.Korisniks
                                 where k.KorisnickoIme == korisnickoIme
                                 select k).SingleOrDefault();

            //Popunjavanje biznis objekta ukoliko korisnik postoji
            if (korisnik == null)
            {
                return null;
            }
            else
            {
                korisnikBo.IdKorisnika = korisnik.IdKorisnika;
                korisnikBo.KorisnickoIme = korisnik.KorisnickoIme;
                korisnikBo.Email = korisnik.Email;
                korisnikBo.Ime = korisnik.Ime;
                korisnikBo.Prezime = korisnik.Prezime;
                korisnikBo.Adresa = korisnik.Adresa;
                korisnikBo.Administrator = korisnik.Administrator;
                korisnikBo.PasswordResetToken = korisnik.PasswordResetToken;
                korisnikBo.PasswordResetTimestamp = korisnik.PasswordResetTimestamp;
                korisnikBo.IsDeleted = korisnik.IsDeleted;

                return korisnikBo;
            }
        }

        //Metoda koja proverava da li se sifra podudara
        public bool checkPassword(KorisnikBO korisnik, string sifra)
        {
            //Hash koriscenjem MD5 algoritma
            byte[] bitHash = MD5.HashData(Encoding.UTF8.GetBytes(sifra));
            string hexHash = Convert.ToHexString(bitHash);

            //Pretraga korisnika u bazi
            Korisnik korisnikProvera = (from k in rezervacijaEntities.Korisniks
                                  where k.KorisnickoIme == korisnik.KorisnickoIme
                                  select k).Single();

            //Provera sifre
            if (korisnikProvera.Sifra == hexHash)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public KorisnikBO? getByEmail(string email)
        {
            KorisnikBO korisnikBo = new KorisnikBO();

            //Pretraga korisnika u bazi
            Korisnik? korisnik = (from k in rezervacijaEntities.Korisniks
                                  where k.Email == email
                                  select k).SingleOrDefault();

            //Popunjavanje biznis objekta ukoliko korisnik postoji
            if (korisnik == null)
            {
                return null;
            }
            else
            {
                korisnikBo.IdKorisnika = korisnik.IdKorisnika;
                korisnikBo.KorisnickoIme = korisnik.KorisnickoIme;
                korisnikBo.Email = korisnik.Email;
                korisnikBo.Ime = korisnik.Ime;
                korisnikBo.Prezime = korisnik.Prezime;
                korisnikBo.Adresa = korisnik.Adresa;
                korisnikBo.Administrator = korisnik.Administrator;
                korisnikBo.PasswordResetToken = korisnik.PasswordResetToken;
                korisnikBo.PasswordResetTimestamp = korisnik.PasswordResetTimestamp;
                korisnikBo.IsDeleted = korisnik.IsDeleted;

                return korisnikBo;
            }
        }

        //Proverava da li je neki drugi korisnik zauzeo korisnicko ime
        public bool checkUsernameAvailability(string email, string korisnickoIme)
        {
            //Pretraga korisnika u bazi
            Korisnik? korisnik = (from k in rezervacijaEntities.Korisniks
                                  where k.Email != email && k.KorisnickoIme == korisnickoIme
                                  select k).SingleOrDefault();

            if (korisnik == null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //Proverava da li je email vec u upotrebi u nekom drugom nalogu
        public bool checkEmailAvailability(string email, string korisnickoIme)
        {
            //Pretraga korisnika u bazi
            Korisnik? korisnik = (from k in rezervacijaEntities.Korisniks
                                  where k.Email == email && k.KorisnickoIme != korisnickoIme
                                  select k).SingleOrDefault();

            if (korisnik == null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //Dodaje novog korisnika
        public void add(KorisnikBO noviKorisnik, string sifra)
        {
            Korisnik korisnik = new Korisnik();

            //Hash koriscenjem MD5 algoritma
            byte[] bitHash = MD5.HashData(Encoding.UTF8.GetBytes(sifra));
            string hexHash = Convert.ToHexString(bitHash);

            //Unosenje informacija
            korisnik.KorisnickoIme = noviKorisnik.KorisnickoIme;
            korisnik.Sifra = hexHash;
            korisnik.Email = noviKorisnik.Email;
            korisnik.Ime = noviKorisnik.Ime;
            korisnik.Prezime = noviKorisnik.Prezime;
            korisnik.Adresa = noviKorisnik.Adresa;
            korisnik.Administrator = noviKorisnik.Administrator;
            korisnik.PasswordResetToken = null;
            korisnik.PasswordResetTimestamp = null;
            korisnik.IsDeleted = null;

            rezervacijaEntities.Korisniks.Add(korisnik);
            rezervacijaEntities.SaveChangesAsync();
        }

        public void edit(KorisnikBO noviKorisnik, string sifra)
        {
            Korisnik korisnik = (from k in rezervacijaEntities.Korisniks
                                 where k.Email == noviKorisnik.Email
                                 select k).Single();

            //Hash koriscenjem MD5 algoritma
            byte[] bitHash = MD5.HashData(Encoding.UTF8.GetBytes(sifra));
            string hexHash = Convert.ToHexString(bitHash);

            //Unosenje informacija
            korisnik.KorisnickoIme = noviKorisnik.KorisnickoIme;
            korisnik.Sifra = hexHash;
            korisnik.Ime = noviKorisnik.Ime;
            korisnik.Prezime = noviKorisnik.Prezime;
            korisnik.Adresa = noviKorisnik.Adresa;
            korisnik.Administrator = 0;
            korisnik.PasswordResetToken = null;
            korisnik.PasswordResetTimestamp = null;
            korisnik.IsDeleted = null;

            rezervacijaEntities.Korisniks.Update(korisnik);
            rezervacijaEntities.SaveChangesAsync();
        }

        //Metoda koja gasi nalog postavljanjem Is_Deleted kolone na 1
        public void ShutDownAcount(KorisnikBO korisnikBO)
        {
            Korisnik korisnikIzBaze = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == korisnikBO.IdKorisnika).FirstOrDefault();

            korisnikIzBaze.IsDeleted = 1;

            rezervacijaEntities.Korisniks.Update(korisnikIzBaze);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda koja menja licne informacije korisnika
        public void EditPersonalInfo(KorisnikBO korisnikBO, string ime, string prezime, string adresa)
        {
            Korisnik korisnikIzBaze = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == korisnikBO.IdKorisnika).FirstOrDefault();

            korisnikIzBaze.Ime = ime;
            korisnikIzBaze.Prezime = prezime;
            korisnikIzBaze.Adresa = adresa;

            rezervacijaEntities.Korisniks.Update(korisnikIzBaze);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda za promenu korisnickog imena
        public void EditUsername(KorisnikBO korisnikBO, string korisnickoIme)
        {
            Korisnik korisnikIzBaze = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == korisnikBO.IdKorisnika).FirstOrDefault();

            korisnikIzBaze.KorisnickoIme = korisnickoIme;

            rezervacijaEntities.Korisniks.Update(korisnikIzBaze);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda koja menja email korisnika
        public void EditEmail(KorisnikBO korisnikBO, string email)
        {
            Korisnik korisnikIzBaze = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == korisnikBO.IdKorisnika).FirstOrDefault();

            korisnikIzBaze.Email = email;

            rezervacijaEntities.Korisniks.Update(korisnikIzBaze);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda cuva kod za resetovanje sifre i vreme kad je kod zatrazen
        public void StoreResetCode(KorisnikBO korisnikBO, string kod)
        {
            Korisnik korisnikIzBaze = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == korisnikBO.IdKorisnika).FirstOrDefault();

            //Hash koriscenjem MD5 algoritma
            byte[] bitHash = MD5.HashData(Encoding.UTF8.GetBytes(kod));
            string hexHash = Convert.ToHexString(bitHash);

            //Cuvanje u bazu
            korisnikIzBaze.PasswordResetToken = hexHash;
            korisnikIzBaze.PasswordResetTimestamp = DateTime.Now;

            rezervacijaEntities.Korisniks.Update(korisnikIzBaze);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda za proveru ispravnosti reset koda
        public bool CheckResetCode(KorisnikBO korisnikBO, string kod)
        {
            Korisnik korisnikIzBaze = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == korisnikBO.IdKorisnika).FirstOrDefault();
            TimeSpan petMinuta = new TimeSpan(0, 5, 0);

            //Hash koriscenjem MD5 algoritma
            byte[] bitHash = MD5.HashData(Encoding.UTF8.GetBytes(kod));
            string hexHash = Convert.ToHexString(bitHash);

            //Provera da li se hashovi koda podudaraju, i da li je kod stariji od 5 minuta
            if (korisnikIzBaze.PasswordResetToken == hexHash && korisnikIzBaze.PasswordResetTimestamp >= DateTime.Now.Subtract(petMinuta))
            {
                return true;
            }
            else 
            {
                return false;
            }

        }

        //Metoda za promenu sifre
        public void EditPassword(KorisnikBO korisnikBO, string sifra)
        {
            Korisnik korisnikIzBaze = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == korisnikBO.IdKorisnika).FirstOrDefault();

            //Hash koriscenjem MD5 algoritma
            byte[] bitHash = MD5.HashData(Encoding.UTF8.GetBytes(sifra));
            string hexHash = Convert.ToHexString(bitHash);

            //Promena sifre i resetovanje tokena za promenu sifre
            korisnikIzBaze.Sifra = hexHash;
            korisnikIzBaze.PasswordResetToken = null;
            korisnikIzBaze.PasswordResetTimestamp = null;

            rezervacijaEntities.Korisniks.Update(korisnikIzBaze);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda koja hvata sve regularne (tj nisu admini) korisnike
        public IEnumerable<KorisnikBO> GetAllRegular()
        {
            List<KorisnikBO> korisnici = new List<KorisnikBO>();

            foreach (Korisnik korisnik in rezervacijaEntities.Korisniks.Where(k => k.Administrator != 1).ToList())
            {
                KorisnikBO noviKorisnik = new KorisnikBO()
                {
                    IdKorisnika = korisnik.IdKorisnika,
                    KorisnickoIme = korisnik.KorisnickoIme,
                    Email = korisnik.Email,
                    Ime = korisnik.Ime,
                    Prezime = korisnik.Prezime,
                    Adresa = korisnik.Adresa,
                    IsDeleted = korisnik.IsDeleted,
                };

                korisnici.Add(noviKorisnik);
            }

            return korisnici;
        }

        //Hvata korisnika po id-u ukoliko postoji
        public KorisnikBO? getByID(int id)
        {
            KorisnikBO korisnikBo = new KorisnikBO();

            //Pretraga korisnika u bazi
            Korisnik? korisnik = (from k in rezervacijaEntities.Korisniks
                                  where k.IdKorisnika == id
                                  select k).FirstOrDefault();

            //Popunjavanje biznis objekta ukoliko korisnik postoji
            if (korisnik == null)
            {
                return null;
            }
            else
            {
                korisnikBo.IdKorisnika = korisnik.IdKorisnika;
                korisnikBo.KorisnickoIme = korisnik.KorisnickoIme;
                korisnikBo.Email = korisnik.Email;
                korisnikBo.Ime = korisnik.Ime;
                korisnikBo.Prezime = korisnik.Prezime;
                korisnikBo.Adresa = korisnik.Adresa;
                korisnikBo.Administrator = korisnik.Administrator;
                korisnikBo.PasswordResetToken = korisnik.PasswordResetToken;
                korisnikBo.PasswordResetTimestamp = korisnik.PasswordResetTimestamp;
                korisnikBo.IsDeleted = korisnik.IsDeleted;

                return korisnikBo;
            }
        }

        //Metoda vraca sve korisnike koje sadrze deo stringa
        public IEnumerable<KorisnikBO> GetAllCointaining(string deoImena)
        {
            List<KorisnikBO> korisnici = new List<KorisnikBO>();

            //Pretraga korisnika iz baze, case insesitive
            foreach (Korisnik korisnik in rezervacijaEntities.Korisniks.Where(k => k.Administrator != 1 && k.KorisnickoIme.Contains(deoImena)).ToList())
            {
                //Dodavanje novog biznis objekta
                KorisnikBO noviKorisnik = new KorisnikBO()
                {
                    IdKorisnika = korisnik.IdKorisnika,
                    KorisnickoIme = korisnik.KorisnickoIme,
                    Email = korisnik.Email,
                    Ime = korisnik.Ime,
                    Prezime = korisnik.Prezime,
                    Adresa = korisnik.Adresa,
                    IsDeleted = korisnik.IsDeleted,
                };

                korisnici.Add(noviKorisnik);
            }

            return korisnici;
        }

        //Metoda koja reaktivira nalog korisnika
        public void ReactivateAccount(KorisnikBO korisnikBO)
        {
            Korisnik korisnikIzBaze = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == korisnikBO.IdKorisnika).FirstOrDefault();

            korisnikIzBaze.IsDeleted = null;

            rezervacijaEntities.Korisniks.Update(korisnikIzBaze);
            rezervacijaEntities.SaveChanges();
        }

        //Metoda za brisanje naloga
        public void DeleteAccount(KorisnikBO korisnikBO)
        {
            Korisnik korisnikIzBaze = rezervacijaEntities.Korisniks.Where(k => k.IdKorisnika == korisnikBO.IdKorisnika).FirstOrDefault();

            rezervacijaEntities.Korisniks.Remove(korisnikIzBaze);
            rezervacijaEntities.SaveChanges();
        }
    }
}
