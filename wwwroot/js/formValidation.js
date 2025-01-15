//Dodavanje event listenera za focusout jer VS code ne prepoznaje "onfocusout" u html-u
document.getElementById("lozinkaPolje").addEventListener("blur", ObrisiObavestenje.bind(null, "kvalitetSifre"));
document.getElementById("lozinkaPotvrdaPolje").addEventListener("blur", ObrisiObavestenje.bind(null, "potvrdaSifre"));

// Uporedjuje da li se dva inputa iz registracije za sifru poklapaju
function UporediSifru()
{
    let sifra = document.forms["registrationForm"]["password"].value;
    let potvrdaSifre = document.forms["registrationForm"]["password_confirm"].value;
    const parentDiv = document.getElementById("lozinkaPotvrdaDiv");

    //Brise obavestenje o podudaranju u slucaju da je polje za potvrdu sifre prazno
    if (potvrdaSifre == "")
    {
        if (parentDiv.contains(document.getElementById("potvrdaSifre")))
        {
            ObrisiObavestenje("potvrdaSifre");
        }     
    }
    else
    {
        //kreira div za obavestenje ispod inputa kad korisnik krene da kuca
        if (potvrdaSifre != "" && !parentDiv.contains(document.getElementById("potvrdaSifre")))
        {        
            let obavestenje = '<div class="text-bg-danger text-center p-2 rounded-4" id="potvrdaSifre"></div>';
            parentDiv.insertAdjacentHTML("beforeend", obavestenje);
        }

        //ispisivanje poruke i promena pozadinske boje diva u zavisnosti od podudaranja sifre
        if (sifra != potvrdaSifre)
        {
            document.getElementById("potvrdaSifre").innerHTML = "Lozinke se ne poklapaju";
            document.getElementById("potvrdaSifre").className = "text-bg-danger text-center p-2 rounded-4";
        }
        else
        {
            document.getElementById("potvrdaSifre").innerHTML = "Lozinke se poklapaju";
            document.getElementById("potvrdaSifre").className = "text-bg-success text-center p-2 rounded-4";
        }
    }
}

//Brisanje elementa sa prosledjenim tagom
function ObrisiObavestenje(id)
{
    if (document.getElementById(id))
    {
        document.getElementById(id).remove();
    }
}

//Obavestava korisnika o jacini sifre (Uslov 8 karaktera, veliko slovo i broj za jaku)
function KvalitetSifre()
{
    let sifra = document.forms["registrationForm"]["password"].value;
    const parentDiv = document.getElementById("lozinkaDiv");

    //Brise obavestenje o kvalitetu sifre u slucaju da je polje prazno
    if (sifra == "")
    {
        if (parentDiv.contains(document.getElementById("kvalitetSifre")))
        {
            ObrisiObavestenje("kvalitetSifre");
        }           
    }
    else
    {
        //Kreiranje obavestenja kad korisnik krene da kuca, u slucaju da vec ne postoji
        if (sifra != "" && !parentDiv.contains(document.getElementById("kvalitetSifre")))
        {        
            let obavestenje = '<div class="text-bg-danger text-center p-2 rounded-4" id="kvalitetSifre"></div>';
            parentDiv.insertAdjacentHTML("beforeend", obavestenje);
        }

        //Ispisivanje poruke i promena boje diva u zavisnosti da li sifra ispunjava uslove
        if (sifra.length < 8 || sifra == sifra.toLowerCase() || !/\d/.test(sifra))
        {
            document.getElementById("kvalitetSifre").innerHTML = "Lozinka mora da ima bar 8 karaktera, veliko slovo i broj";
            document.getElementById("kvalitetSifre").className = "text-bg-danger text-center p-2 rounded-4";
        }
        else
        {
            document.getElementById("kvalitetSifre").innerHTML = "Lozinka je jaka";
            document.getElementById("kvalitetSifre").className = "text-bg-success text-center p-2 rounded-4";
        }
    }
}