using System;
using System.Collections.Generic;

namespace OnlineRezervacijaAvioKarata.Models;

public partial class AvioKompanija
{
    public string IcaoKod { get; set; } = null!;

    public string Ime { get; set; } = null!;

    public string DrzavaPorekla { get; set; } = null!;

    public virtual ICollection<Avion> Avions { get; set; } = new List<Avion>();

    public virtual ICollection<Let> Lets { get; set; } = new List<Let>();
}
