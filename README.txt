Programmeerimiskeeles Prolog loodud käsurea lauamäng: Unblock me

Tööga tutvumiseks avage swipl-is fail "main.pl" ja käivitage see fail käsuga "main.".
Seejärel järgida seal esitatavaid juhiseid.

*************************************************
*Projekt täidab täielikult järgnevaid tingimusi.*
*************************************************
1) Laud loetakse failist.
2) Lubatakse ka suuremaid/väiksemaid laudu. Eeldatakse, et laud on ristküliku kujuline.
3) Programmi kasutaja saab ise mängida --- nihutada plokke kuni võiduseisundini.
4) Programm on kasutajasõbralik ja trükib piisavalt palju õpetust, et iga mängu 
reegleid tundev tudeng suudab seda ilma eksperimenteerimata kasutada.
----------------------------------------------------------------------------------------------
***********************************************
*Projekt täidab osaliselt järgnevat tingimust:*
(Automaatlahendajast pani kirja idee, mis toimib lihtsatel juhtudel)
***********************************************
5) Programmi kasutaja saab lasta arvutil otsida parimat lahendust --- mis leidmisel kuvatakse.
6) Lahendusalgoritm peab olema piisavalt kiire: näidislaud peab saama lahendatud kiiremini kui 1 minut.
*Selgitus: Programm suudab ainult kuni kahesammulisi probleeme lahendada. Lahendatud saab
projektikausta kaasa pandud laud3.txt ja laud4.txt. Teiste näidislaudade puhul, trükitakse välja 
esimese sammu võimalused koos tekstiga "vaja veel otsida" ja lõpetatakse töö.
Funktsiooni intelliSearch() lõppu rekursiivselt mingi väljakutse tegemine aitaks seda automaatlahendajat 
paremaks teha (mistahes tasemete arvu jaoks).
