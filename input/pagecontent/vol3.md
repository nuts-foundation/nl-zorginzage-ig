Volume 3 of this specifcation describes the agreements and specifcations about content.

### data set definitions

- The zorginzage specification does not describe data sets.
- The zorginzage specification expects data sets to be descibed using FHIR, in the form of FHIR profiles and FHIR queries.
- The use case specific specifications that are based on zorginzage have to specify the relevant data set.

### Individual resource requests
- Read-requests are not allowed on List-, Composition- and Bundle-resources.
- Search-requests are only allowed on individual resource types, excluding List-, Composition- and Bundle-resources.

### Patient Context

All queries that are performed in the context of zorginzage are patient-specific. The data user needs to know the logical ID of the patient and include it in every query (e.g., patient=123 or subject=Patient/123). The method for obtaining the patient's logical ID is part of the zorginzage specifcation and must take place as follows:
- an initial search request or match request on the Patient endpoint using the BSN as patient identifier
  - match request must follow [IHE PDQm ITI-119](https://profiles.ihe.net/ITI/PDQm/ITI-119.html)
  - search request must follow [IHE PDQm ITI-78](https://profiles.ihe.net/ITI/PDQm/ITI-78.html) plus the following extra agreements and specifications:
    - Search must be perform on bsn (identfiier.system = http://fhir.nl/fhir/NamingSystem/bsn)
    - Only POST-based serach is allowed, GET-based search is not allowed
    - The template of POST-based Patient search is included below
- data user organisations can choose to support search and/or match
- data holder organisations have to support both search and match

Template of POST-based Patient search:
```
POST /fhir/Patient/_search

Header: Content-Type = x-www-form-urlencoded (zie https://www.hl7.org/fhir/http.html#search-post)

Body: identifier=http://fhir.nl/fhir/NamingSystem/bsn|{bsn}
```