//Funkcija koja hidden inpute iz prosledjene forme u promo karuseli upisuje u polja za pretragu i pritiska dugme za pretragu
function PretragaPromo(forma)
{
    document.forms["formaPretraga"]["polazniAerodrom"].value = document.forms[forma]["polazniAerodrom"].value;
    document.forms["formaPretraga"]["dolazniAerodrom"].value = document.forms[forma]["dolazniAerodrom"].value;
    document.forms["formaPretraga"]["pretraga"].click();
}