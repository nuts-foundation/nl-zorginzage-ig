### Inleiding

Deze implementatiegids Zorginzage bevat de generieke afspraken en specificaties die nodig zijn voor use cases die gebruikmaken van de [communicatiepatronen](https://www.datavoorgezondheid.nl/documenten/2025/07/14/whitepaper-communicatiepatronen-vws) 'Gericht bevragen' en 'Geïndexeerd bevragen'. Het doel van deze implementatiegids is het versnellen van de realisatie van use cases. Deze implementatiegids draagt hieraan bij door het hergebruik van afspraken en specificaties te vereenvoudigen.

### Procesbeschrijving

Met deze bolt ondersteunen we het proces van Zorginzage. Dat proces bestaat enerzijds uit het vindbaar (findable), toegankelijk (accesible), interoperabel (interoperable) en herbruikbaar (reusable) maken (FAIR) van dossiergegevens door een datahouder en anderzijds uit het daadwerkelijk inzien van dossiergegevens door een datagebruiker. Door Zorginzage zijn zorgverleners in staat het voor hen relevante deel van het zorgtraject van de betrokkene te volgen dat zich bij andere zorgaanbieders afspeelt.

Voorbeelden:
- Een thuiszorgdossier dat wordt bijgehouden door de thuiszorgorganisatie en wordt ingezien door de huisarts. Observaties en metingen worden verricht door verplegend en verzorgend personeel van de thuiszorgorganisatie en deze kunnen specifiek en gericht worden ingezien door de betrokken huisarts.
- De integrale geboortezorg waarbij verschillende zorgaanbieders (eerstelijns verloskundepraktijken, ziekenhuizen, echoscopiepraktijken, kraamzorgorganisaties, jeugdgezondheidszorgorganisaties) in onderlinge samenwerking de juiste zorg voor de betrokkene en diens omgeving leveren. Alle betrokken zorgverleners dienen (wanneer dat voor hen relevant is en wanneer daarvoor een grondslag is) inzage te hebben in de observaties, metingen en andere zorggegevens die zijn geregistreerd door personeel van andere betrokken zorgaanbieders.
- Het opvragen van de Basisgegevensset Zorg (BgZ) binnen de medisch-specialistische zorg . Zorgverleners dienen (wanneer dat voor hen relevant is en wanneer daarvoor een grondslag is) inzage te hebben in de Basisgegevensset Zorg die is geregistreerd door een eerdere behandelaar.
- Het actueel medicatieoverzicht (AMO). Zorgverleners dienen (wanneer dat voor hen relevant is en wanneer daarvoor een grondslag is) inzage te hebben in de medicatie-informatie die is ingevoerd door andere zorgaanbieders.

### Principes

1. Deze specificatie heeft als scope het door een datagebruiker inzien van data die bij andere zorgorganisaties is opgeslagen en het hiervoor benodigde door een datahouder beschikbaar stellen van data aan andere zorgorganisaties.
2. Deze specificatie bevat alleen afhankelijkheden van afspraken, specificaties en systemen die beschikbaar zijn in productie-omgevingen.
3. Deze specificatie ontwikkelt incrementeel en iteratief door. 
4. Deze specificatie adopteert incrementeel en iteratief de door het Ministerie van VWS beheerde landelijke afspraken en specificaties voor generieke functies en de andere elementen van de doelarchitectuur voor het Gezondheidsinformatiestelsel (GIS). Deze landelijke afspraken en specificaties vervangen incrementeel en iteratief alle Zorginzage-specifieke afspraken en specificaties zodra de eigenaar en de deelnemers van de Zorginzage-specificatie beoordelen dat deze implementatieklaar zijn.
5. Van deze specificatie zullen maximaal twee release per jaar uitkomen die invloed hebben op de functionaliteit.
6. Wederkerigheid. Deelnemers aan Zorginzage stellen alleen data beschikbaar aan partijen die ook conform deze specificatie data beschikbaar stellen. 
7. Commitment. De Zorginzage-specificatie wordt de komende jaren doorontwikkeld. Deelnemers committeren zich aan de implementatie van volgende versies. 

### Use cases

Deze specificatie vormt de basis voor een aantal verschillende use cases.

Use case | Specificatie | Opmerking
---------|-------------|----------
360-graden cliëntbeeld | n.t.b. | De specificatie van deze use case maakt gebruik van Zorginzage 2026
Geboortezorg | [link](https://babyconnect.atlassian.net/wiki/spaces/VBC/pages/906166273/Zorgtoepassingprofiel+Geboortezorg)  | De specificatie van deze use case maakt nog geen gebruik van Zorginzage 2026
Huisartsinzage | [link](https://wiki.nuts.nl/books/samenwerken-huisarts-en-thuiszorg/page/zorgtoepassing-ha-vvt-inzage-dossier-v10) | De specificatie van deze use case maakt nog geen gebruik van Zorginzage 2026
PZP | [link](https://wiki.nuts.nl/books/pzp) | De specificatie van deze use case maakt nog geen gebruik van Zorginzage 2026

### Wederkerigheid

Deelnemers aan Zorginzage stellen alleen data beschikbaar aan partijen die ook conform deze specificatie data beschikbaar stellen. Om dit te bereiken dienen deelnemers aan Zorginzage naast de rol datagebruiker (data user) ook de rol datahouder (data holder) te implementeren.

### Commitment

De Zorginzage-specificatie wordt de komende jaren doorontwikkeld. Deelnemers aan Zorginzage committeren zich aan de tijdige implementatie van de versies die in 2026, 2027 en 2028 zullen worden gepubliceerd.

### Rollen en verantwoordelijkheden

#### Eigenaar van de specificatie

- opstellen en publiceren releases van de specificatie
- in samenwerking met deelnemers bepalen inhoud en planning releases 
- informeren deelnemers en andere stakeholders over inhoud en planning releases
- vaststellen inhoud en planning releases
- faciliteren van tests van de specificaties
- uitdragen van de specificatie
- vergroten adoptie van de specificatie 

#### Deelnemer

- technische implementatie van de specificatie
- leveren input voor inhoud en planning releases

#### Eigenaar Discovery Service

- verzorgen productiewaardige Discovery Service

### Rollen en uitvoerders

Rol | Uitvoerder
----|--------
Eigenaar van de specificatie | ActiZ
Deelnemer | XIS-leverancier
Eigenaar Discovery Service | ActiZ

### Roadmap

Voor de doorontwikkeling van deze Zorginzage-specificatie wordt de volgende roadmap gehanteerd. 

Release Zorginzage-specificatie | juni 2026 (versie 1.x) | najaar 2026 | voorjaar 2027                            | najaar 2027
-----|------|------|------------------------------------------|------
adressering | Zorginzage-specifiek | generieke functie adressering (trial-use) | generieke functie adressering | generieke functie adressering
lokalisatie | geen onderdeel van Zorginzage-specificatie | generieke functie lokalisatie (trial-use) | generieke functie lokalisatie            | generieke functie lokalisatie 
authenticatie van organisaties | Zorginzage-specifiek | Zorginzage-specifiek | generieke functie adressering (trial-use)                     | generieke functie authenticatie
toestemming | Zorginzage-specifiek | Zorginzage-specifiek | generieke functie toestemming (trial-use) | generieke functie toestemming
authenticatie van personen | Zorginzage-specifiek | Zorginzage-specifiek | dezi                                     | dezi
autorisatie | Zorginzage-specifiek | Zorginzage-specifiek | generieke functie adressering (trial-use)                     | generieke functie autorisatie
netwerkbeveiliging | Zorginzage-specifiek | landelijke specificaties Veilig Netwerk (trial-use) | landelijke specificaties Veilig Netwerk | landelijke specificaties Veilig Netwerk

De roadmap wordt bepaald op basis van input van de egenaar en de deelnemers van de Zorginzage-specificatie. De roadmap is afhankelijk van externe factoren waarop de eigenaar en de deelnemers van de Zorginzage-specificatie slechts in beperkte mate invloed hebben. De roadmap kan per release van de Zorginzage-specficatie worden aangepast.

### Releasebeleid

De Zorginzage-specificatie zal zich de komende jaren doorontwikkelen. Ontwikkelingen binnen en rondom Zorginzage, zoals de ontwikkelingen aangaande generieke functies en de doelarchitectuur voor het Gezondheidsinformatiestelsel (GIS), kunnen aanleiding geven om afspraken en specificaties te wijzigen. De eigenaar van de specificatie spant zich ervoor in om te borgen dat ontwikkelingen zo goed mogelijk worden verwerkt in de Zorginzage-specificatie door middel van het uitbrengen van nieuwe releases.

#### Releasecriteria

Releases van de specificatie worden als volgt aangeduid:

- Major: Wijzigingen die invloed hebben op de functionaliteit en niet backwards compatible zijn.
- Minor: Wijzigingen die invloed hebben op de functionaliteit en backwards compatible zijn.
- Patch: Wijzigingen die geen invloed hebben op de functionaliteit en backwards compatible zijn.

#### Releasefrequentie

- De eigenaar van de specificatie publiceert maximaal tweemaal (2) per jaar een nieuwe release met impact voor de
  Deelnemers (major of minor release) volgens een vooraf aangekondigde planning.
- De eigenaar van de specificatie kan op ieder moment patch releases uitbrengen als dat nodig is, zoals voor het
  herstellen van fouten.

#### Geldigheid

De actuele release is altijd geldig. Voor de voorlaatste release (ook wel n-1 release genoemd) geldt:

- Na een **major release** blijft de n-1 release nog zes (6) maanden na publicatie van de
  actuele release geldig. Deelnemers gebruiken deze periode om over te stappen. Na afloop is
  de n-1 release niet langer geldig.
- Na een **minor release** is de n-1 release per definitie compatibel met de actuele release.
  Deelnemers kunnen op n-1 blijven en dienen uiterlijk bij de eerstvolgende major release te
  zijn overgestapt.
- Een **patch release** verandert de geldigheidstermijn van n-1 niet.

Deelnemers die op een release ouder dan n-1 zitten, voldoen niet aan de specificatie. De eigenaar van de specificatie kan in overleg met deelnemers afwijkende afspraken maken wanneer een specifieke major release aantoonbaar meer migratietijd vraagt.

#### Pilot en definitieve elementen

Een release kan twee soorten elementen bevatten:

- **Definitieve elementen**: afspraken en specificaties die productiewaardig zijn vastgesteld
  en die zonder voorbehoud door deelnemers worden geïmplementeerd.
- **Pilot-elementen**: nieuwe of gewijzigde afspraken en specificaties die zijn opgenomen om
  in productie te beproeven, maar nog niet definitief zijn vastgesteld.

Voor pilot-elementen geldt:

- Pilot-elementen zijn als zodanig herkenbaar in de specificatie via een expliciete
  status-aanduiding bij het betreffende element. Het betreft de aanduiding 'trial-use'.
- Pilot-elementen mogen door deelnemers in productie worden geïmplementeerd; daarmee dragen
  zij bij aan de beproeving.
- Een pilot-element wordt in een volgende release definitief gemaakt wanneer er ten minste
  één succesvolle productie-implementatie is en de eigenaar van de specificatie en de
  deelnemers geen blokkerende bezwaren meer hebben.
- Een pilot-element kan op basis van bevindingen uit de pilot worden gewijzigd of
  ingetrokken. Wijzigingen aan een pilot-element gelden niet als breaking change voor de
  versienummering van de specificatie als geheel.

#### Versiebeheer

De eigenaar van de specificatie hanteert de Semantic Versioning-specificatie voor het versiebeheer,
zie https://semver.org. Dit betekent dat het versienummer wordt weergegeven door 3 nummers die met een punt zijn
gescheiden (x.y.z waarbij x de majorrelease is, y de minor en z de patch).

#### Besluitvorming

De eigenaar van de specificatie besluit na overleg met de deelnemers aan Zorginzage over het vaststellen van een nieuwe release en over de ‘Release roadmap’ met de onderwerpen voor een eerstvolgende release.

