namespace OnlineRezervacijaAvioKarata.Models
{
    public class NalogBO
    {
        public int IdNaloga { get; set; }

        public DateOnly DatumPolaska { get; set; }

        public string IcaoKod { get; set; } = null!;

        public string BrLeta { get; set; } = null!;

        public int IdKorisnika { get; set; }

        public double Iznos { get; set; }

        public virtual RezervacijaBO Rezervacija { get; set; } = null!;
    }
}
