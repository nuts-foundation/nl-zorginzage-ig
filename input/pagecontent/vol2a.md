### Exchange patterns: pull and indexed pull

This specification describes data exchanges that use the exchange pattern "pull" or the exchange pattern "indexed pull". See https://www.datavoorgezondheid.nl/documenten/2025/07/14/whitepaper-communicatiepatronen-vws.

In short this means that fetching data globally consists of the following steps: 

1. Addressing: The data user finds the addresses of the FHIR- and OAuth-endpoints of each (possible) data holder.
2. Authentication: The data user authenticates (organisation and person level)
3. Localisation: The data user finds the data holders that have data about a patient (in a specific context)
    1. Patient search request: The data user performs a patient search at each possible data holder, using bsn as parameter.
    2. Patient search reponse: When the data user has data about the requested patient, it returns the internal technical identifier of the requested patient.
4. Data request: The data user performs data requests at each possible data holder, using the technical identifier of the requested patient as parameter.
5. Authorisation: The data holder authorizes the incoming data request.
    1. Check consent: As part of the authorization process the data holder can check the presence of patient consent, locally or at Mitz.

### Principles

This specification uses the following principles:
- This specification makes use of did:web and verifiable credentials (commonly referred to as "Nuts v6")
- This specification makes use of FHIR API's

### Addressing

To exchange data between healthcare organisations that are not previously known to each other, it must be possible to
discover addressing information within the healthcare network. Address information is data that describe an
organisation's topology and the various ways an organisation can be reached. These can be physical, digital, or logical
entities.

For all use cases, the starting point is finding the correct endpoints, for example, to request an access token or to
send a task. The Nuts community uses their discovery service for this purpose.

[A complete description of the Discovery Service](https://wiki.nuts.nl/books/designing-a-nuts-use-case/page/service-discovery)
can be found on the Nuts Wiki.

In terms of required credentials, we use three different types during the discovery process: an X509Credential, a
DiscoveryRegistrationCredential and a HealthcareProviderRoleTypeCredential. These credentials are used when registering
and requesting addressing information.

Searches can be performed by organisation URA, organisation type and use case.

Actiz is organisationally responsible for hosting the discovery service. One discovery service will be used for all
specific applications-on-Nuts that are based on the generic application-on-Nuts Zorginzage.

##### X509Credential

The X509Credential is an organisation credential that is used to present the URA number.

This is an X509Credential in accordance
with [Nuts RFC023](https://wiki.nuts.nl/books/x509credential/page/uzi-server-certificates-with-rfc023), signed with an
UZI server certificate.
It can be created, for example, with
the [go-didx509-toolkit](https://github.com/nuts-foundation/go-didx509-toolkit/tree/main) or
the [Java library](https://github.com/nuts-foundation/uzi-did-x509-issuer-java/). It has been decided to include the
chain closest to the leaf certificate as the issuer.
##### HealthcareProviderRoleTypeCredential
A self-signed HealthcareProviderRoleTypeCredential has to be presented when registering at the discovery service. This
can be used by users of the Discovery Service to look up the HealthcareProviderRoleType of an organisation.
##### DiscoveryRegistrationCredential
The DiscoveryRegistrationCredential is a temporary credential that communicates the information for making a new
registration in the discovery service.
This is a DiscoveryRegistrationCredential as explained on
the [Nuts Wiki page about Service Discovery](https://wiki.nuts.nl/books/designing-a-nuts-use-case/page/service-discovery#bkmrk-require-registration).
A field named `fhirBaseURL` has been added to the credentialSubject. This can be used by users of the Discovery Service
to know where the actual FHIR data can be retrieved.
A field named `authorization_server_url` has been added to the credentialSubject. This can be used by users of the
Discovery Service to look up the access token request endpoint.

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

identifier=http://fhir.nl/fhir/NamingSystem/bsn|618359710&_elements=id
```

- Requestor must pre-filter resources servers that the BSN is broadcasted to by use case and organisation type during
  addressing
- Requestor must provide the `_elements` & `identifier=` query parameters when searching the patient
- Data holder must only return patient ID's when there is data available for the specific use case 

The aim is to replace localisation in the next version of this spec with either pseudonym broadcasting or the GF
localisation. **Always make sure to check the legal basis before broadcasting any BSN's.**

### Authorization

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
- A legal construction has been created in which explicit consent is not necessary. This is not be checked technically.

The treatment relation of the data holder organisation with the patient may be checked technically by the data holder
organisation.

### Network security

1. Production environments: Vendor organizations use server- and client-authentication (mutual TLS) based on PKIoverheid-certificates.
2. Acceptance environments: Vendor organizations use server- and client-authentication (mutual TLS) based on PKIoverheid-certificates.
3. Test environments: Vendor organizations use server- and client-authentication (mutual TLS) based on PKIoverheid-certificates or any public trust certificates.

### Registering a new use case

New use cases can be registered by providing a pull request to
the [nl-zorginzage-resources repository](https://github.com/nuts-foundation/nl-zorginzage-resources).

A complete use case contains:

- The Nuts policy
- An authorization policy
- Discover service presentation definition 

Use cases are scoped to a version of this implementation guide and reviewed by Actiz.