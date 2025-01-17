namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IInstancaLetaRepository
    {
        IEnumerable<InstancaLetaBO> GetFutureByFlightNumber(string brLeta);
        InstancaLetaBO? GetExactInstance(string brLeta, DateOnly datumPolaska);
        float? minimalnaCena(string ICAOkod);
    }
}
