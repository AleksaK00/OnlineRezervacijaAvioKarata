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

    }
}
