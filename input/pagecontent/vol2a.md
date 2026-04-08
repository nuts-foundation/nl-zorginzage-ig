### Localization

Localization is the process of finding out which organisations have data on a patient.

The generic function localisation is not yet available in production environments. This specification uses bsn
broadcasting using the Nuts Discovery Service for indexed pull scenarios. This means that organisations that implement
this specification perform bsn broadcasting and accept incoming bsn-based patient searches and matches.

This method is the only viable way to localise without external dependencies, however it requires an appropriate legal
basis to be in place.

In practice the BSN broadcast is realised by searching for a patient record with an identifier.

```http request
GET https://examples.http-server.net/Patient?identifier=bsn|618359710&_elements=id
```

- Requestor must pre-filter resources servers that the BSN is broadcasted to by use case and organisation type during
  addressing
- Requestor must provide the `_elements` & `identifier=` query parameters when searching the patient
- Data holder must only return patient ID's when there is data available for the specific use case 

The aim is to replace localisation in the next version of this spec with either pseudonym broadcasting or the GF
localisation. **Always make sure to check the legal basis before broadcasting any BSN's.**
