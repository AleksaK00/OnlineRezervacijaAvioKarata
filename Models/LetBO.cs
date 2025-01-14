namespace OnlineRezervacijaAvioKarata.Models
{
    public class LetBO
    {
        public string BrLeta { get; set; } = null!;

        public string IcaoKod { get; set; } = null!;

        public string PolazniAerodrom { get; set; } = null!;

        public string DolazniAerodrom { get; set; } = null!;

        public TimeOnly VremePolaska { get; set; }

        public virtual Aerodrom DolazniAerodromNavigation { get; set; } = null!;

        public virtual AvioKompanija IcaoKodNavigation { get; set; } = null!;

        public virtual Aerodrom PolazniAerodromNavigation { get; set; } = null!;
    }
}
