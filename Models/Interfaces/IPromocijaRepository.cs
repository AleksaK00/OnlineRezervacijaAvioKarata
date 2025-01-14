namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IPromocijaRepository
    {
        IEnumerable<PromocijaBO> GetAll();
        IEnumerable<PromocijaBO> GetActive();

        void Add(PromocijaBO promocija);
        void Delete(PromocijaBO promocija);
    }
}
