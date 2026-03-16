#### Addressing

Voor het uitwisselen van gegevens tussen zorgorganisaties die niet vooraf bekend bij elkaar zijn, moet het mogelijk zijn
om adresgegevens in het zorgnetwerk te ontdekken. Adresgegevens zijn gegevens die de topologie van een organisatie
omschrijven en de verschillende manieren waarop een organisatie bereikbaar is. Dit kunnen zowel fysieke, digitale of
logische entiteiten zijn.

Voor alle toepassingen is het beginpunt het vinden van de juiste endpoints bijvoorbeeld voor het aanvragen van een
access token of het toesturen van een taak. In de Nuts community wordt daarvoor een zogenaamde discovery service
gebruikt. Helaas is dat protocol niet compatible met de aankomende landelijke generieke functie adressering welke
gebruik maakt van een centraal register, het LRZA, voor het publiceren van alle adresgegevens in de zorg in Nederland.

Om de transitie naar de landelijk generieke functie zo klein mogelijk te maken, stellen we voor te werken met een
centraal register in de vorm van een FHIR4 resource server welke voldoet aan het datamodel omschreven in de [door VWS
opgestelde specificaties](https://minvws.github.io/generiekefuncties-docs/care-services.html#entities).

Toegang tot het register wordt verleend op basis van mTLS op basis van een PKI overheid certificaat.

#### Synchronisatie

Deelnemers worden verwacht alle adresgegevens te synchroniseren naar een lokale query directory zoals omschreven
in de specificatie van het ministerie. Het (tijdelijk en uiteindelijke) landelijke centrale register hebben daarom
slechts
beperkte query capabilities. Deze capabilities zijn vastgelegd in FHIR capability statements.

Voor de implementatie van het synchronisatie-process aan de deelnemer kant kan gebruik worden gemaakt van een van de
open source implementaties beschikbaar uit het pilottraject landelijke generieke functies zoals bijvoorbeeld [de update
client in het Nuts Knooppunt](https://github.com/nuts-foundation/nuts-knooppunt/blob/main/docs/DEPLOYMENT.md#addressing).

#### Beheer adresgegevens

Voor het beheer van adresgegevens kan er worden geschreven naar het centrale adresboek. Het centrale adresboek draagt
er zorg voor dat inkomende gegevens worden gevalideerd zodat er geen oneigenlijk adresgegevens kunnen worden gepubliceerd.

#### Roadmap

Alternatief: statische data set tot dat het werkelijk LRZA er is?

- GF addressing is coming
- National implementation starts end 2026
- Linkie naar vws IG pagina adressering
