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

### Network security

1. Production environments: Vendor organizations use server- and client-authentication (mutual TLS) based on PKIoverheid-certificates.
2. Acceptance environments: Vendor organizations use server- and client-authentication (mutual TLS) based on PKIoverheid-certificates.
3. Test environments: Vendor organizations use server- and client-authentication (mutual TLS) based on PKIoverheid-certificates or any public trust certificates.