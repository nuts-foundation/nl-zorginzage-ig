#### Exchange patterns: pull and indexed pull JORRIT

This specification is aimed at data exchanges that use the exchange pattern "pull" or the exchange pattern "indexed pull". See https://www.datavoorgezondheid.nl/documenten/2025/07/14/whitepaper-communicatiepatronen-vws.

>>TO DO verplaats het volgende stukje naar Vol 2b sequenties
In short this means that fetching data globally consists of the following steps: 

1. Localization: Localising the data holders
   1. Exchange pattern "indexed pull": Localization is done by using an index outside the data holder (for instance NVI)
   2. Exchange pattern "pull": Localization is done by using an index maintained by the data holder (for instance a CareTeam)
2. Addressing: Find the addresses of the FHIR- and OAuth-endpoints of each data holder 
3. Getting access token: Data user organization gets each from each data holder
4. Data request: actually reuqesting the data at each known data holder.
>>

#### Principles

This specification uses the following principles:
- This specification makes use of Nuts v6, meaning it is based on the use of the did:web and verifiable credentials
- This specification is aimed at making data available and requestingt data via FHIR API's
- This specification will only contain dependencies when they are available in real-life production environments
- This specification incrementally and iteratively evolve to replace all Nuts-specific elements with the nationally specified generic functions
- This specification will have a maximum of 2 major releases per year

### Section 2

### Section 3

### Consent