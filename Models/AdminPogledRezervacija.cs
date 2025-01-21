namespace OnlineRezervacijaAvioKarata.Models
{
    public class AdminPogledRezervacija
    {
        public RezervacijaBO Rezervacija { get; set; }
        public string KorisnickoIme { get; set; }
        public TimeSpan DanaDO { get; set; }
    }
}
