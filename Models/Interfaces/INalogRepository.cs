namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface INalogRepository
    {
        void Add(NalogBO nalogBO);
        NalogBO? GetForReservation(RezervacijaBO rezervacijaBO);
    }
}
