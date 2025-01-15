namespace OnlineRezervacijaAvioKarata.Models
{
    public class KorisnikBO
    {
        public int IdKorisnika { get; set; }

        public string KorisnickoIme { get; set; } = null!;

        public string Email { get; set; } = null!;

        //public string Sifra { get; set; } = null!;

        public string? PasswordResetToken { get; set; }

        public string? Ime { get; set; }

        public string? Prezime { get; set; }

        public string? Adresa { get; set; }

        public byte? Administrator { get; set; }

        public byte? IsDeleted { get; set; }

        public DateTime? PasswordResetTimestamp { get; set; }
    }
}
