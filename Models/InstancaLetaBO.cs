namespace OnlineRezervacijaAvioKarata.Models
{
    public class InstancaLetaBO
    {
        public DateOnly DatumPolaska { get; set; }

        public string BrLeta { get; set; } = null!;

        public string IcaoKod { get; set; } = null!;

        public string Registracija { get; set; } = null!;

        public double? CenaEkonomija { get; set; }

        public double? CenaPremiumEkonomija { get; set; }

        public double? CenaBiznis { get; set; }

        public string? BenefitiEkonomija { get; set; }

        public string? BenefitiPremiumEkonomija { get; set; }

        public string? BenefitiBiznis { get; set; }

        public virtual LetBO Let { get; set; } = null!;

        public virtual AvionBO RegistracijaNavigation { get; set; } = null!;
    }
}
