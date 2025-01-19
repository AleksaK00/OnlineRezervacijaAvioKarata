namespace OnlineRezervacijaAvioKarata.Models
{
    public class UserFriendlyRezervacija
    {
        public RezervacijaBO Rezervacija { get; set; }
        public int IDkorisnika { get; set; }
        public TimeOnly VremePolaska { get; set; }
        public string ImeKompanije { get; set; }
        public string PolazniAerodrom { get; set; }
        public string DolazniAerodrom { get; set; }
        public double Iznos { get; set; }
        public TimeSpan DanaDO { get; set; }

    }
}
