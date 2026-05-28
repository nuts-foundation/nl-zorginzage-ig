Volume 3 of this specifcation describes the agreements and specifications about content.

### Data set definitions

- The Zorginzage specification does not describe data sets.
- The Zorginzage specification expects data sets to be descibed using FHIR, in the form of FHIR profiles and FHIR queries.
- The use case specific specifications that are based on Zorginzage have to specify the relevant data set.

### Individual resource requests
- Read-requests are only allowed on individual resource types, excluding List-, Composition- and Bundle-resources.
- Search-requests are only allowed on individual resource types, excluding List-, Composition- and Bundle-resources.

### Patient Context

All queries that are performed in the context of Zorginzage are patient-specific. The data user needs to know the logical ID of the patient and include it in every query (e.g., patient=123 or subject=Patient/123). The method for obtaining the patient's logical ID is part of the Zorginzage specifcation and must take place as follows:
- an initial search request on the Patient endpoint using the BSN as patient identifier
  - search request must follow [IHE PDQm ITI-78](https://profiles.ihe.net/ITI/PDQm/ITI-78.html) plus the following extra agreements and specifications:
    - Search must be performed on bsn (`identifier.system` = `http://fhir.nl/fhir/NamingSystem/bsn`)
    - Only POST-based search is allowed, GET-based search is not allowed
    - The template of POST-based Patient search is included below
- data user organisations **MUST** support POST-based Patient search
- data holder organisations **MUST** support POST-based Patient search 

Template of POST-based Patient search:

```
POST {fhir_base}/Patient/_search

Header: Content-Type = x-www-form-urlencoded

Body: identifier=http://fhir.nl/fhir/NamingSystem/bsn|{bsn}
```

