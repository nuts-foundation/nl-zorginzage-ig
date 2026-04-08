### Inleiding

Deze implementatiegids Zorginzage bevat de generieke afspraken en specificaties die nodig zijn voor use cases die gebruikmaken van de [communicatiepatronen](https://www.datavoorgezondheid.nl/documenten/2025/07/14/whitepaper-communicatiepatronen-vws) 'Gericht bevragen' en 'Geïndexeerd bevragen'. Het doel van deze implementatiegids is het versnellen van de realisatie van use cases. Deze implementatiegids draagt hieraan bij door het hergebruik van afspraken en specifcaties te vereenvoudigen.

### Procesbeschrijving

Met deze bolt ondersteunen we het proces van Zorginzage. Dat proces bestaat enerzijds uit het interoperabel, toegankelijk, vindbaar en herbruikbaar (FAIR) maken van dossiergegevens door een bronhouder ('publiceren') en anderzijds uit het daadwerkelijk inzien van dossiergegevens door een afnemer ('raadplegen'). Door Zorginzage zijn zorgverleners in staat het voor hen relevante deel van het zorgtraject van de betrokkene te volgen dat zich bij andere zorgaanbieders afspeelt.

Voorbeelden:
- Een thuiszorgdossier dat wordt bijgehouden door de thuiszorgorganisatie en wordt ingezien door de huisarts. Observaties en metingen worden verricht door verplegend en verzorgend personeel van de thuiszorgorganisatie en deze kunnen specifiek en gericht worden ingezien door de betrokken huisarts.
- De integrale geboortezorg waarbij verschillende zorgaanbieders (eerstelijns verloskundepraktijken, ziekenhuizen, echoscopiepraktijken, kraamzorgorganisaties, jeugdgezondheidszorgorganisaties) in onderlinge samenwerking de juiste zorg voor de betrokkene en diens omgeving leveren. Alle betrokken zorgverleners dienen (wanneer dat voor hen relevant is en wanneer daarvoor een grondslag is) inzage te hebben in de observaties, metingen en andere zorggegevens die zijn geregistreerd door personeel van andere betrokken zorgaanbieders.
- Het opvragen van de Basisgegevensset Zorg (BgZ) binnen de medisch-specialistische zorg . Zorgverleners dienen (wanneer dat voor hen relevant is en wanneer daarvoor een grondslag is) inzage te hebben in de Basisgegevensset Zorg die is geregistreerd door een eerdere behandelaar.
- Het actueel medicatieoverzicht (AMO). Zorgverleners dienen (wanneer dat voor hen relevant is en wanneer daarvoor een grondslag is) inzage te hebben in de medicatie-informatie die is ingevoerd door andere zorgaanbieders.

### Principes

1. Deze specificatie heeft als scope het door een datagebruiker inzien van data die bij andere zorgorganisaties is opgeslagen en het hiervoor benodigde door een datahouder beschikbaar stellen van data aan andere zorgorganisaties.
2. Deze specificatie bevat alleen afhankelijkheden van afspraken, specifcaties en systemen die beschikbaar zijn in productie-omgevingen.
3. Deze specificatie ontwikkelt incrementeel en iterarief door. 
4. Deze specificatie adopteert incrementeel en iterarief de door het Ministerie van VWS beheerde landelijke afspraken en specifcaties voor generieke functies. Deze landelijke afspraken en specificaties vervangen incremenenteel en iteratief alle zorginzage-specifieke afspraken en specificaties.
5. Van deze specificatie zullen maximaal twee release per jaar uitkomen die invloed hebben op de functionaliteit.

### Use cases

Deze specificatie vormt de basis voor een aantal verschillende use cases.

Use case | Specficatie | Opmerking
---------|-------------|----------
360-graden cliëntbeeld | n.t.b. | De specficatie van deze use case maakt gebruik van Zorginzage 2026
Geboortezorg | [link](https://babyconnect.atlassian.net/wiki/spaces/VBC/pages/906166273/Zorgtoepassingprofiel+Geboortezorg)  | De specficatie van deze use case maakt nog geen gebruik van Zorginzage 2026
Huisartsinzage | [link](https://wiki.nuts.nl/books/samenwerken-huisarts-en-thuiszorg/page/zorgtoepassing-ha-vvt-inzage-dossier-v10) | De specficatie van deze use case maakt nog geen gebruik van Zorginzage 2026
PZP | [link](https://wiki.nuts.nl/books/pzp) | De specficatie van deze use case maakt nog geen gebruik van Zorginzage 2026

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

- technische implementatie van de specifcatie
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

Release zorginzage-specificatie | juni 2026 | najaar 2026 | voorjaar 2027 | najaar 2027
-----|------|------|------|------
adressering | zorginzage-specifiek | generieke functie adressering | generieke functie adressering | generieke functie adressering
lokalisatie | zorginzage-specifiek | generieke functie lokalisatie | generieke functie lokalisatie | generieke functie lokalisatie 
authenticatie van organisaties | zorginzage-specifiek | zorginzage-specifiek | generieke functie authenticatie | generieke functie authenticatie
authenticatie van personen | zorginzage-specifiek | zorginzage-specifiek | dezi | dezi
autorisatie | zorginzage-specifiek | zorginzage-specifiek | zorginzage-specifiek | generieke functie autorisatie 

### Releasebeleid

De zorginzage-specificatie zal zich de komende jaren doorontwikkelen. Ontwikkelingen binnen en rondom zorginzage, zoals de ontwikkelingen aangaande generieke functies, kunnen aanleiding geven om afspraken en specificaties te wijzigen. De eigenaar van de specificatie spant zich ervoor in om te borgen dat ontwikkelingen zo goed mogelijk worden verwerkt in de zorginzage-specificatie door middel van het uitbrengen van nieuwe releases. 

#### Releasecriteria

Releases voor de specficatie worden als volgt aangeduid:
- Major: Wijzigingen die invloed hebben op de functionaliteit en niet backwards compatible zijn.
- Minor: Wijzigingen die invloed hebben op de functionaliteit en backwards compatible zijn.
- Patch: Wijzigingen die geen invloed hebben op de functionaliteit en backwards compatible zijn.

#### Releasefrequentie

- De eigenaar van de specificatie publiceert maximaal tweemaal (2) per jaar een nieuwe release met impact voor de Deelnemers (major of minor release) volgens een vooraf aangekondigde planning.
- De eigenaar van de specificatie kan op ieder moment patch releases uitbrengen als dat nodig is, zoals voor het herstellen van fouten.

#### Geldigheid

De actuele release is geldig. Daarnaast is de voorlaatste release (ook wel n-1 genoemd) tot 3 maanden na publicatie van de actuele release geldig. Dit betekent dat deelnemers aan zorginzage vanaf het moment van publicatie maximaal drie (3) maanden de tijd hebben om de actuele release te implementeren.

#### Versiebeheer

De eigenaar van de specificatie hanteert de Semantic Versioning-specificatie voor het versiebeheer, zie https://semver.org. Dit betekent dat het versienummer wordt weergegeven door 3 nummers die met een punt zijn gescheiden (x.y.z waarbij x de majorrelease is, y de minor en z de patch).

#### Besluitvorming

De eigenaar van de specificatie besluit na overleg met de deelnemers aan zorginzage over het vaststellen van een nieuwe release en over de ‘Release roadmap’ met de onderwerpen voor een eerstvolgende release.