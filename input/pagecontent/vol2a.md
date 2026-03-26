#### Localization

Localization is the process of finding out which organisation have data on a patient.

In the absence of a generic localization service, localization is handled locally. This means that the systems
themselves keep track of where data can be retrieved. For example, by explicitly recording the VVT (nursing, care, and
home care) institution where the patient is being treated in the HIS (General Practitioner Information System). Or, in
the case of access to the GP record, by recording the relevant GP in the ECD (Electronic Care Record) within the file.

A national index based using pseudonymisation technology is being worked on but for the time being we will have to rely
on local registration of the patient-provider relationships.

#### Alternative: Pseudonym broadcasting

The ministry of health is developing a national pseudonymisation service which will make it so that there is a national
standerd for creating pseudonyms of BSN's. Using this method it will be possible to poll other organisations for patient
data without revealing the BSN itself.

Practically this would mean that every XIS keeps an index of the of pseudonym to BSN using the national OPRF service.
The requesting party can now broadcast a pseudonym to all other parties in the network to determine patient-provider
relationship without while preserving the privacy of the patient.

#### Todo

- Discuss options
  - Local registration
  - Pseudonym broadcasting
  - National NVI (ready in spring?)
  - Use CareTeam/ CareTeams as index
