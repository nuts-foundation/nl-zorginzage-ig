### Registration at discovery service

All data holders have to register themselves at the Discovery Service. This registration takes place in the implementation-phase.

<div width="100%">{% include sequence-diagram-disco.svg %}</div>
<br clear="all"/>

Number | Remarks
-------|--------
1 | Registration request to local Nuts-node (see below)
2 | 
3 |
4 |

#### Step 1 details

Body:
```
{
  "registrationParameters": {
    "authorization_server_url": "https://example.com/some-endpoint",
    "fhir_base_url": "https://example.com/some-endpoint",
  }
}
```


### Pull

The sequence for pull scenarios is the following. The numbered transactions are specified in more detail in the table below the sequence diagram.

<div width="100%">{% include sequence-diagram-pull.svg %}</div>
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
10|
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