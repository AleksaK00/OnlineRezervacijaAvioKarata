using System;
using System.Collections.Generic;

namespace OnlineRezervacijaAvioKarata.Models;

public partial class Avion
{
    public string Registracija { get; set; } = null!;

    public string? IcaoKod { get; set; }

    public string? Proizvodjac { get; set; }

    public string Model { get; set; } = null!;

    public virtual AvioKompanija? IcaoKodNavigation { get; set; }

    public virtual ICollection<InstancaLetum> InstancaLeta { get; set; } = new List<InstancaLetum>();

    public virtual ICollection<Sediste> Sedistes { get; set; } = new List<Sediste>();
}
