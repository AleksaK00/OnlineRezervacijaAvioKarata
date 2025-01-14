//Pretrazuje svaku karticu rezultata pretrage i sakriva je ukoliko se ne podudara sa nekim od izabranih filtera
function Filter()
{
    //Preuzimanje izabranih vrednosti svih filtera
    const izabranaAvioKompanija = document.getElementById("filterAvioKompanije").value;
    const izabraniPolazniAerodrom = document.getElementById("filterPolazniAerodrom").value;
    const izabraniDolazniAerodrom = document.getElementById("filterDolazniAerodrom").value;
    const izabranaCena = document.getElementById("filterCena").value;

    //prolazak kroz sve kartice rezultata, koje imaju klasu .resultcard
    document.querySelectorAll('.resultcard').forEach(resultCard =>
         { 
            const avioKompanijaRezultat = resultCard.getAttribute("data-AvioKompanija");
            const polazniAerodromRezultat = resultCard.getAttribute("data-PolazniAerodrom");
            const dolazniAerodromRezultat = resultCard.getAttribute("data-DolazniAerodrom");
            const cenaRezultat = resultCard.getAttribute("data-Cena");
            let podudaraFilterima = true;

            //Provera podudaranja sa filterima, defualt vrednosti filtera su "" i u tom slucaju kartica se ispisuje
            if (izabranaAvioKompanija != "" && izabranaAvioKompanija != avioKompanijaRezultat)
            {
                podudaraFilterima = false;
            }
            if (izabraniPolazniAerodrom != "" && izabraniPolazniAerodrom != polazniAerodromRezultat)
            {
                podudaraFilterima = false;
            }
            if (izabraniDolazniAerodrom != "" && izabraniDolazniAerodrom != dolazniAerodromRezultat)
            {
                podudaraFilterima = false;
            }
            if (cenaRezultat > izabranaCena)
            {
                podudaraFilterima = false;
            }

            //Sakrivanje kartice u slucaju ne podudaranja, vracanje vidljivosti u slucaju podudaranja
            if (podudaraFilterima)
            {
                resultCard.style.display = 'block';
            }
            else
            {
                resultCard.style.display = 'none';
            }
         })
}

//Ispisivanje vrednosti slider filtera
function SliderIspis()
{
    const izabranaCena = document.getElementById("filterCena").value;
    document.getElementById("labelaFilterCena").innerHTML = "Cena do: " + izabranaCena + "&#8364";
}

function ResetujFiltere()
{
    document.getElementById("filterAvioKompanije").value = "";
    document.getElementById("filterPolazniAerodrom").value = "";
    document.getElementById("filterDolazniAerodrom").value = "";
    document.getElementById("filterCena").value = document.getElementById("filterCena").getAttribute("max");
}