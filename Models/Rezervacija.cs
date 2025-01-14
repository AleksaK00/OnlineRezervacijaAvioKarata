using System;
using System.Collections.Generic;

namespace OnlineRezervacijaAvioKarata.Models;

public partial class Rezervacija
{
    public DateOnly DatumPolaska { get; set; }

    public string BrLeta { get; set; } = null!;

    public string IcaoKod { get; set; } = null!;

    public int IdKorisnika { get; set; }

    public int BrKarata { get; set; }

    public string Klasa { get; set; } = null!;

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public byte? Otkazana { get; set; }

    public string Adresa { get; set; } = null!;

    public virtual Korisnik IdKorisnikaNavigation { get; set; } = null!;

    public virtual InstancaLetum InstancaLetum { get; set; } = null!;

    public virtual ICollection<Nalog> Nalogs { get; set; } = new List<Nalog>();

    public virtual ICollection<Sediste> Sedistes { get; set; } = new List<Sediste>();
}
