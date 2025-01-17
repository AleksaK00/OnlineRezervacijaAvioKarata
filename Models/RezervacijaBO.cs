namespace OnlineRezervacijaAvioKarata.Models
{
    public class RezervacijaBO
    {
        public DateOnly DatumPolaska { get; set; }

        public string BrLeta { get; set; } = null!;

        public string IcaoKod { get; set; } = null!;

        public int IdKorisnika { get; set; }

        public int BrKarata { get; set; }

        public string Klasa { get; set; } = null!;

        public string Ime { get; set; } = null!;

        public string Prezime { get; set; } = null!;

        public byte? Otkazana { get; set; }

        public string Adresa { get; set; } = null!;

        public virtual KorisnikBO IdKorisnikaNavigation { get; set; } = null!;

        public virtual InstancaLetaBO InstancaLetum { get; set; } = null!;
    }
}
