namespace OnlineRezervacijaAvioKarata.Models
{
    public class PromocijaBO
    {
        public int Id {  get; set; }
        public string? Destinacija {  get; set; }
        public string? Tekst {  get; set; }
        public int? AktivanSlot { get; set; }
    }
}
