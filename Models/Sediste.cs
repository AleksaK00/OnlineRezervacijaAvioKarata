using System;
using System.Collections.Generic;

namespace OnlineRezervacijaAvioKarata.Models;

public partial class Sediste
{
    public string BrSedista { get; set; } = null!;

    public string Registracija { get; set; } = null!;

    public string Klasa { get; set; } = null!;

    public double? Doplata { get; set; }

    public virtual Avion RegistracijaNavigation { get; set; } = null!;

    public virtual ICollection<Rezervacija> Rezervacijas { get; set; } = new List<Rezervacija>();
}
