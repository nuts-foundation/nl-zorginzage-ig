#### Addressing

To exchange data between healthcare organisations that are not previously known to each other, it must be possible to
discover addressing information within the healthcare network. Address information is data that describe an
organisation's topology and the various ways an organisation can be reached. These can be physical, digital, or logical
entities.

For all use cases, the starting point is finding the correct endpoints, for example, to request an access token or to
send a task. The Nuts community uses their discovery service for this purpose.

[A complete description of the Discovery Service](https://wiki.nuts.nl/books/designing-a-nuts-use-case/page/service-discovery)
can be found on the Nuts Wiki.

In terms of required credentials, we use two different types during the discovery process: an X509Credential and a
DiscoveryRegistrationCredential. These credentials are when registering and requesting addressing information.

Searches can be performed by organisation URA, organisation type and use case.

##### X509Credential

The X509Credential is an organisation credential that is used to present the URA number.

This is an X509Credential in accordance
with [Nuts RFC023](https://wiki.nuts.nl/books/x509credential/page/uzi-server-certificates-with-rfc023), signed with an
UZI server certificate.

It can be created, for example, with
the [go-didx509-toolkit](https://github.com/nuts-foundation/go-didx509-toolkit/tree/main) or
the [Java library](https://github.com/nuts-foundation/uzi-did-x509-issuer-java/). It has been decided to include the
chain closest to the leaf certificate as the issuer.

##### DiscoveryRegistrationCredential

The DiscoveryRegistrationCredential is a temporary credential that communicates the information for making a new
registration in the discovery service.

This is a DiscoveryRegistrationCredential as explained on
the [Nuts Wiki page about Service Discovery](https://wiki.nuts.nl/books/designing-a-nuts-use-case/page/service-discovery#bkmrk-require-registration).

A field named `fhirBaseURL` has been added to the credentialSubject. This can be used by users of the Discovery Service to
know where the actual FHIR data can be retrieved.

A field named `authorization_server_url` has been added to the credentialSubject. This can be used by users of the
Discovery Service to look up the access token request endpoint.

It is important to include the organisation type when registering with the Discovery Service, so that a distinction can
be made between a nursing/care institution and a GP. The HL7 organisation type Code List is used for
this: https://zibs.nl/wiki/Zorgaanbieder-v3.4(2020NL)#OrganisatieTypeCodelijst

### Todo

- Who will host the discovery service?
- How to request one for a new use case?
- Who signs the DiscoveryRegistrationCredential?

#### Roadmap

- GF addressing is coming
- National implementation starts at the end of 2026
- Link to VWS IG addressing page
