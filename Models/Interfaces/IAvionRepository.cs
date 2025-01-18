namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IAvionRepository
    {
        AvionBO? getByRegistration(string registracija);
    }
}
