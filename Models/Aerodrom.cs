using System;
using System.Collections.Generic;

namespace OnlineRezervacijaAvioKarata.Models;

public partial class Aerodrom
{
    public string IcaoKodAerodroma { get; set; } = null!;

    public string? Grad { get; set; }

    public string? Ime { get; set; }

    public string? Drzava { get; set; }

    public virtual ICollection<Let> LetDolazniAerodromNavigations { get; set; } = new List<Let>();

    public virtual ICollection<Let> LetPolazniAerodromNavigations { get; set; } = new List<Let>();
}
