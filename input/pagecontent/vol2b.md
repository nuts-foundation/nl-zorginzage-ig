The sequence diagrams in this volume are normative for the flow between the organisations. The calls between the XIS
and the Nuts node use the internal API of the Nuts node reference implementation. These calls are non-normative
examples: any system that supports the Nuts protocols may be used, and the internal API may change.

### Registration at discovery service

All data holders have to register themselves at the Discovery Service. This registration takes place in the implementation-phase.

<div width="90%" style="width: 90vw;">{% include sequence-diagram-disco.svg %}</div>
<br clear="all"/>

Number | Remarks
-------|--------
1 | Registration request to local Nuts-node: `POST /internal/discovery/v1/{serviceID}/{subjectID of data holder organisation}`. See step 1 details below
2 | The Discovery Service is part of the Nuts node of the Discovery Service organisation

#### Step 1 details
The registration **MUST** contain the following registration parameters:

```
{
  "registrationParameters": {
    "authorization_server_url": "https://example.com/some-endpoint",
    "fhir_base_url": "https://example.com/some-endpoint",
  }
}
```

The following credentials **MUST** be available in the Nuts node organisation wallet:
1. X509Credential based on UZI server certificate
2. HealthcareProviderRoleTypeCredential

### Pull

The sequence for pull scenarios is the following. The numbered transactions are specified in more detail in the table below the sequence diagram.

<div width="90%" style="width: 90vw;">{% include sequence-diagram-pull.svg %}</div>
<br clear="all"/>

Number | Remarks
-------|--------
1 | Local login
2 | XIS creates user sessions and stores the user info needed for the NutsEmployeeCredential (step 7)
4 | The data_holder_URA's for the patient can be found via a (local) index (e.g. user-input and/or a CareTeam-resource)
5 | Search data holder organisation by URA-identifier. The search API of the Nuts node takes JSON paths to fields in the registered credentials. The URA is part of `credentialSubject.san.otherName` in the X509Credential, so a wildcard search is used: `GET /internal/discovery/v1/{serviceID}?credentialSubject.san.otherName=*-S-{URA}-*`
6 | The discovery service presentation definition of the use case contains the fields listed in Addressing (volume 2a)
7 | Include NutsEmployeeCredential: `POST /internal/auth/v2/{subjectID of data user organisation}/request-service-access-token`. See step 7 details below
8 | The Nuts nodes handle the access token request, which is sent to the `authorization_server_url` of step 6. The data user organisation presents the X509Credential, HealthcareProviderRoleTypeCredential and NutsEmployeeCredential
10| POST-based Patient search on BSN: `POST /fhir/Patient/_search`. See [section Patient Context in Volume 3](https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/vol3.html#patient-context) for more details
11| Introspection of the access token: `POST /internal/auth/v2/accesstoken/introspect`
12| The introspection returns a valid token, the URA of the requesting organisation and the user info (name, role, identifier)
13| Legal basis to be determined by use case, e.g. patient consent and/or treatment relationship
17| Other resources are requested with the patient-id of the data holder organisation (step 16): `GET /fhir/{resource}?patient=Patient/{patient-id}`. The access token of step 9 can be reused. Steps 18 to 20 are the same as steps 11 to 13

#### Step 7 details

The access token request **MUST** contain a NutsEmployeeCredential CredentialSubject:

```
POST <internal Nuts interface>/internal/auth/v2/<subjectID>/request-service-access-token
Content-Type: application/json

{
  "authorization_server": "<authorization_server_url>",
  "scope": "<use-case-identfiier>",
  "credentials": [
    {
      "@context": [
        "https://www.w3.org/2018/credentials/v1",
        "https://nuts.nl/credentials/v1"
      ],
      "type": ["VerifiableCredential", "NutsEmployeeCredential"],
      "credentialSubject": {
        "name": "John Doe",
        "roleName": "Nurse",
        "identifier": "123456"
      }
    }
  ]
}
```
