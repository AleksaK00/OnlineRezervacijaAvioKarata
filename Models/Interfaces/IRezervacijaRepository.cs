namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IRezervacijaRepository
    {
        IEnumerable<SedisteBO> GetUnreservedSeatsForFlight(string brLeta, DateOnly datumPolaska);
    }
}
