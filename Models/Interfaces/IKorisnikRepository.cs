namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IKorisnikRepository
    {
        KorisnikBO? getByUsername(string korisnickoIme);
        bool checkPassword(KorisnikBO korisnik, string sifra);
    }
}
