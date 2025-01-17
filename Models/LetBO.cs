namespace OnlineRezervacijaAvioKarata.Models
{
    public class LetBO
    {
        public string BrLeta { get; set; } = null!;

        public string IcaoKod { get; set; } = null!;

        public string PolazniAerodrom { get; set; } = null!;

        public string DolazniAerodrom { get; set; } = null!;

        public TimeOnly VremePolaska { get; set; }

        public virtual AerodromBO DolazniAerodromNavigation { get; set; } = null!;

        public virtual AvioKompanijaBO IcaoKodNavigation { get; set; } = null!;

        public virtual AerodromBO PolazniAerodromNavigation { get; set; } = null!;
    }
}
