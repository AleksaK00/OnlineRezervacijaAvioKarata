//Ispisuje cenu prilikom ucitavanje stranice, korisno kod reloada koji zadrzava vrednost inputa
addEventListener('load', IzracunajCenu);
addEventListener('load', PrikaziRezervacijuSedista);
addEventListener('load', IzracunajDoplatu);

//Ispisije ukupnu cenu na osnovu izabranog broja karata
function IzracunajCenu()
{
    let brojKarata = document.getElementById('brojKarata').value;
    let cenaKarte = document.getElementById('odabir').getAttribute('data-Cena');

    //formater cene u evre, Srbija ima isti lokal kao Nemacka
    let formaterCene = new Intl.NumberFormat('de-DE', {
        style: 'currency',
        currency: 'EUR',
    });

    document.getElementById('ispisCene').innerHTML = "Cena: " + formaterCene.format(brojKarata * cenaKarte);
}

//Prikazuje onoliko select polja za odabir sedista koliko je izabrano karata
function PrikaziRezervacijuSedista() {
    let brojKarata = document.getElementById('brojKarata').value;

    for(i = 1; i <= 5; i++)
    {
        if(i <= brojKarata)
        {
            document.getElementById('sediste' + i + 'div').style.display = 'flex';
        }
        else
        {
            document.getElementById('sediste' + i + 'div').style.display = 'none';
            document.getElementById('sediste' + i).value = "";
            OnemoguciDupliOdabir();
        }
    }

    IzracunajDoplatu();
}

//Sakriva iz selectova vec izabrana sedista
function OnemoguciDupliOdabir()
{
    let selektovanaSedista = [];
    let brojSedista = document.getElementById('sediste1').options.length;

    //Ubacuje sva selektovana sedista u niz
    for (let i = 1; i <= 5; i++)
    {
        let trenutniSelect = document.getElementById('sediste' + i);
        if (trenutniSelect.value != "")
        {
            selektovanaSedista.push(trenutniSelect.value);
        }
    }

    //Sakriva svaku opciju koja je selektovana u bilo kojem selektu osim trenutnog
    for (let i = 1; i <= 5; i++)
    {
        let trenutniSelect = document.getElementById('sediste' + i); 

        for (let j = 0; j < brojSedista; j++)
        {
            if (selektovanaSedista.includes(trenutniSelect.options[j].value) && trenutniSelect.value != trenutniSelect.options[j].value)
            {
                trenutniSelect.options[j].style.display = 'none';
            }
            else
            {
                trenutniSelect.options[j].style.display = '';
            }
        }
    }
}

//Izracunava i ispisuje doplatu za sedista
function IzracunajDoplatu()
{
    let brojKarata = document.getElementById('brojKarata').value;
    let doplata = 0;

    for(i = 1; i <= brojKarata; i++)
    {
        let trenutniSelect = document.getElementById('sediste' + i);
        let selektovanoSediste = trenutniSelect.options[trenutniSelect.selectedIndex];

        doplata += parseFloat(selektovanoSediste.getAttribute('data-Doplata'));
    }

    //formater cene u evre, Srbija ima isti lokal kao Nemacka
    let formaterCene = new Intl.NumberFormat('de-DE', {
        style: 'currency',
        currency: 'EUR',
    });

    document.getElementById('cenaDoplate').value = doplata;
    document.getElementById('doplataSedista').innerHTML = 'Doplata za sedišta: ' + formaterCene.format(doplata);
}