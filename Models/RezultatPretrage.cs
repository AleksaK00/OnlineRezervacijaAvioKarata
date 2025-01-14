namespace OnlineRezervacijaAvioKarata.Models
{
    //Klasa koja sadrzi sve rezultate pretrage i informacije potrebne za filtere
    public class RezultatPretrage
    {
        public List<PojedinacniRezultat> RezultatiPretrage { get; set; }
        public List<AerodromBO> PolazniAerodromi { get; set; }
        public List<AerodromBO> DolazniAerodromi { get; set; }
        public List<AvioKompanijaBO> AvioKompanije { get; set; }
        public float? MinCena { get; set; }
        public float? MaxCena { get; set; }

        public RezultatPretrage()
        {
            RezultatiPretrage = new List<PojedinacniRezultat>();
            PolazniAerodromi = new List<AerodromBO>();
            DolazniAerodromi = new List<AerodromBO>();
            AvioKompanije = new List<AvioKompanijaBO>();
        }
    }
}
