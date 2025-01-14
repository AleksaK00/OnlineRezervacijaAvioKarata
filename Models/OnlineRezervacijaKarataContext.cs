using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace OnlineRezervacijaAvioKarata.Models;

public partial class OnlineRezervacijaKarataContext : DbContext
{
    public OnlineRezervacijaKarataContext()
    {
    }

    public OnlineRezervacijaKarataContext(DbContextOptions<OnlineRezervacijaKarataContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Aerodrom> Aerodroms { get; set; }

    public virtual DbSet<AvioKompanija> AvioKompanijas { get; set; }

    public virtual DbSet<Avion> Avions { get; set; }

    public virtual DbSet<InstancaLetum> InstancaLeta { get; set; }

    public virtual DbSet<Korisnik> Korisniks { get; set; }

    public virtual DbSet<Let> Lets { get; set; }

    public virtual DbSet<Nalog> Nalogs { get; set; }

    public virtual DbSet<Promocija> Promocijas { get; set; }

    public virtual DbSet<Rezervacija> Rezervacijas { get; set; }

    public virtual DbSet<Sediste> Sedistes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=DESKTOP-SRD2J1L;Initial Catalog=online_rezervacija_karata;Integrated Security=true;Encrypt=true;TrustServerCertificate=true");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Aerodrom>(entity =>
        {
            entity.HasKey(e => e.IcaoKodAerodroma).HasName("Aerodrom_pk");

            entity.ToTable("Aerodrom");

            entity.Property(e => e.IcaoKodAerodroma)
                .HasMaxLength(6)
                .HasColumnName("ICAO_Kod_Aerodroma");
            entity.Property(e => e.Drzava).HasMaxLength(60);
            entity.Property(e => e.Grad).HasMaxLength(60);
            entity.Property(e => e.Ime).HasMaxLength(120);
        });

        modelBuilder.Entity<AvioKompanija>(entity =>
        {
            entity.HasKey(e => e.IcaoKod).HasName("Avio_kompanija_pk");

            entity.ToTable("Avio_kompanija");

            entity.Property(e => e.IcaoKod)
                .HasMaxLength(6)
                .HasColumnName("ICAO_Kod");
            entity.Property(e => e.DrzavaPorekla)
                .HasMaxLength(40)
                .HasColumnName("Drzava_Porekla");
            entity.Property(e => e.Ime).HasMaxLength(60);
        });

        modelBuilder.Entity<Avion>(entity =>
        {
            entity.HasKey(e => e.Registracija).HasName("table_name_pk");

            entity.ToTable("Avion");

            entity.Property(e => e.Registracija).HasMaxLength(20);
            entity.Property(e => e.IcaoKod)
                .HasMaxLength(6)
                .HasColumnName("ICAO_Kod");
            entity.Property(e => e.Model).HasMaxLength(60);
            entity.Property(e => e.Proizvodjac).HasMaxLength(100);

            entity.HasOne(d => d.IcaoKodNavigation).WithMany(p => p.Avions)
                .HasForeignKey(d => d.IcaoKod)
                .HasConstraintName("Avion_Avio_kompanija_ICAO_Kod_fk");
        });

        modelBuilder.Entity<InstancaLetum>(entity =>
        {
            entity.HasKey(e => new { e.DatumPolaska, e.IcaoKod, e.BrLeta }).HasName("Instanca_Leta_pk");

            entity.ToTable("Instanca_Leta");

            entity.Property(e => e.DatumPolaska).HasColumnName("Datum_Polaska");
            entity.Property(e => e.IcaoKod)
                .HasMaxLength(6)
                .HasColumnName("ICAO_Kod");
            entity.Property(e => e.BrLeta)
                .HasMaxLength(20)
                .HasColumnName("Br_Leta");
            entity.Property(e => e.BenefitiBiznis).HasColumnName("Benefiti_Biznis");
            entity.Property(e => e.BenefitiEkonomija).HasColumnName("Benefiti_Ekonomija");
            entity.Property(e => e.BenefitiPremiumEkonomija).HasColumnName("Benefiti_Premium_Ekonomija");
            entity.Property(e => e.CenaBiznis).HasColumnName("Cena_Biznis");
            entity.Property(e => e.CenaEkonomija).HasColumnName("Cena_Ekonomija");
            entity.Property(e => e.CenaPremiumEkonomija).HasColumnName("Cena_Premium_Ekonomija");
            entity.Property(e => e.Registracija).HasMaxLength(20);

            entity.HasOne(d => d.RegistracijaNavigation).WithMany(p => p.InstancaLeta)
                .HasForeignKey(d => d.Registracija)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Instanca_Leta_Avion_Registracija_fk");

            entity.HasOne(d => d.Let).WithMany(p => p.InstancaLeta)
                .HasForeignKey(d => new { d.IcaoKod, d.BrLeta })
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Instanca_Leta_Let_ICAO_Kod_Br_Leta_fk");
        });

        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.HasKey(e => e.IdKorisnika).HasName("Korisnik_pk");

            entity.ToTable("Korisnik");

            entity.HasIndex(e => e.Email, "Korisnik_Email_uindex").IsUnique();

            entity.HasIndex(e => e.KorisnickoIme, "Korisnik_Korisnicko_Ime_uindex").IsUnique();

            entity.Property(e => e.IdKorisnika).HasColumnName("ID_Korisnika");
            entity.Property(e => e.Adresa).HasMaxLength(100);
            entity.Property(e => e.Email).HasMaxLength(40);
            entity.Property(e => e.Ime).HasMaxLength(30);
            entity.Property(e => e.IsDeleted).HasColumnName("Is_Deleted");
            entity.Property(e => e.KorisnickoIme)
                .HasMaxLength(30)
                .HasColumnName("Korisnicko_Ime");
            entity.Property(e => e.PasswordResetTimestamp)
                .HasColumnType("datetime")
                .HasColumnName("Password_Reset_Timestamp");
            entity.Property(e => e.PasswordResetToken)
                .HasMaxLength(100)
                .HasColumnName("Password_Reset_Token");
            entity.Property(e => e.Prezime).HasMaxLength(30);
            entity.Property(e => e.Sifra).HasMaxLength(100);
        });

        modelBuilder.Entity<Let>(entity =>
        {
            entity.HasKey(e => new { e.IcaoKod, e.BrLeta }).HasName("Let_pk");

            entity.ToTable("Let");

            entity.Property(e => e.IcaoKod)
                .HasMaxLength(6)
                .HasColumnName("ICAO_Kod");
            entity.Property(e => e.BrLeta)
                .HasMaxLength(20)
                .HasColumnName("Br_Leta");
            entity.Property(e => e.DolazniAerodrom)
                .HasMaxLength(6)
                .HasColumnName("Dolazni_Aerodrom");
            entity.Property(e => e.PolazniAerodrom)
                .HasMaxLength(6)
                .HasColumnName("Polazni_Aerodrom");
            entity.Property(e => e.VremePolaska).HasColumnName("Vreme_Polaska");

            entity.HasOne(d => d.DolazniAerodromNavigation).WithMany(p => p.LetDolazniAerodromNavigations)
                .HasForeignKey(d => d.DolazniAerodrom)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Let_Aerodrom_ICAO_Kod_Aerodroma_fk_2");

            entity.HasOne(d => d.IcaoKodNavigation).WithMany(p => p.Lets)
                .HasForeignKey(d => d.IcaoKod)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Let_Avio_kompanija_ICAO_Kod_fk");

            entity.HasOne(d => d.PolazniAerodromNavigation).WithMany(p => p.LetPolazniAerodromNavigations)
                .HasForeignKey(d => d.PolazniAerodrom)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Let_Aerodrom_ICAO_Kod_Aerodroma_fk");
        });

        modelBuilder.Entity<Nalog>(entity =>
        {
            entity.HasKey(e => e.IdNaloga).HasName("Nalog_pk");

            entity.ToTable("Nalog");

            entity.Property(e => e.IdNaloga).HasColumnName("ID_Naloga");
            entity.Property(e => e.BrLeta)
                .HasMaxLength(20)
                .HasColumnName("Br_Leta");
            entity.Property(e => e.DatumPolaska).HasColumnName("Datum_Polaska");
            entity.Property(e => e.IcaoKod)
                .HasMaxLength(6)
                .HasColumnName("ICAO_Kod");
            entity.Property(e => e.IdKorisnika).HasColumnName("ID_Korisnika");

            entity.HasOne(d => d.Rezervacija).WithMany(p => p.Nalogs)
                .HasForeignKey(d => new { d.DatumPolaska, d.BrLeta, d.IcaoKod, d.IdKorisnika })
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Nalog_Rezervacija_Datum_Polaska_Br_Leta_ICAO_Kod_ID_Korisnika_fk");
        });

        modelBuilder.Entity<Promocija>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("Promocija_pk");

            entity.ToTable("Promocija");

            entity.HasIndex(e => e.AktivanSlot, "Promocija_Aktivan_Slot_uindex").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.AktivanSlot).HasColumnName("Aktivan_Slot");
            entity.Property(e => e.Destinacija).HasMaxLength(40);
            entity.Property(e => e.Tekst).IsUnicode(false);
        });

        modelBuilder.Entity<Rezervacija>(entity =>
        {
            entity.HasKey(e => new { e.DatumPolaska, e.BrLeta, e.IcaoKod, e.IdKorisnika }).HasName("Rezervacija_pk");

            entity.ToTable("Rezervacija");

            entity.Property(e => e.DatumPolaska).HasColumnName("Datum_Polaska");
            entity.Property(e => e.BrLeta)
                .HasMaxLength(20)
                .HasColumnName("Br_Leta");
            entity.Property(e => e.IcaoKod)
                .HasMaxLength(6)
                .HasColumnName("ICAO_Kod");
            entity.Property(e => e.IdKorisnika).HasColumnName("ID_Korisnika");
            entity.Property(e => e.Adresa).HasMaxLength(100);
            entity.Property(e => e.BrKarata).HasColumnName("Br_Karata");
            entity.Property(e => e.Ime).HasMaxLength(40);
            entity.Property(e => e.Klasa).HasMaxLength(40);
            entity.Property(e => e.Prezime).HasMaxLength(40);

            entity.HasOne(d => d.IdKorisnikaNavigation).WithMany(p => p.Rezervacijas)
                .HasForeignKey(d => d.IdKorisnika)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Rezervacija_Korisnik_ID_Korisnika_fk");

            entity.HasOne(d => d.InstancaLetum).WithMany(p => p.Rezervacijas)
                .HasForeignKey(d => new { d.DatumPolaska, d.IcaoKod, d.BrLeta })
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Rezervacija_Instanca_Leta_Datum_Polaska_ICAO_Kod_Br_Leta_fk");

            entity.HasMany(d => d.Sedistes).WithMany(p => p.Rezervacijas)
                .UsingEntity<Dictionary<string, object>>(
                    "RezervisanaSedistum",
                    r => r.HasOne<Sediste>().WithMany()
                        .HasForeignKey("BrSedista", "Registracija")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("Rezervisana_Sedista_Sediste_Br_Sedista_Registracija_fk"),
                    l => l.HasOne<Rezervacija>().WithMany()
                        .HasForeignKey("DatumPolaska", "BrLeta", "IcaoKod", "IdKorisnika")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("Rezervisana_Sedista_Rezervacija_Datum_Polaska_Br_Leta_ICAO_Kod_ID_Korisnika_fk"),
                    j =>
                    {
                        j.HasKey("DatumPolaska", "BrLeta", "IcaoKod", "IdKorisnika", "BrSedista", "Registracija").HasName("Rezervisana_Sedista_pk");
                        j.ToTable("Rezervisana_Sedista");
                        j.IndexerProperty<DateOnly>("DatumPolaska").HasColumnName("Datum_Polaska");
                        j.IndexerProperty<string>("BrLeta")
                            .HasMaxLength(20)
                            .HasColumnName("Br_Leta");
                        j.IndexerProperty<string>("IcaoKod")
                            .HasMaxLength(6)
                            .HasColumnName("ICAO_Kod");
                        j.IndexerProperty<int>("IdKorisnika").HasColumnName("ID_Korisnika");
                        j.IndexerProperty<string>("BrSedista")
                            .HasMaxLength(4)
                            .HasColumnName("Br_Sedista");
                        j.IndexerProperty<string>("Registracija").HasMaxLength(20);
                    });
        });

        modelBuilder.Entity<Sediste>(entity =>
        {
            entity.HasKey(e => new { e.BrSedista, e.Registracija }).HasName("Sediste_pk");

            entity.ToTable("Sediste");

            entity.Property(e => e.BrSedista)
                .HasMaxLength(4)
                .HasColumnName("Br_Sedista");
            entity.Property(e => e.Registracija).HasMaxLength(20);
            entity.Property(e => e.Klasa).HasMaxLength(30);

            entity.HasOne(d => d.RegistracijaNavigation).WithMany(p => p.Sedistes)
                .HasForeignKey(d => d.Registracija)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Sediste_Avion_Registracija_fk");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
