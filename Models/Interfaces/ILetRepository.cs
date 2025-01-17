namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface ILetRepository
    {
        IEnumerable<LetBO> GetByAirports(string polazniAerodrom, string dolazniAerodrom);
        LetBO? GetByFlightNumber(string brLeta);
    }
}
