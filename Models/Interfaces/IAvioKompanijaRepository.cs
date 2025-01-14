namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IAvioKompanijaRepository
    {
        AvioKompanijaBO GetByICAOkod(string ICAOkod);
    }
}
