function RezervacijaZaBrisanje(brLeta, datumPolaska, IDkorisnika)
{
    document.getElementById('otkazi').href = '/reservation/' + brLeta + '/' + datumPolaska + '/' + IDkorisnika + '/cancel'; 
}

//Za prikazivanje i sakrivanje osnovnih informacija
function PrikaziIzmeneOsnovnih()
{
    document.getElementById('izmenaOsnovnih').style.display = 'inherit';
}
function SakrijIzmeneOsnovnih()
{
    document.getElementById('izmenaOsnovnih').style.display = 'none';
}

//Za prikazivanje i sakrivanje licnih informacija
function PrikaziIzmeneLicnih()
{
    document.getElementById('izmenaLicnih').style.display = 'inherit';
}
function SakrijIzmeneLicnih()
{
    document.getElementById('izmenaLicnih').style.display = 'none';
}