﻿using System;
using System.Collections.Generic;

namespace OnlineRezervacijaAvioKarata.Models;

//scaffolding mi je preveo instanca_leta u InstantaLetum, koristicu tako kako je uz napomenu
public partial class InstancaLetum
{
    public DateOnly DatumPolaska { get; set; }

    public string BrLeta { get; set; } = null!;

    public string IcaoKod { get; set; } = null!;

    public string Registracija { get; set; } = null!;

    public double? CenaEkonomija { get; set; }

    public double? CenaPremiumEkonomija { get; set; }

    public double? CenaBiznis { get; set; }

    public string? BenefitiEkonomija { get; set; }

    public string? BenefitiPremiumEkonomija { get; set; }

    public string? BenefitiBiznis { get; set; }

    public virtual Let Let { get; set; } = null!;

    public virtual Avion RegistracijaNavigation { get; set; } = null!;

    public virtual ICollection<Rezervacija> Rezervacijas { get; set; } = new List<Rezervacija>();
}
