namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IKorisnikRepository
    {
        KorisnikBO? getByUsername(string korisnickoIme);
        KorisnikBO? getByEmail(string email);
        bool checkPassword(KorisnikBO korisnik, string sifra);
        bool ckeckUsernameAvailability(string email, string korisnickoIme);
        void add(KorisnikBO noviKorisnik, string sifra);
        void edit(KorisnikBO noviKorisnik, string sifra);
        void ShutDownAcount(KorisnikBO korisnikBO);
    }
}
