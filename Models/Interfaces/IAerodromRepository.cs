namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IAerodromRepository
    {
        IEnumerable<AerodromBO> GetByCity(string grad);
    }
}
