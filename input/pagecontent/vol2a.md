#### Addressing

To exchange data between healthcare organisations that are not previously known to each other, it must be possible to
discover addressing information within the healthcare network. Address information is data that describe an
organisation's
topology and the various ways an organisation can be reached. These can be physical, digital, or logical entities.

For all use cases, the starting point is finding the correct endpoints, for example, to request an access token or to
send a task. The Nuts community uses a so-called discovery service for this purpose.

[A complete description of the Discovery Service](https://wiki.nuts.nl/books/designing-a-nuts-use-case/page/service-discovery)
can be found on the Nuts Wiki.

In terms of required credentials, we use two different types: an X509Credential and a DiscoveryRegistrationCredential.

##### X509Credential

This is an X509Credential in accordance
with [Nuts RFC023](https://wiki.nuts.nl/books/x509credential/page/uzi-server-certificates-with-rfc023), signed with a
UZI server certificate.

It can be created, for example, with
the [go-didx509-toolkit](https://github.com/nuts-foundation/go-didx509-toolkit/tree/main) or
the [Java library](https://github.com/nuts-foundation/uzi-did-x509-issuer-java/). It has been decided to include the
chain closest to the leaf certificate as the issuer.

Searches can be performed by DID name, organisation name, organisation type, location & URA.

##### DiscoveryRegistrationCredential

This is a DiscoveryRegistrationCredential as explained on
the [Nuts Wiki page about Service Discovery](https://wiki.nuts.nl/books/designing-a-nuts-use-case/page/service-discovery#bkmrk-require-registration).

A field named fhirBaseURL has been added to the credentialSubject. This can be used by users of the Discovery Service to
know where the actual FHIR data can be retrieved.

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
