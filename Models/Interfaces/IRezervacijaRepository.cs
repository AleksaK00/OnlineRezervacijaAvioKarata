namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IRezervacijaRepository
    {
        IEnumerable<SedisteBO> GetUnreservedSeatsForFlight(string brLeta, DateOnly datumPolaska);
        RezervacijaBO? GetReservation(string brLeta, DateOnly datumPolaska, int IDkorisnika);
        IEnumerable<RezervacijaBO> getReservationsByUserID(int IDkorisnika);
        void Add(RezervacijaBO rezervacijaBO);
        void ReserveSeats(List<string> sedista, string registracija, RezervacijaBO rezervacijaBO);
        void CancelReservation(RezervacijaBO rezervacijaBO);
    }
}
