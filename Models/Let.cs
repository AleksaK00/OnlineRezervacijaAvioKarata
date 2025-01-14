using System;
using System.Collections.Generic;

namespace OnlineRezervacijaAvioKarata.Models;

public partial class Let
{
    public string BrLeta { get; set; } = null!;

    public string IcaoKod { get; set; } = null!;

    public string PolazniAerodrom { get; set; } = null!;

    public string DolazniAerodrom { get; set; } = null!;

    public TimeOnly VremePolaska { get; set; }

    public virtual Aerodrom DolazniAerodromNavigation { get; set; } = null!;

    public virtual AvioKompanija IcaoKodNavigation { get; set; } = null!;

    public virtual ICollection<InstancaLetum> InstancaLeta { get; set; } = new List<InstancaLetum>();

    public virtual Aerodrom PolazniAerodromNavigation { get; set; } = null!;
}
