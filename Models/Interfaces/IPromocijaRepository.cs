namespace OnlineRezervacijaAvioKarata.Models.Interfaces
{
    public interface IPromocijaRepository
    {
        IEnumerable<PromocijaBO> GetAll();
        IEnumerable<PromocijaBO> GetActive();
        PromocijaBO? GetById(int id);
        void Add(PromocijaBO promocija);
        void Delete(PromocijaBO promocijaBO);
        bool CheckIfExists(string destinacija);
        void ChangeActivePromos(int promo1, int promo2, int promo3);
    }
}
