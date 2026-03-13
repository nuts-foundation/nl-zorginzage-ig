#### Exchange patterns: pull and indexed pull JORRIT

The exchange pattern is indexed pull. In short this means that fetching data globally consists of two steps: Localization: Localising the data holders (via one or more indices) and then Data request: actually reuqesting the data at each known data holder.

#### General JORRIT

- Nuts v6
- FHIR API

#### Identifcation JORRIT

Business identifiers of healtcare organizations, healthcare professionals
- lokaal medewerker id, later Dezi id

Non identifying attributes:

Healthcare organizations: 
 - HealthcareProviderRoleType (self-issued) (as a credential or not)

Professionals:
- Role?

#### Authentication JORRIT

Orgs

Persons: healthcare professional, 
NutsEmployeeCredential

Standaard Nuts processen voor token requests, jwt meesturen met data request, introspectie.

X509CredentialTool: De Nuts community biedt op dit moment 2 tools aan om een X509Credential te genereren:
Een Java library
Een Go tool en docker image

"
Het is van belang het organisatie type mee te geven bij de registratie op de Discovery Service, zodat onderscheid gemaakt kan worden tussen een VVT-instelling en een huisarts. Hiervoor wordt het HL7 organisation type Codelijst gebruikt: https://zibs.nl/wiki/Zorgaanbieder-v3.4(2020NL)#OrganisatieTypeCodelijst

Voor deze usecase gelden er 2 types die gebruikt kunnen worden:

Huisartsinstelling: H1
Verplegings- of verzorgingsinstelling X3
Voor de technische uitwerking van het registeren maken we gebruik van de in het generieke functies traject gedefinieerde ZorgaanbiederType-credential. Die wordt straks uitgegeven door Vzvz maar zolang dat nog niet zo ver is wordt dat self-issued toegepast. HealthcareProviderRoleTypeCredential wordt geformaliseerd in de Generieke Functies IG, de definitie is daar te vinden: https://build.fhir.org/ig/nuts-foundation/nl-generic-functions-ig/credential-catalog.html
"

#### Localization DIRK

Options:

- trial and error/ bsn broadcasting
  - can be narrowed by disco service
- do not broadcast bsn's but pseudo-bsn's --> TO DO DIRK
  - OPRF: https://en.wikipedia.org/wiki/Oblivious_pseudorandom_function
  - Wanneer is het productie-ready
- NVI
  - pilot ready NVI avaiable in spring 2026

Make localization unnecessary
- Use CareTeam/ CareTeams as index
  - Every helathcare organization
  - Patient
  - Regional party/ solution (Digizorg)

- "Bij gebrek aan een generieke lokalisatiedienst wordt lokalisatie lokaal ingevuld. Dit houdt in dat er in de systemen zelf bijgehouden wordt waar data opgehaald kan worden. Bijvoorbeeld door de VVT instelling waar de patient bij in behandeling is expliciet vast te leggen in het HIS. Of in geval van inzicht in het huisartsendossier door de betreffende huisarts vast te leggen in het ECD bij het dossier."

#### Addressing DIRK

Standaard Nuts proces: Nuts Discovery Service
- Discovery Service Presentation Definition:
  - URA
  - use case identifier
  - fhir base url
  - oauth url
- Voorstel: Actiz host dat ding
OF:
Actiz host een fake-LRZa
- voordeel: voorbereiding op komst GF adressering

Roadmap:
- GF addressing is coming
- National implementation starts end 2026
- Linkie naar vws IG pagina adressering

#### Authorization DIRK

- PBAC
- policies can differ per use case
- use authorizatoin data model of Knooppunt
- specific Toepassingen-on-Nuts use Rego to express policies
- the followiung rules will always need to be checked by data holder:
  - information (ura) of requesting organization is mandatory
  - for access to patient identifying data, information of logged in healthcare professional is mandatory
  - check on patient consent (local and/or mitz/otv)
  - check request against capability statements
  - patient context is mandatory
    - Patient-match/search on bsn
    - Following requests on patient-id --> only requests that are directly linkable to patients are allowed (using includes, revincludes etc)
  - check on active treatment relation, optionally in context of specific use case

#### Consent JORRIT

Local and/or Mitz

Local: FHIR-profile?
Mitz: link to GF specs gesloten vraag


#### Security JORRIT
mTLS
production: PKIoverheid certs of vendors
Tekstje hiervandaan hacken: https://wiki.nuts.nl/books/generic-technical-agreements-generieke-bouwblokken/page/authenticating-vendor-organisations
