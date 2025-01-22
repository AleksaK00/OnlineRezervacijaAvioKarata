//Metoda za popunjavanje modala u slucaju klika na opciju ugasi
function KorisnikZaGasenje(ID)
{
    document.getElementById('dugmeModal').href = '/Admin/UgasiNalog/' + ID;
    document.getElementById('dugmeModal').innerHTML = 'Ugasi';
    document.getElementById('dugmeModal').className = 'btn btn-danger';
}

//Metoda za popunjavanje modala u slucaju klika na opciju ugasi
function KorisnikZaBrisanje(ID)
{
    document.getElementById('dugmeModal').href = '/Admin/ObrisiNalog/' + ID;
    document.getElementById('dugmeModal').innerHTML = 'Obriši';
    document.getElementById('dugmeModal').className = 'btn btn-danger';
}

//Metoda za popunjavanje modala u slucaju klika na opciju vrati
function KorisnikZaVracanje(ID)
{
    document.getElementById('dugmeModal').href = '/Admin/VratiNalog/' + ID;
    document.getElementById('dugmeModal').innerHTML = 'Vrati';
    document.getElementById('dugmeModal').className = 'btn btn-success';
}

//Metoda za prikazivanje forme za izmenu korisnickog imena
function PrikaziIzmenu(ID)
{
    document.getElementById('korisnickoIme' + ID).style.display = "none";
    document.getElementById('poljeNovoKorisnickoIme' + ID).style.display = "inline";
}

//Metoda za sakrivanje forme za izmenu korisnickog imena
function OtkaziIzmenu(ID)
{
    document.getElementById('korisnickoIme' + ID).style.display = "inline";
    document.getElementById('poljeNovoKorisnickoIme' + ID).style.display = "none";
}

//Metoda za popunjavanje modala u slucaju klika na opciju otkazi
function RezervacijaZaBrisanje(brLeta, datumPolaska, IDkorisnika)
{
    document.getElementById('otkazi').href = '/Admin/OtkaziRezervaciju/' + brLeta + '/' + datumPolaska + '/' + IDkorisnika; 
}

//Metoda za popunjavanje modala u slucaju klika na opciju obrisi promociju
function PromocijaZaBrisanje(ID)
{
    document.getElementById('dugmeModal').href = '/Admin/ObrisiPromociju/' + ID;
    document.getElementById('dugmeModal').innerHTML = 'Obriši';
    document.getElementById('dugmeModal').className = 'btn btn-danger';
}