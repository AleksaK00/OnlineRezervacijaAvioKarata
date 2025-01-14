using System;
using System.Collections.Generic;

namespace OnlineRezervacijaAvioKarata.Models;

public partial class Promocija
{
    public int Id { get; set; }

    public string Destinacija { get; set; } = null!;

    public string Tekst { get; set; } = null!;

    public int? AktivanSlot { get; set; }
}
