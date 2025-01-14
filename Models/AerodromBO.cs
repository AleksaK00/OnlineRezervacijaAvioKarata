namespace OnlineRezervacijaAvioKarata.Models
{
    public class AerodromBO
    {
        public string IcaoKodAerodroma { get; set; } = null!;

        public string? Grad { get; set; }

        public string? Ime { get; set; }

        public string? Drzava { get; set; }
    }
}
