# Process Flow

## Overview

Zorginzage consists of two main processes:

1. **Publishing**: Data Holder makes data available with authorization
2. **Consulting**: Consumer retrieves data for clinical use

## Publishing Process

### Steps

1. **Consent Collection**: Patient gives consent (explicit, referral-based, or Wabvpz)
2. **Record Consent**: Healthcare professional records in source system
3. **Create Authorization Record**: System generates machine-readable record with:
   - Subject identifier (BSN)
   - Data Holder and Consumer DIDs
   - Scope (resources, time period)
   - Purpose (Care Application)
   - Legal ground reference
4. **Publish Record**: Authorization Registry stores and syncs to Consumer's node
5. **Data Preparation**: Ensure FHIR API provides access to authorized resources

### Authorization Types

**Explicit Consent**: Patient explicitly authorizes specific Consumer to access specific data

**Presumed Consent**: Based on referral - patient consent to referral implies consent to data sharing

**Wabvpz Consent**: Broad consent for categories of providers (requires additional safeguards)

## Consulting Process

### Steps

1. **Check Relationships**:
   - Treatment agreement between Consumer and patient
   - Treatment relationship between user and patient

2. **Discover Data**:
   - Query Authorization Registry for active records
   - Identify Data Holders with accessible data
   - Retrieve Data Holder endpoints

3. **Authenticate User**:
   - User authenticates with UZI pass or IRMA
   - Generate signed authentication contract

4. **Request Access Token**:
   - Consumer requests token from Data Holder's OAuth server
   - Include user authentication contract
   - Reference authorization records
   - Receive JWT access token

5. **Query Resources**:
   - Send FHIR queries with access token
   - Data Holder validates token and applies access policy
   - Returns authorized FHIR resources

6. **Present Data**:
   - Display to user
   - Option to view-only or selectively copy
   - Log access per NEN7513

### Data Handling Options

- **View Only**: Data shown temporarily, not stored
- **Selective Copy**: User copies specific items, marked as external source
- **Archive Copy**: All data copied to separate archive (not patient record)

**Recommendation**: Keep data at source (DIZRA principle) to maintain currency and transparency.

## Sequence Diagrams

### Publishing Sequence

```
Patient → Healthcare Professional: Give consent
Healthcare Professional → Source System: Record consent
Source System → Nuts Node (Data Holder): Create authorization record
Nuts Node (Data Holder) → Nuts Node (Consumer): Sync authorization record
```

### Consulting Sequence

```
User → Consumer System: Request patient data
Consumer System → Consumer System: Verify treatment agreement/relationship
Consumer System → Nuts Node (Consumer): Query authorization records
Nuts Node (Consumer) → Consumer System: Return available Data Holders
User → Authentication Means: Authenticate
Authentication Means → Consumer System: Signed authentication contract
Consumer System → OAuth Server (Data Holder): Request access token
OAuth Server → Consumer System: Issue access token
Consumer System → FHIR API (Data Holder): Query resources with token
FHIR API → Consumer System: Return authorized resources
Consumer System → User: Display data
```

## FAIR Principles

### Findable
- Authorization records enable discovery of available data
- Data Holder identifiers in records

### Accessible  
- HTTPS/mTLS transport
- OAuth 2.0 authentication/authorization
- Open protocols

### Interoperable
- FHIR R4 standard
- ZIB-based profiles
- Standardized authorization records

### Reusable
- Clear purpose of use
- Detailed provenance
- Domain standards compliance
