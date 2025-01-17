namespace OnlineRezervacijaAvioKarata.Models
{
    public class SedisteBO
    {
        public string BrSedista { get; set; } = null!;

        public string Registracija { get; set; } = null!;

        public string Klasa { get; set; } = null!;

        public double? Doplata { get; set; }

        public virtual AvionBO RegistracijaNavigation { get; set; } = null!;
    }
}
