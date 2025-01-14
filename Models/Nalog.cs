using System;
using System.Collections.Generic;

namespace OnlineRezervacijaAvioKarata.Models;

public partial class Nalog
{
    public int IdNaloga { get; set; }

    public DateOnly DatumPolaska { get; set; }

    public string IcaoKod { get; set; } = null!;

    public string BrLeta { get; set; } = null!;

    public int IdKorisnika { get; set; }

    public double Iznos { get; set; }

    public virtual Rezervacija Rezervacija { get; set; } = null!;
}
