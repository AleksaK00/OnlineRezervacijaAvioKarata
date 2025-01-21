using AspNetCoreGeneratedDocument;

namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IKorisnikRepository
    {
        KorisnikBO? getByUsername(string korisnickoIme);
        KorisnikBO? getByEmail(string email);
        KorisnikBO? getByID(int id);
        IEnumerable<KorisnikBO> GetAllRegular();
        IEnumerable<KorisnikBO> GetAllCointaining(string deoImena);
        bool checkPassword(KorisnikBO korisnik, string sifra);
        bool checkUsernameAvailability(string email, string korisnickoIme);
        bool checkEmailAvailability(string email, string korisnickoIme);
        void add(KorisnikBO noviKorisnik, string sifra);
        void edit(KorisnikBO noviKorisnik, string sifra);
        void ShutDownAcount(KorisnikBO korisnikBO);
        void ReactivateAccount(KorisnikBO korisnikBO);
        void DeleteAccount(KorisnikBO korisnikBO);
        void EditPersonalInfo(KorisnikBO korisnikBO, string ime, string prezime, string adresa);
        void EditUsername(KorisnikBO korisnikBO, string korisnickoIme);
        void EditEmail(KorisnikBO korisnikBO, string email);
        void StoreResetCode(KorisnikBO korisnikBO, string kod);
        bool CheckResetCode(KorisnikBO korisnikBO, string kod);
        void EditPassword(KorisnikBO korisnikBO, string sifra);
    }
}
