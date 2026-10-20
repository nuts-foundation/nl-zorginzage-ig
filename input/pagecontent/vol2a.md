### Exchange patterns: pull and indexed pull

The Zorginzage-specification describes data exchanges that use the exchange pattern "pull" or the exchange pattern "indexed pull". See [Whitepaper Communicatiepatronen](https://www.datavoorgezondheid.nl/documenten/2025/07/14/whitepaper-communicatiepatronen-vws) by the Ministry of Health (in Dutch).

In short this means that fetching data globally consists of the following steps:

1. Addressing: The data user finds the addresses of the FHIR- and OAuth-endpoints of each (possible) data holder.
2. Authentication: The data user authenticates (organisation and person level)
3. Localisation: This version of the Zorginzage-specification does not implement a localisation mechanism. Instead, the data user performs targeted querying ("gericht bevragen") at the possible data holder(s) that are already known. Maintaining this list of data holders is the responsibility of the data user and is out of scope for this specification.
    1. Patient search request: The data user performs a patient search at each targeted data holder, using bsn as
       parameter. This step verifies whether this possible data holder actually holds data about the given patient.
    2. Patient search response: When the data holder has data about the requested patient, it returns the internal
       technical identifier of the requested patient.
4. Data request: The data user performs data requests at each targeted data holder, using the technical identifier of the requested patient as a parameter.
5. Authorisation: The data holder authorizes the incoming data request.
    1. Check consent: As part of the authorisation process, the data holder **MAY** check the presence of patient consent, locally or at Mitz.

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
  Zorginformatiebouwsteen Zorgaanbieder: see [zibs.nl](https://zibs.nl/wiki/Zorgaanbieder-v3.6(2024NL)))
- The URA-number is issued by a public organization (CIBG)
- The URA-number is cryptographically verifiable because it is contained in a PKI-certificate (UZI-servercertificaat,
  CPS: see [uziregister.nl](https://www.uziregister.nl/over-het-register/certificeringsbeleid/archief-certification-practice-statement))

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

#### Function

Authentication establishes a verifiable identity for the parties involved in a data exchange. This specification covers
authentication at three levels:

- **Healthcare organisations** (data user organisation and data holder organisation), identified by URA (UZI register
  abonneenummer, OID: `2.16.528.1.1007.3.3`) and authenticated using a credential
  derived from a UZI servercertificate, together with a self-issued credential expressing the
  HealthcareProviderRoleType.
- **Healthcare professionals**, whose identity is federated from the data user organisation to the data holder
  organisation.
- **Vendor organisations**, authenticated at the transport layer (see Network Security).

Organisation- and professional-level authentication is performed via the standard did:web-based Nuts processes.

#### Preconditions

- Vendor organisations on both sides hold a PKIoverheid certificate suitable for mTLS (see Network Security).
- The data user has a UZI server certificate (containing the URA) and has issued the corresponding X500Credential by
  following [this manual](https://wiki.nuts.nl/books/implementing-a-nuts-use-case/page/2-issue-x509credential).
- The data user has self-issued a HealthcareProviderRoleTypeCredential expressing its organisation type(s).
- The data user operates a Nuts node with a did:web identifier and an equivalent set of credentials.
- The data holder has loaded the applicable Nuts policy its Nuts Node.

#### Actors & responsibilities

- **Data user** — presents its X509Credential (URA) and HealthcareProviderRoleTypeCredential during access token
  requests; issues a NutsEmployeeCredential for the healthcare professional acting on its behalf during access token
  requests.
- **Healthcare professional** — represented by a NutsEmployeeCredential issued by the data user organisation;
  identified by a local employee identifier, with local employee name and role as non-identifying attributes.
- **Nuts node (both sides)** — performs the standard Nuts authentication flows (a.o. access token requests and
  introspects) on behalf of the organisation it serves.

#### Interaction

The standard did:web-based Nuts processes are used for access token requests, introspects and jwt-based data requests.
The exact specifications and sequences are described in volume 2b.

Healthcare professional identity is federated by including a NutsEmployeeCredential in the access token request flow;
the data holder receives the verified professional identity attributes alongside the organisation identity.

Vendor organisation authentication is performed at the transport layer through mTLS (see Network Security).

#### Conformance

- Data users **MUST** authenticate the URA using an [X509Credential derived from a UZI server certificate](https://build.fhir.org/ig/nuts-foundation/nl-generic-functions-ig/credential-X509Credential.html) 
  servercertificate, in line with Nuts RFC023.
- Data users **MUST** present a self-issued [HealthcareProviderRoleTypeCredential](https://build.fhir.org/ig/nuts-foundation/nl-generic-functions-ig/credential-HealthcareProviderRoleTypeCredential.html) expressing their
  organisation type(s).
- Data users **MUST** federate healthcare professional identity using a NutsEmployeeCredential.
- Nuts nodes **MUST** follow the standard did:web-based access token, introspect, and jwt-based data request flows as
  specified in volume 2b.
- Vendor organisations **MUST** authenticate connections using mTLS as specified in Network Security.

#### Rationale

- UZI servercertificates are issued by a public organisation (CIBG) and contain the URA as an attribute; including the
  URA in an X509Credential gives a cryptographically verifiable organisation identifier without requiring a separate
  issuer.
- No trusted third-party issuer is currently active for HealthcareProviderRoleType, so the credential is self-issued.
- A nation-wide solution for cross-organisational professional authentication (e.g. Dezi) is not yet in place; the
  NutsEmployeeCredential can be used now and is not dependent on other (national) initiatives.
- A national healthcare professional identifier and role are not yet available for all professionals, so a local
  employee identifier with local name and role attributes is used.

#### References

- [Nuts RFC023 — X509Credential with UZI server certificates](https://wiki.nuts.nl/books/x509credential/page/uzi-server-certificates-with-rfc023)
- [go-didx509-toolkit](https://github.com/nuts-foundation/go-didx509-toolkit/tree/main) · [Java library](https://github.com/nuts-foundation/uzi-did-x509-issuer-java/)
- [UZI servercertificate CPS](https://www.uziregister.nl/over-het-register/certificeringsbeleid/archief-certification-practice-statement)
- [Nuts RFC019 - Nuts Employeed Identity](https://nuts-foundation.gitbook.io/drafts/rfc/rfc019-employee-identity-means)
- Volume 2b — Nuts process specifications and sequences

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

### Addressing via the generic function Care Service Directory (trial-use)

**Status: trial-use.** This section is a pilot element as described in the release policy in Volume 1. Addressing via
the Nuts Discovery Service, as described in the previous section, remains the definitive addressing mechanism of this
version of the specification.

#### Function

The generic function addressing ([Care Service Directory, CSD](https://minvws.github.io/generiekefuncties-docs/en/csd.html))
makes the addressing information of healthcare organisations available through the national directory (LRZa) and local
replicas of that directory. Within Zorginzage, it is used to find:

- the authorisation server(s) at which the data user requests an access token for a data holder organisation;
- the FHIR endpoint at which the data user performs the Patient search (see Volume 3).

Which resource servers are used for the other resource requests is defined by the use case specification, not by
this specification.

#### Preconditions

- The data holder organisation has a URA and is registered in the LRZa as an Organization conforming to
  [NL-GF-Organization](https://minvws.github.io/generiekefuncties-docs/en/StructureDefinition-nl-gf-organization.html).
- The data holder organisation, or a vendor organisation it has authorised through an OrganizationAffiliation, acts as
  CSD Data Source and publishes Endpoints to the LRZa using ITI-130-NL.
- The data user maintains a local replica of the LRZa using ITI-90-NL (initial load) and ITI-91-NL (incremental sync).
- The data user operates a Nuts node to request access tokens.

#### Actors & responsibilities

- **LRZa** — national directory that consolidates and distributes addressing information. The LRZa is not consulted
  during a data exchange.
- **Data holder** — publishes and maintains its Organization and Endpoints in the LRZa.
- **Data user** — Update Client and Query Client: maintains a local replica of the LRZa and selects
  Endpoints from that replica.
- **Nuts node (data user)** — requests access tokens at the selected authorisation server(s).

#### Interaction

1. The data user looks up the data holder organisation by URA in its local replica, including its Endpoints:
   `GET [replica]/Organization?identifier=urn:oid:2.16.528.1.1007.3.3|{URA}&_include=Organization:endpoint`
2. The data user selects the Endpoints with connection type `oauth-nuts` and requests an access token with the use case
   scope, using the `address` of the Endpoint as `authorization_server` in the access token request (see Volume 2b,
   step 7).
3. The data user selects the FHIR endpoint for the Patient search and performs the Patient search with the access
   token.
4. The data user performs the other resource requests at the resource servers as defined by the use case
   specification.

#### Conformance

Data holders:

- Data holders **MUST** register their organisation in the LRZa as an Organization conforming to NL-GF-Organization,
  with an identifier of system `urn:oid:2.16.528.1.1007.3.3` (URA).
- Data holders **MUST** refer from `Organization.endpoint` to at least one Endpoint conforming to
  [NL-GF-Endpoint](https://minvws.github.io/generiekefuncties-docs/en/StructureDefinition-nl-gf-endpoint.html) with:
    - `connectionType` = `http://fhir.generiekefuncties.nl/csd/CodeSystem/nl-gf-authorization-server-cs#oauth-nuts`;
    - `address` = the authorisation server URL of the organisation (the value registered as `authorization_server_url`
      at the Nuts Discovery Service).
- Data holders **MUST** refer from `Organization.endpoint` to at least one Endpoint conforming to NL-GF-Endpoint for the
  Patient search, with:
    - `connectionType` = `http://terminology.hl7.org/CodeSystem/endpoint-connection-type#hl7-fhir-rest`;
    - `payloadType` containing `http://fhir.generiekefuncties.nl/csd/CodeSystem/nl-gf-data-categories-cs#Patient`;
    - `payloadMimeType` containing `application/fhir+json; fhirVersion=4.0`;
    - `address` = the FHIR base URL of the organisation (the value registered as `fhir_base_url` at the Nuts Discovery
      Service).
- Data holders **SHOULD NOT** register separate Endpoints per use case, or express use case information in Endpoints.
- Data holders **SHOULD** withdraw Endpoints by changing their `status`, not by deleting them.

Data users:

- Data users **MUST** select Endpoints from their local replica and **MUST NOT** query the LRZa during a data exchange.
- Data users **MUST** only use Endpoints with `status` = `active` and, when `period` is present, whose `period`
  includes the current time.
- Data users **MUST** request access tokens per healthcare provider organisation (URA), not per vendor organisation.
- When a data holder organisation has more than one active `oauth-nuts` Endpoint, data users **MUST** try them in turn
  until an access token is obtained. When no access token is obtained at any of them, the data holder organisation does
  not take part in the use case.
- When a resource server rejects an access token (HTTP 401), data users **SHOULD** retry with an access token obtained
  from the next `oauth-nuts` Endpoint of the data holder organisation.
- Data users **MUST** perform the Patient search at an Endpoint that meets the Patient search requirements for data
  holders above.
- When the addressing information in the LRZa differs from the registration at the Nuts Discovery Service, the
  registration at the Nuts Discovery Service prevails.
- Data users **MUST NOT** use the local replica for localisation or BSN broadcasting.

#### Rationale

- The roadmap in Volume 1 introduces the generic function addressing as trial-use in this release.
- The CSD deliberately carries no use case or trust framework information: Endpoints are registered once and are
  discoverable across trust frameworks and use cases. Whether a data holder organisation takes part in a use case
  follows from the access token request with the use case scope.
- In Nuts use cases, access tokens are requested per healthcare provider organisation. Organisations with more than one
  `oauth-nuts` Endpoint are rare and the addressing specification has no way currently to define which authorisation
  server should be used for which endpoint. 
- An access token obtained at one authorisation server is not necessarily accepted by a resource server associated
  with another authorisation server; hence the retry on HTTP 401.
- The Patient search is part of this specification, so this specification defines how its FHIR endpoint is found. The
  `Patient` data category and the FHIR version in `payloadMimeType` are the CSD selection criteria for this endpoint.

#### References

- [Generic function addressing — Care Service Directory](https://minvws.github.io/generiekefuncties-docs/en/csd.html)
- [NL-GF-Organization](https://minvws.github.io/generiekefuncties-docs/en/StructureDefinition-nl-gf-organization.html) · [NL-GF-Endpoint](https://minvws.github.io/generiekefuncties-docs/en/StructureDefinition-nl-gf-endpoint.html)
- [NL-GF Connection Types](https://minvws.github.io/generiekefuncties-docs/en/ValueSet-nl-gf-connection-types-vs.html) · [NL-GF Payload Types](https://minvws.github.io/generiekefuncties-docs/en/ValueSet-nl-gf-payload-type-vs.html)
- [IHE mCSD](https://profiles.ihe.net/ITI/mCSD/)

### Localisation

#### Function

Localisation is the process of finding out which organisations have data on a patient.

#### Interaction

This version of the specification does **not** implement a localisation mechanism. Instead, data users perform **targeted querying** (
"gericht bevragen"): the data user only queries possible data holders that are already known by the data user.

This means the data user is responsible for maintaining its own list of healthcare providers that are possible data holder for a specific patient.
a treatment relation. The way in which this list is built up and kept current (e.g. patient-supplied, referral-based,
sourced from an EHR, or otherwise) is out of scope for this specification.

#### Rationale

- The generic function localisation is not yet available in production environments. It is very likely that generic
  function will be trial ready for the next version of this specification.
- BSN broadcasting (sending the BSN to a wide set of possible data holders to discover where data exists) requires an
  appropriate legal basis that is not generally in place for the use cases covered by this specification.
- Targeted querying avoids unnecessary BSN distribution and limits data requests to organisations already known by the data user to possible hold data about a specific patient, 
  which is consistent with the principles of data minimisation and purpose limitation required by the GDPR.

#### Conformance

- The data user **MUST NOT** use the Nuts Discovery Service to broadcast a BSN across all registered data holders for a
  use case (see also the Addressing conformance rules).
- The data user **MUST** resolve locally, for each patient, the specific (possible) data holder(s) it wants to query before initiating
  patient search.
- The patient search at the targeted data holder is still performed using the BSN as parameter, in order to obtain the
  data holder's internal technical identifier for the patient:

```
POST {fhir_base}/Patient/_search

Header: Content-Type = x-www-form-urlencoded

Body: identifier=http://fhir.nl/fhir/NamingSystem/bsn|{bsn}
```

### Authorisation

#### Function

Authorisation determines whether an authenticated requestor may access the data it requests. This specification uses a
fine-grained, policy-based access model rather than a role-based model: whether a requestor gets access depends on
whether the request passes the access policies of the source (data holder).

#### Preconditions

- Authentication has completed, so the data holder knows the URA and HealthcareProviderRoleType of the requesting organisation and, where applicable,
  the federated professional identity (see Authentication).
- A use case scope is present from the authentication process; a use-case-identifier connects this scope to the corresponding access policy and
  authentication policy.
- The applicable policies are available, version controlled in the Git repository [nl-zorginzage-resources](https://github.com/nuts-foundation/nl-zorginzage-resources) that is controlled by the Nuts Foundation.
- The data holder operates a policy enforcement point and has access to a policy decision point (e.g. the PDP
  functionality in the Nuts Knooppunt).

#### Actors & responsibilities

- **Data holder** — defines and enforces the access policies for its data, runs the policy enforcement
  point, and checks consent and/or treatment relation as part of the decision.
- **Data user** — submits data requests carrying the context required for evaluation (a.o. organisation URA, patient
  context, use case scope).
- **Policy decision point** — evaluates the selected policy against the request input; the PDP functionality in the
  Nuts Knooppunt can be integrated with any policy enforcement point. For more info, see the [NIST-definition of PDP](https://csrc.nist.rip/glossary/term/policy_decision_point) and the [Wikipedia-page on XACML](https://en.wikipedia.org/wiki/XACML).
- **Policy enforcement point** - carries out or enforces policy decisions (made by a PDP). For more info, see the [NIST-definition of PEP](https://csrc.nist.rip/glossary/term/pep) and the [Wikipedia-page on XACML](https://en.wikipedia.org/wiki/XACML).
- **Nuts Foundation** — maintains the version-controlled policies in Git.

#### Interaction

The policy is selected based on the use case scope provided by the Nuts access token as part of the authentication process. The input for evaluating the policy is a commonly agreed upon information model; the model is described in the
[this proposal for the generic function authorisation](https://build.fhir.org/ig/nuts-foundation/nl-generic-functions-ig/authorization.html).

Policies are expressed in a domain specific language called Rego so that everyone uses the same rulesets. Implementors
are free not to implement a Rego interpreter as part of their authorisation solution, as long as the implemented
solution follows the exact same rules as specified in the Rego policy file for that use case. 

#### Conformance

- The data holder organisation **MUST** enforce the rules as described in the commonly defined rego policy for this use case
- The data holder organisation **MAY** implement a rego-interpreter.

The following guidelines **MUST** be taken into account when designing new policies:

- Presence of the URA identifier of the requesting organisation *MUST* be checked.
- When the request is for a FHIR endpoint, conformance to a capability statement **MUST** be evaluated.
- Patient context is mandatory for accessing patient data:
    - for search interactions, either a patient id or patient bsn **MUST** be derivable from the query;
    - for read interactions, the requested resource **MUST** have a direct link to a patient (for example through a patient- or subject-
      field).
- For data requests that require explicit consent, patient consent **MUST** be checked in a local system **OR** in Mitz before
  returning the data.
- An active treatment relation between the patient that is referenced in the request and the data holder **MAY** be checked, optionally in the context of a specific use case.

For data requests in which explicit consent is not checked, one of the following is **mandatory**:

- A legal basis **MUST** be present in which explicit consent is not necessary, e.g. a referral or handoff of a patient from data holder to data user.
- The treatment relation of the data user organisation with the patient **SHOULD** be checked technically by the data holder
  organisation (e.g. using a [PatientEnrollmentCredential](https://build.fhir.org/ig/nuts-foundation/nl-generic-functions-ig/credential-PatientEnrollmentCredential.html)). This treatment relation can be scoped to a specific context
  (e.g. a use case).


The treatment relation of the data holder organisation with the patient **MAY** be checked technically by the data
holder organisation.

#### Rationale

- A fine-grained policy-based model is preferred over a role-based model because access decisions depend on the access
  policies of the source rather than on a fixed set of roles.
- Expressing policies in Rego ensures everyone uses the same rulesets, evaluated against a commonly agreed information
  model.

#### References

- [Generic function authorisation (nl-generic-functions-ig)](https://nuts-foundation.github.io/nl-generic-functions-ig/authorization.html)

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
- BSN of client/patient — sourced from the incoming FHIR query or other patient context. Required for OTV-consent.
- A use case identifier — sourced from the authorisation scope.

When a data holder wants to use OTV-consent during authorisation, it **MUST** implement the 'Gesloten Autorisatievraag' as specified in ["Implementatiehandleiding_OpenGesloten"](https://vzvz.atlassian.net/wiki/spaces/MA11/pages/828314367/Bijlage+Architectuurdocumenten).

### Network security

#### Conformance

1. Production environments: Vendor organizations **MUST** use server- and client-authentication (mutual TLS) based on
   PKIoverheid-certificates.
2. Acceptance environments: Vendor organizations **MUST** use server- and client-authentication (mutual TLS) based on
   PKIoverheid-certificates.
3. Test environments: Vendor organizations **MUST** use server- and client-authentication (mutual TLS) based on
   PKIoverheid-certificates or any public trust certificates.

#### Rationale

- National specifications for network security, commonly referred to as "Veilig Netwerk" are not yet finalized.
- The current concept version of the national specifications prescribes the use of PKIoverheid-certificates
- PKIoverheid-certificates are already widely in use by vendors

### Registering a new use case

New use cases can be registered by providing a pull request to
the [nl-zorginzage-resources repository](https://github.com/nuts-foundation/nl-zorginzage-resources).

A complete use case contains:

- The Nuts policy
- An authorisation policy
- Discover service presentation definition

Use cases are scoped to a version of this implementation guide and reviewed by Actiz.
