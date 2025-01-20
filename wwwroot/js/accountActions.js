function RezervacijaZaBrisanje(brLeta, datumPolaska)
{
    document.getElementById('otkazi').href = '/Account/OtkaziRezervaciju/' + brLeta + '/' + datumPolaska; 
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