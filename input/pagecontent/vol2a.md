### Section

### Section 2

### Section 3

### Consent

### Identification 

#### Healthcare organisations

##### Identifier: URA
Healthcare organisations are identified using URA-number (UZI-Register Abonneenummer).

Rationale
- Identification of healthcare organisations by URA conforms to the national information model for health orgnizations (Zorginformatiebouwsteen Zorgaanbieder: https://zibs.nl/wiki/Zorgaanbieder-v3.6(2024NL))
- The URA-number is issued by a public organization (CIBG)
- The URA-number is cryptographically verifiable because it is contained in a PKI-certificate (UZI-servercertificaat, CPS: https://www.uziregister.nl/over-het-register/certificeringsbeleid/archief-certification-practice-statement)

##### HealthcareProviderRoleType
Healthcare organisations use a HealthcareProviderRoleType attribute to express which type(s) of healthcare organisations they are.

Raionale
- In indexed pull scenarios, OTV-consents (online toestemmingsvoorziening, Mitz) are relevant. The use of OTV-consents requires uniform communication of the type of healthcare organisation of both data user organisation and data holder organisation.
- The type of healthcare organisation is a useful attribute in  authorisation and localisation processes.
- The HealthcareProviderRoleType is self-issued by each healthcare organisation. No trusted third party issuer is active at the moment.

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
URA-number is contained as attribute in the UZI-servercertificaat, CPS: https://www.uziregister.nl/over-het-register/certificeringsbeleid/archief-certification-practice-statement
- The URA-number can securely be contained in a X509credential using the open source software did:x509 and X509Credential Toolkit

##### HealthcareProviderRoleTypeCredential
The HealthcareProviderRoleType attribute will be authenticated using a self issued HealthcareProviderRoleTypeCredential.

Rationale
- No trusted third party issuer is active at the moment.

##### Standard Nuts processes
The standard did:web-based Nuts-processes for access token requests and introspects, and jwt-based data requests are used. The exact specifications and sequences are described in volume 2b. 

#### Vendor organisations
The parapraph Network Security descibes mTLS-based client and server authentication.

#### Healthcare professionals
The identity of healthcare professionals is federated from data user organisation to data holder organisatin using a NutsEmployeeCredential.

Rationale
- A nation-wide solution for cross-organizational authentication (e.g. Dezi) is not in place.
- NutsEmployeeCredential can be used now and is not dependent of other (national) initiatives

### Consent

- It is up to the data holder organisation to decide whether to use explicit consent and/or another legal basis when authorizing an incoming data request.
- When using explicit consent, it is up to the data holder organisation to decide whether to use a locally stored consent record or an OTV-consent (Mitz).
- When using implicit consent, it is up to the data holder organisation to decide how to implement this (e.g. by expressing that implicit consent in a FHIR Consent resource or not).
- A locally stored consent record minimally contains the following elements:
    - URA of data holder organisation
    - URA of intended data user organisation
    - BSN of client/ patient
    - A standardized way to express the context (e.g. using a use case identifier)
- The first release of the zorginzage specifcation after Mitz being production ready for all zorginzage participants will make the "Mitz gesloten vraag" mandatory when no locally stored consent record is available.