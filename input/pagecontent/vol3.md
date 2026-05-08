Volume 3 of this specifcation describes the agreements and specifications about content.

### Data set definitions

- The Zorginzage specification does not describe data sets.
- The Zorginzage specification expects data sets to be described using FHIR, in the form of FHIR profiles and FHIR queries.
- The use case specific specifications that are based on zorginzage have to specify the relevant data set.

### Individual resource requests

The Zorginzage specification focuses on the availability of individual FHIR resources.
- Read-requests are not allowed on List-, Composition- and Bundle-resources.
- Search-requests are not allowed on List-, Composition- and Bundle-resources.

### Patient Context

All queries that are performed in the context of Zorginzage are patient-specific. The data user needs to know the logical ID of the patient and include it in every query (e.g., patient=123 or subject=Patient/123). The method for obtaining the patient's logical ID is part of the Zorginzage specification and must take place as follows:
- an initial search request on the Patient endpoint using the BSN as patient identifier
  - search request must follow [IHE PDQm ITI-78](https://profiles.ihe.net/ITI/PDQm/ITI-78.html) plus the following extra agreements and specifications:
    - Search must be performed on BSN identifier (identifier.system = http://fhir.nl/fhir/NamingSystem/bsn)
    - Only POST-based search is allowed, see https://www.hl7.org/fhir/http.html#search-post
    - GET-based search is not allowed
    - The template of POST-based patient search is included below
- data user organisations must support the above patient search request
- data holder organisations must support the above patient search request

Template of POST-based patient search:
```
POST {fhir_base}/Patient/_search

Header: Content-Type = x-www-form-urlencoded

Body: identifier=http://fhir.nl/fhir/NamingSystem/bsn|{bsn}
```

