# Access Policy

A part of a Bolt is describing as precisely as possible which rules and agreements apply when determining access to certain resources. These are described per care application in an access policy. The access policy is recorded per care application in the care application profile. It is the task of a source system to follow the access policy when authorization records are created and when resources are requested.

The following table shows which matters must be recorded in the access policy per care application:

| Element | Description |
|---------|-------------|
| Purpose of Use | The purpose for which the data may be used, aligned with the care application |
| Scope | Which FHIR resources can be accessed and with what filters/search parameters |
| Validity Period | How long is an authorization record valid |
| Subject Identification | How is the subject identified (BSN, patient identifier, etc.) |
| Treatment Agreement | Requirements for demonstrating a treatment agreement |
| Treatment Relationship | Requirements for demonstrating a treatment relationship |
| Consent Evidence | What evidence is required for the consent that forms the basis of the authorization |
| Revocation | How can an authorization be revoked and what are the effects |

## Example Access Policy Elements

### Purpose of Use
The purposeOfUse field in the authorization record must start with "zorginzage-" followed by the specific care application identifier. For example:
- `zorginzage-geboortezorg` for maternity care
- `zorginzage-bgz` for Basic Healthcare Data Set
- `zorginzage-amo` for Current Medication Overview

### Scope
The scope defines which FHIR resources can be accessed and may include specific search parameters or filters. For example, in maternity care, the scope might be limited to data related to specific pregnancy episodes.

### Validity Period
Authorization records typically have an explicit validity period. For some care applications, this might be tied to specific care episodes (e.g., a pregnancy in maternity care), while for others it might be a fixed time period (e.g., one year for a general treatment agreement).

### Consent Evidence
The authorization record should contain a reference to the evidence of consent, whether that is:
- A digitally signed consent document
- A reference to a consent registration in the source system
- A referral document that implies consent
- A Wabvpz consent that meets specific cryptographic requirements

## Implementation Considerations

When implementing an access policy:

1. **Specificity**: Be as specific as possible about which data can be accessed under which circumstances
2. **Alignment**: Ensure the access policy aligns with both legal requirements and clinical workflows
3. **Auditability**: Ensure all access decisions can be logged and audited
4. **Revocation**: Implement clear procedures for consent revocation and its effects on existing authorization records
5. **Updates**: Have a clear governance process for updating access policies as requirements evolve
