namespace OnlineRezervacijaAvioKarata.Models
{
    public class AvionBO
    {
        public string Registracija { get; set; } = null!;

        public string? IcaoKod { get; set; }

        public string? Proizvodjac { get; set; }

        public string Model { get; set; } = null!;

        public virtual AvioKompanijaBO? IcaoKodNavigation { get; set; }
    }
}
