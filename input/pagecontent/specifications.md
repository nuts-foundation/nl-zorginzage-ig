# Technical Specifications

This section provides technical implementation details for the Zorginzage profile.

## Standards and Protocols

### Transport
- **HTTPS** with mutual TLS (mTLS)
- TLS 1.2 minimum (1.3 recommended)
- Strong cipher suites (e.g., ECDHE-RSA-AES256-GCM-SHA384)
- Valid certificates from trusted CAs

### Data Formats
- **JSON** for structured data
- **JWT** (RFC 7519) for tokens
- **FHIR R4** for healthcare resources.

### Authorization
- **OAuth 2.0** (RFC 6749, RFC 7523)
- JWT Bearer Token flow
- Time-limited access tokens (15-60 minutes typical)

### Identification
- **DIDs** (Decentralized Identifiers) for organizations
- **BSN** for patient identification (encrypted in records)
- **UZI** or **IRMA** for professional authentication

## Information Standards

### FHIR Profiles
Use Nictiz ZIB-based FHIR R4 profiles:
- `nictiz.fhir.nl.r4.nl-core` (0.12.0-beta.4)
- `nictiz.fhir.nl.r4.zib2020` (0.12.0-beta.4)

Common resources:
- Patient (with BSN identifier)
- Observation (vital signs, lab results)
- Condition (problems, diagnoses)
- MedicationStatement
- Procedure
- DiagnosticReport

### Search Parameters
Support standard FHIR search parameters per resource type, filtered by:
- Patient identifier
- Date ranges
- Category/type
- Status

## Authorization Records

### Structure (RFC014)
```json
{
  "type": ["VerifiableCredential", "NutsAuthorizationCredential"],
  "issuer": "did:nuts:{data-holder-id}",
  "credentialSubject": {
    "id": "did:nuts:{consumer-id}",
    "purposeOfUse": "zorginzage-{care-application}",
    "subject": "{encrypted-bsn}",
    "resources": [
      {
        "path": "/Patient/{patient-id}",
        "operations": ["read"],
        "userContext": true
      },
      {
        "path": "/Observation",
        "operations": ["search"],
        "userContext": true
      }
    ],
    "legalBase": {
      "type": "explicit-consent",
      "evidence": "{reference-to-consent}"
    }
  },
  "issuanceDate": "2026-01-01T00:00:00Z",
  "expirationDate": "2027-01-01T00:00:00Z",
  "proof": {
    "type": "JsonWebSignature2020",
    "proofPurpose": "assertionMethod",
    "verificationMethod": "did:nuts:{data-holder-id}#key-1",
    "jws": "{signature}"
  }
}
```

## Access Tokens

### JWT Structure
```json
{
  "iss": "did:nuts:{data-holder-id}",
  "sub": "did:nuts:{consumer-id}",
  "aud": "https://data-holder.example.com/fhir",
  "exp": 1640000000,
  "iat": 1639996400,
  "vcs": ["{authorization-record-id}"],
  "sid": "{patient-id}",
  "user": {
    "id": "{uzi-number}",
    "name": "Dr. Example",
    "role": "physician"
  },
  "scope": "patient/*.read"
}
```

## Service Registration

### Nuts Registry
Register services per organization/vendor:

```json
{
  "id": "did:nuts:{organization-id}#service-1",
  "type": "zorginzage-{care-application}",
  "serviceEndpoint": {
    "oauth": "did:nuts:{vendor-id}/serviceEndpoint?type=oauth",
    "fhir": "did:nuts:{vendor-id}/serviceEndpoint?type=fhir"
  }
}
```

### Endpoint Registration
```json
{
  "id": "did:nuts:{vendor-id}#fhir-endpoint",
  "type": "zorginzage-{care-application}-fhir",
  "serviceEndpoint": "https://fhir.example.com/base"
}
```

## Access Policies

Each Care Application defines:
- **Purpose of Use**: Identifier (e.g., "zorginzage-geboortezorg")
- **Scope**: FHIR resources and search parameters
- **Validity**: Authorization record lifetime
- **Legal Grounds**: Permitted consent types
- **Requirements**: Treatment agreement/relationship checks

## Audit Logging (NEN7513)

Required attributes:
- **Who**: User identity, role, organization
- **What**: Resources accessed, operations
- **When**: Timestamp (ISO 8601 with timezone)
- **Where**: Source IP/system
- **Why**: Purpose, Care Application
- **Outcome**: Success/failure, HTTP status

Log format: FHIR AuditEvent or NEN7513-compliant format

## Security Requirements

### Authentication
- User: UZI pass or IRMA (RFC002 compliant)
- System: mTLS client certificates

### Encryption
- Transport: TLS 1.2+
- At rest: BSN and sensitive identifiers in authorization records
- Algorithms: AES-256, RSA-2048+, ES256/RS256 for signatures

### Token Management
- Store securely (encrypted memory)
- Never log tokens
- Discard after use
- Validate signature and expiration on every request

### Certificate Requirements
- Valid CA-issued certificates
- No self-signed in production
- Regular rotation
- CRL/OCSP checking

## Error Handling

### HTTP Status Codes
- `200 OK`: Successful request
- `401 Unauthorized`: Missing/invalid access token
- `403 Forbidden`: Valid token, insufficient authorization
- `404 Not Found`: Resource doesn't exist
- `429 Too Many Requests`: Rate limit exceeded
- `500 Internal Server Error`: Server error

### Error Response
```json
{
  "resourceType": "OperationOutcome",
  "issue": [{
    "severity": "error",
    "code": "security",
    "diagnostics": "Invalid or expired access token"
  }]
}
```

## Conformance

### SHALL Requirements
- Implement mTLS for all communications
- Support UZI or IRMA authentication
- Use Nictiz ZIB FHIR profiles
- Implement NEN7513 audit logging
- Validate authorization records
- Use time-limited tokens

### SHOULD Requirements
- Support both UZI and IRMA
- Implement rate limiting
- Use HSMs for key storage
- Provide patient access to audit logs

### MAY Requirements
- Support Wabvpz consent
- Multi-source aggregation
- Real-time FHIR generation
