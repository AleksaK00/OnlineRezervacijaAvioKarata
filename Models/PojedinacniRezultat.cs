using System.ComponentModel.DataAnnotations;

namespace OnlineRezervacijaAvioKarata.Models
{

    //Klasa koja sadrzi sve potrebne podatke jednog rezultata pretrage
    public class PojedinacniRezultat
    {
        public AvioKompanijaBO? AvioKompanija {  get; set; }
        public LetBO? Let {  get; set; }
        public AerodromBO? PolazniAerodrom { get; set; }
        public AerodromBO? DolazniAeordrom { get; set; }
        public float CenaOd { get; set; }

    }
}
