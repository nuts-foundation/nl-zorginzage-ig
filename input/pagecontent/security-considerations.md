# 1:4 Security Considerations

The Zorginzage profile handles highly sensitive healthcare data and must implement comprehensive security measures.

## Security Principles

### Defense in Depth
Multiple layers of security controls:
1. **Network Layer**: Mutual TLS (mTLS) for all communications
2. **Application Layer**: OAuth 2.0 access tokens with limited scope and lifetime
3. **Data Layer**: Encryption at rest, access policy enforcement
4. **Process Layer**: Authentication, authorization, audit logging

### Zero Trust Architecture
- No implicit trust based on network location
- Every access request is authenticated and authorized
- Continuous validation of trust
- Least privilege access

### Privacy by Design
- Data minimization through scoped authorization
- Purpose limitation through Care Application profiles
- Transparency through audit logs
- Patient control through consent management

## Authentication Requirements

### User Authentication

Healthcare professional Users MUST authenticate using cryptographically strong means:

**Approved Means**:
- **UZI Pass**: PKI smartcard with BIG registration
- **IRMA**: Privacy-preserving attribute-based credentials
- Other means approved in Care Application Profile

**Authentication Contract** ([RFC002](https://nuts-foundation.gitbook.io/drafts/rfc/rfc002-authentication-token)):
- Digitally signed assertion of user identity
- Contains user attributes (name, role, organization)
- Time-limited validity
- Cryptographically verifiable

**Requirements**:
- SHALL verify user identity against trusted registry
- SHALL verify professional registration (where applicable)
- SHALL verify organizational affiliation
- SHALL use time-limited authentication (typical: 8-12 hours)
- SHALL NOT reuse authentication across sessions without re-authentication

### System Authentication

Systems MUST authenticate using mutual TLS:

**Client Certificate Requirements**:
- Issued by trusted Certificate Authority
- Contains organization identifier (DID or OID)
- Valid certificate chain
- Not expired or revoked

**Server Certificate Requirements**:
- Valid for the endpoint hostname
- Trusted CA chain
- Current and not revoked

See [RFC008](https://nuts-foundation.gitbook.io/drafts/rfc/rfc008-certificate-structure) for certificate structure.

## Authorization Requirements

### Multi-Level Authorization

Access requires ALL of the following:

1. **Authorization Record**: Machine-readable permission from Data Holder
2. **Treatment Agreement**: Active treatment relationship between Consumer organization and Subject
3. **Treatment Relationship**: Active care relationship between User and Subject  
4. **Access Policy Compliance**: Request meets Care Application access policy rules
5. **Valid Access Token**: Current, non-expired token with appropriate scope

### Authorization Record Validation

Data Holder SHALL verify:
- Authorization record exists and is active
- Authorization record is not expired
- Authorization record is not revoked
- Consumer in token matches Consumer in authorization record
- Subject in request matches Subject in authorization record
- Requested resources are within authorized scope
- Purpose of use matches Care Application

### Consent Validation

Data Holder SHALL verify:
- Valid legal ground exists (explicit consent, presumed consent, or Wabvpz)
- Consent has not been withdrawn
- Consent scope covers requested data
- Consent validity period is current

### Treatment Relationship Validation

Consumer SHALL verify BEFORE requesting access token:
- Treatment agreement exists between Consumer organization and Subject
- User has active treatment relationship with Subject (not just organizational access)
- Relationship is appropriate for Care Application context

## Access Token Security

### Token Structure

Access tokens SHALL:
- Be implemented as JSON Web Tokens (JWT)
- Be signed by Data Holder's private key
- Contain required claims (see [RFC003](https://nuts-foundation.gitbook.io/drafts/rfc/rfc003-oauth2-authorization))
- Have limited lifetime (recommended: 15-60 minutes)
- Include scope limitations from authorization record

### Token Handling

Consumers SHALL:
- Store tokens securely (encrypted in memory or secure storage)
- NOT log tokens (even in debug logs)
- NOT transmit tokens except in Authorization header over mTLS
- Discard tokens after use or expiration
- Implement token refresh mechanisms where appropriate

Data Holders SHALL:
- Validate token signature on every request
- Verify token expiration on every request
- Verify token has not been revoked
- Rate limit token requests to prevent abuse
- Log token issuance with user and organization

## Transport Security

### Mutual TLS

ALL network communications SHALL use mutual TLS:

**TLS Version**: TLS 1.2 or higher (TLS 1.3 recommended)

**Cipher Suites**: SHALL use strong cipher suites (e.g., ECDHE-RSA-AES256-GCM-SHA384)

**Certificate Validation**:
- Verify certificate chain to trusted root
- Verify certificate not expired
- Verify certificate not revoked (OCSP or CRL)
- Verify hostname matches certificate
- Verify client certificate for client authentication

**Implementation Notes**:
- SHALL NOT fallback to non-mTLS
- SHALL NOT accept self-signed certificates (except in test environments)
- SHALL implement certificate pinning where appropriate

## Cryptographic Requirements

### Digital Signatures

All security tokens and authorization records SHALL be digitally signed:

**Signing Algorithm**: RS256 or ES256 (ECDSA preferred for performance)

**Key Management**:
- Private keys SHALL be stored in Hardware Security Modules (HSM) or equivalent secure storage
- Private keys SHALL NOT be shared across systems
- Key rotation procedures SHALL be implemented
- Compromised keys SHALL be immediately revoked

### Encryption

Sensitive data SHALL be encrypted:

**In Transit**: TLS 1.2+ with strong ciphers

**At Rest**: 
- Patient identifiers (especially BSN) SHALL be encrypted in authorization records
- Audit logs MAY be encrypted
- Database encryption SHOULD be implemented

**Encryption Standards**: AES-256 or equivalent

## Audit and Logging

### Audit Requirements (NEN7513)

All data access SHALL be logged with:

**Who**: User identity, role, organization
**What**: Resources accessed, actions performed
**When**: Timestamp (with timezone)
**Where**: Source IP/system identifier
**Why**: Purpose of use, Care Application context
**Outcome**: Success or failure, error codes if applicable

### Audit Log Protection

Audit logs SHALL:
- Be tamper-evident (e.g., cryptographically chained)
- Be retained per legal requirements (minimum 7 years in NL)
- Be accessible for patient review (where technically feasible)
- Be accessible for regulatory oversight
- Be protected against unauthorized access
- Be backed up regularly

### Security Event Logging

Systems SHALL log security-relevant events:
- Authentication attempts (success and failure)
- Authorization decisions
- Token issuance and validation
- Access policy violations
- System errors affecting security
- Configuration changes

## Incident Response

### Security Incident Handling

Organizations SHALL:
- Have documented incident response procedures
- Designate security incident response team
- Have communication plans for security incidents
- Report breaches per GDPR requirements (72 hours)
- Conduct post-incident reviews

### Breach Notification

In case of data breach:
- Notify affected patients
- Notify data protection authority
- Notify other affected organizations
- Document breach and response
- Implement corrective measures

## Vulnerability Management

Organizations SHALL:
- Keep systems and dependencies up to date
- Monitor security advisories for used software
- Implement patch management procedures
- Conduct regular security assessments
- Perform penetration testing periodically
- Address identified vulnerabilities in timely manner

## Access Control

### System Access

- Implement role-based access control (RBAC)
- Apply principle of least privilege
- Regularly review access rights
- Remove access for terminated employees immediately
- Implement strong password policies (or eliminate passwords via SSO)

### Physical Security

- Secure data centers and server rooms
- Implement physical access controls
- Monitor physical access
- Secure backup media
- Implement secure disposal procedures

## Privacy-Specific Controls

### Data Minimization

- Only request and access data necessary for purpose
- Implement scope limitations in authorization records
- Avoid broad "read all" authorizations
- Filter results to relevant time periods

### Purpose Limitation

- Clearly specify purpose in authorization records
- Validate purpose at access time
- Prevent use of data for other purposes
- Educate users on appropriate use

### Patient Rights

Support patient rights:
- Right to access (view who accessed data)
- Right to rectification (correct errors)
- Right to erasure (where legally permissible)
- Right to restrict processing (revoke consent)
- Right to data portability

## Conformance Requirements

### Security Conformance

Systems claiming conformance SHALL:
1. Implement mutual TLS for all communications
2. Use approved authentication means
3. Validate authorization records before access
4. Implement NEN7513 audit logging
5. Use time-limited access tokens
6. Encrypt sensitive data in authorization records
7. Implement security event logging
8. Have documented incident response procedures

Systems SHOULD:
1. Implement certificate pinning
2. Use HSMs for key storage
3. Implement automated security monitoring
4. Conduct regular security audits
5. Participate in coordinated vulnerability disclosure

### Security Testing

Implementers SHOULD:
- Conduct security testing before production deployment
- Participate in connectathons with security focus
- Undergo third-party security assessment
- Implement continuous security monitoring

## References

- [RFC002 - Authentication Token](https://nuts-foundation.gitbook.io/drafts/rfc/rfc002-authentication-token)
- [RFC003 - OAuth2 Authorization](https://nuts-foundation.gitbook.io/drafts/rfc/rfc003-oauth2-authorization)
- [RFC008 - Certificate Structure](https://nuts-foundation.gitbook.io/drafts/rfc/rfc008-certificate-structure)
- [RFC014 - Authorization Credential](https://nuts-foundation.gitbook.io/drafts/rfc/rfc014-authorization-credential)
- NEN7513 - Logging in Healthcare
- GDPR - General Data Protection Regulation
- WGBO - Medical Treatment Agreement Act
- ISO 27001 - Information Security Management
