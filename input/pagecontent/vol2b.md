### Registration at discovery service

All data holders have to register themselves at the Discovery Service. This registration takes place in the implementation-phase.

<div width="90%" style="width: 90vw;">{% include sequence-diagram-disco.svg %}</div>
<br clear="all"/>

Number | Remarks
-------|--------
1 | Registration request to local Nuts-node (see below)
2 | 
3 |
4 |

#### Step 1 details
The body of the request to the internal API of the Nuts-node **MUST** contain the following registration parameters:

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
3 | 
4 |
5 | Search data holder organisation by URA-identifier 
6 |
7 | Include NutsEmployeeCredential, example request below
8 |
9 |
10| See [section Patient Context in Volume 3](https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/vol3.html#patient-context) for more details
11|
12|
13|
14|
15|
16|
17|
18|
19|
20|
21|
22|
23|
24|

#### Step 7 details

The body of the request **MUST** contain a NutsEmployeeCredential CredentialSubject:

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

### Pull with addressing via the generic function Care Service Directory (trial-use)

**Status: trial-use.** This sequence shows the pull scenario when the data user uses the generic function addressing,
as described in Volume 2a, section "Addressing via the generic function Care Service Directory (trial-use)". Steps
that are the same as in the pull scenario above are not described again. How data holders publish their addressing
information in the LRZa is described in [CSD Use Case #1](https://minvws.github.io/generiekefuncties-docs/en/csd.html#use-case-1-admin-registers-affiliation-service-provider-publishes-resources).

<div width="90%" style="width: 90vw;">{% include sequence-diagram-pull-csd.svg %}</div>
<br clear="all"/>

Number | Remarks
-------|--------
1 | Initial load of the local replica using ITI-90-NL, independent of user sessions
2 |
3 | Incremental sync of the local replica using ITI-91-NL
4 |
5 | Local login
6 | XIS creates user sessions and stores the user info needed for the NutsEmployeeCredential (step 12)
7 |
8 |
9 | Look up data holder organisation by URA in the local replica. The LRZa is not queried during a data exchange
10 |
11 | Only Endpoints with `status` = `active` and, when present, a `period` that includes the current time are selected
12 | Request body as in step 7 of the pull scenario above, with `authorization_server` = `address` of the oauth-nuts Endpoint. When there is more than one oauth-nuts Endpoint, they are tried in turn until an access token is obtained
13 |
14 |
15 | Patient search at the `address` of the selected hl7-fhir-rest Endpoint, see [section Patient Context in Volume 3](vol3.html#patient-context). When the access token is rejected (HTTP 401), retry with an access token from the next oauth-nuts Endpoint
16 |
17 |
18 |
19 |
20 |
21 |
22 | The resource servers used for other resources are defined by the use case specification
23 |
24 |
25 |
26 |
27 |
28 |
29 |
