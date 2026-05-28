### Exchange patterns: pull and indexed pull

This specification describes data exchanges that use the exchange pattern "pull" or the exchange pattern "indexed pull".
See https://www.datavoorgezondheid.nl/documenten/2025/07/14/whitepaper-communicatiepatronen-vws.

In short this means that fetching data globally consists of the following steps:

1. Addressing: The data user finds the addresses of the FHIR- and OAuth-endpoints of each (possible) data holder.
2. Authentication: The data user authenticates (organisation and person level)
3. Localisation: The data user finds the data holders that have data about a patient (in a specific context)
    1. Patient search request: The data user performs a patient search at each possible data holder, using bsn as
       parameter.
    2. Patient search reponse: When the data user has data about the requested patient, it returns the internal
       technical identifier of the requested patient.
4. Data request: The data user performs data requests at each possible data holder, using the technical identifier of
   the requested patient as parameter.
5. Authorisation: The data holder authorizes the incoming data request.
    1. Check consent: As part of the authorization process the data holder can check the presence of patient consent,
       locally or at Mitz.

### Principles

This specification uses the following principles:

- This specification makes use of did:web and verifiable credentials (commonly referred to as "Nuts v6")
- This specification makes use of FHIR API's

### Identification

#### Healthcare organisations

##### Identifier: URA

Healthcare organisations are identified using URA-number (UZI-Register Abonneenummer).

Rationale

- Identification of healthcare organisations by URA conforms to the national information model for health orgnizations (
  Zorginformatiebouwsteen Zorgaanbieder: https://zibs.nl/wiki/Zorgaanbieder-v3.6(2024NL))
- The URA-number is issued by a public organization (CIBG)
- The URA-number is cryptographically verifiable because it is contained in a PKI-certificate (UZI-servercertificaat,
  CPS: https://www.uziregister.nl/over-het-register/certificeringsbeleid/archief-certification-practice-statement)

##### HealthcareProviderRoleType

Healthcare organisations use a HealthcareProviderRoleType attribute to express which type(s) of healthcare organisations
they are.

Rationale

- In indexed pull scenarios, OTV-consents (online toestemmingsvoorziening, Mitz) are relevant. The use of OTV-consents
  requires uniform communication of the type of healthcare organisation of both data user organisation and data holder
  organisation.
- The type of healthcare organisation is a useful attribute in authorisation and localisation processes.
- The HealthcareProviderRoleType is self-issued by each healthcare organisation. No trusted third party issuer is active
  at the moment.

#### Vendor organisations

##### No identifier

Vendor organisations are not identified by a business identifier.
The parapraph Network Security descibes mTLS-based client and server authentication.

#### healthcare professionals

##### Identifier: local employee identifier

- Healthcare professionals are identified using a local employee identifier.
- Local employee name and local employee role are used as non-identifying attributes.

Rationale

- All professionals have a local employee number
- A national healthcare professional identifier is not yet available for all professionals
- A national healthcare professional role is not yet available for all professionals

### Authentication

#### Healthcare organisations

##### X509credential

The URA number of health organizations is authenticated using a X509credential based on a UZI-servercertificate.

Rationale

- UZI-servercertificate is issued by a public organization (CIBG)
  URA-number is contained as attribute in the UZI-servercertificaat,
  CPS: https://www.uziregister.nl/over-het-register/certificeringsbeleid/archief-certification-practice-statement
- The URA-number can securely be contained in a X509credential using the open source software did:x509 and
  X509Credential Toolkit

##### HealthcareProviderRoleTypeCredential

The HealthcareProviderRoleType attribute will be authenticated using a self issued HealthcareProviderRoleTypeCredential.

Rationale

- No trusted third party issuer is active at the moment.

##### Standard Nuts processes

The standard did:web-based Nuts-processes for access token requests and introspects, and jwt-based data requests are
used. The exact specifications and sequences are described in volume 2b.

#### Vendor organisations

The parapraph Network Security descibes mTLS-based client and server authentication.

#### Healthcare professionals

The identity of healthcare professionals is federated from data user organisation to data holder organisatin using a
NutsEmployeeCredential.

Rationale

- A nation-wide solution for cross-organizational authentication (e.g. Dezi) is not in place.
- NutsEmployeeCredential can be used now and is not dependent of other (national) initiatives

### Addressing

#### Function

To exchange data between healthcare organisations that are not previously known to each other, it must be possible to
discover addressing information within the network. Address information is data that describe an organisation's topology
and the various ways an organisation can be reached. These can be physical, digital, or logical
entities.

Practically addressing is used to register and find the FHIR base URL and authorisation server URL of data holders
during a data exchange. All other described functions depend on this addressing information.

#### Preconditions

- The data holder organisation has a UZI server certificate and the URA contained in it.
- The data holder operates a Nuts node that has registered with the Nuts Discovery Service hosted by Actiz, presenting:
    - an **X509Credential** carrying the URA presented as `organization_ura` (per Nuts RFC023);
    - a self-issued **HealthcareProviderRoleTypeCredential** stating its organisation type(s);
    - a **DiscoveryRegistrationCredential** carrying the `fhir_base_url` and `authorization_server_url` of the data
      holder.
- The data user operates a Nuts node configured to consume the same discovery service and use case.

#### Actors & responsibilities

- **Discovery service operator (Actiz)** — hosts a single shared Nuts Discovery Service for all use cases built on
  Zorginzage.
- **Data holder** — registers its endpoints and credentials, and keeps the registration current.
- **Data user** — queries the discovery service for the targeted data holder.
- **Nuts node (both sides)** — performs registration, presentation verification, and credential exchange on behalf of
  the organisation it serves.

#### Interaction

See the pull sequence diagram, step 3 (`GET /internal/discovery/v1/{serviceID}`) and the accompanying note: the data
user's Nuts node returns the matching organisations and their addressing information. Searches can be performed by
organisation URA, organisation type, and use case; the exact filtering strategy is left to the implementer (return
everything for the user to pick, or filter on URA / role type inside the Nuts node).

Registration is covered in a separate sequence diagram outside the common request flow
`sequence-diagram-disco.plantuml`.

#### Conformance

- The presentation definition for the discovery service **MUST** require the following fields:
    - `authorization_server_url`
    - `fhir_base_url`
    - `organization_facility_type`
    - `organization_ura`
- Data holders **MUST** publish the above fields during registration.
- Data holders **MUST** present a valid X509Credential derived from a UZI server certificate and a self-issued
  HealthcareProviderRoleTypeCredential at registration.
- Data users **SHOULD** resolve endpoints through the discovery service rather than hard-coding them.
- Data users **MAY NOT** use discovery service for localization or BSN broadcasting

#### References

- [Nuts Discovery Service — overview](https://wiki.nuts.nl/books/designing-a-nuts-use-case/page/service-discovery)
- [Nuts RFC023 — X509Credential with UZI server certificates](https://wiki.nuts.nl/books/x509credential/page/uzi-server-certificates-with-rfc023)
- [go-didx509-toolkit](https://github.com/nuts-foundation/go-didx509-toolkit/tree/main) · [Java library](https://github.com/nuts-foundation/uzi-did-x509-issuer-java/)
- [Nuts Service Discovery — DiscoveryRegistrationCredential](https://wiki.nuts.nl/books/designing-a-nuts-use-case/page/service-discovery#bkmrk-require-registration)

### Localisation

Localisation is the process of finding out which organisations have data on a patient.

The generic function localisation is not yet available in production environments. This specification uses bsn
broadcasting using the Nuts Discovery Service for indexed pull scenarios. This means that organisations that implement
this specification perform bsn broadcasting and accept incoming bsn-based patient searches and matches.

This method is the only viable way to localise without external dependencies, however it requires an appropriate legal
basis to be in place.

In practice the BSN broadcast is realised by searching for a patient record with an identifier.

```http request
POST /fhir/Patient/_search
Content-Type: application/x-www-form-urlencoded

identifier = http://fhir.nl/fhir/NamingSystem/bsn|618359710 &
_elements = id
```

- Requestor must pre-filter resources servers that the BSN is broadcasted to by use case and organisation type during
  addressing
- Requestor must provide the `_elements` & `identifier=` query parameters when searching the patient
- Data holder must only return patient ID's when there is data available for the specific use case

The aim is to replace localisation in the next version of this spec with either pseudonym broadcasting or the GF
localisation. **Always make sure to check the legal basis before broadcasting any BSN's.**

### Authorisation

For authorization, we prefer a fine-grained policy based access model over a role based model. Whether a requestor gets
access to the data they are requesting depends on whether they pass the access-polices of the source (bronhouder).

To ensure everyone uses the same rulesets express policies in a domain specific language called Rego. The input for
evaluating the policies is commonly agreed upon information model. A similar model has been described in the proposal
for the generic function authorization.

See also: https://nuts-foundation.github.io/nl-generic-functions-ig/authorization.html

Note: Implementors are free to choose to not implement a Rego-interpreter as part of their authorization solution, as
long as the implemented authorization solution follows the exact same rules as specified in the Rego-policy-file.

For policy evaluation the PDP functionality in the Nuts Knooppunt can be integrated with any policy enforcement point.
Policies are version controlled in a Git repository controlled by the Nuts Foundation.

Policy are selected based on the use case scope provided by the Nuts node as part of the authentication process. A
single name is used that connects the scope, Nuts policy and authentication policy.

The following guidelines should be taken into account when designing new policies.

- ura identifier of requesting organization is mandatory
- when the request is for FHIR endpoint, evaluate conformance to a capability statement
- patient context is mandatory for accessing patient data
    - for search interactions either a patient id or patient bsn must be possible to derive from the query
    - for read interactions the requested resource should have a direct link to a patient (for example through a patient
      field)
- For data requests that require explicit consent, patient consent must be checked in a local system or in Mitz before
  returning the data
- check on active treatment relation, optionally in context of specific use case

For data requests in which explicit consent is not checked, one of the following is mandatory:

- The treatment relation of the data user organisation with the patient is checked technically by the data holder
  organisation (e.g. using a PatientEnrollmentCredential). This treatment relation can be scoped to a
  specific context (e.g. a use case).
- A legal basis has been created in which explicit consent is not necessary. This is not be checked technically.

The treatment relation of the data holder organisation with the patient may be checked technically by the data holder
organisation.

### Consent

#### Function

Consent (toestemming) verification is part of the authorisation decision. As a legal basis for releasing data, the data
holder may check that valid patient consent is present for the requested exchange. Consent may be explicit or implicit.
See also Authorisation.

#### Preconditions

- Authentication has completed, so the URA of the data user organisation, its organisation type and the use case scope
  are available (see Authentication).
- Patient context (BSN) is available from the incoming FHIR query or other patient context.
- When OTV-consent is used, the data holder has access to an online toestemmingsvoorziening (e.g. Mitz).

#### Actors & responsibilities

- **Data holder** — decides whether to use explicit consent, implicit consent and/or another legal basis when authorising an incoming
  data request; when using explicit consent, decides whether to use a local consent or an OTV-consent (e.g. Mitz); when
  using implicit consent, decides how to implement it (e.g. by expressing it in a FHIR Consent resource or not); and
  performs the consent check.
- **OTV (e.g. Mitz)** — provides online consent registration that is accessible to data holders that use OTV-consent during authorisation.
- **Data user** — supplies, through authentication and the FHIR query, the attributes the data holder uses for the
  consent check.

#### Interaction

The consent check is performed by the data holder as part of authorising an incoming data request. The choice of
consent mechanism (explicit local, explicit OTV, or implicit) is left to the data holder organisation.

#### Conformance

The data holder can use one or more of the following attributes for the consent check:

- URA of data user organisation — sourced from the X509Credential based on UZI server certificate. Required for OTV-consent.
- Organisation type of data user organisation— sourced from the HealthcareProviderRoleTypeCredential. Required for OTV-consent.
- URA of data holder organisation. Required for OTV-consent.
- Organisation type of data holder organisation. Required for OTV-consent.
- BSN of client/patient — sourced from the incoming FHIR query or other patient context.
- A use case identifier — sourced from the authorization scope.

### Network security

1. Production environments: Vendor organizations use server- and client-authentication (mutual TLS) based on
   PKIoverheid-certificates.
2. Acceptance environments: Vendor organizations use server- and client-authentication (mutual TLS) based on
   PKIoverheid-certificates.
3. Test environments: Vendor organizations use server- and client-authentication (mutual TLS) based on
   PKIoverheid-certificates or any public trust certificates.

### Registering a new use case

New use cases can be registered by providing a pull request to
the [nl-zorginzage-resources repository](https://github.com/nuts-foundation/nl-zorginzage-resources).

A complete use case contains:

- The Nuts policy
- An authorization policy
- Discover service presentation definition

Use cases are scoped to a version of this implementation guide and reviewed by Actiz.