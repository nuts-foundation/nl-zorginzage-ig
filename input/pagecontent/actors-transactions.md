# Actors and Transactions

## Actors

### Data Holder
Maintains patient records and provides FHIR API access. Creates authorization records and issues access tokens.

**Key Responsibilities**:
- Maintain data per information standards
- Create/publish authorization records
- Operate OAuth server
- Validate access tokens
- Apply access policies
- Log all access (NEN7513)

### Consumer
Retrieves patient data on behalf of healthcare professionals.

**Key Responsibilities**:
- Discover available data sources
- Authenticate users
- Request access tokens
- Query FHIR endpoints
- Verify treatment agreements
- Present data to users

### Authorization Registry
Stores and synchronizes authorization records across the network.

**Key Responsibilities**:
- Store authorization records
- Sync across network nodes
- Provide query interface
- Support record lifecycle

### OAuth Authorization Server
Issues access tokens for data access.

**Key Responsibilities**:
- Validate user authentication
- Verify authorization records
- Issue JWT access tokens
- Enforce token expiration

## Transactions

### [ZI-1] Publish Authorization
**From**: Data Holder **To**: Authorization Registry

Creates and publishes authorization record based on patient consent or referral.

### [ZI-2] Query Authorization Records
**From**: Consumer **To**: Authorization Registry

Discovers which Data Holders have accessible data for a patient.

### [ZI-3] Request Access Token
**From**: Consumer **To**: OAuth Authorization Server

Obtains JWT access token based on user authentication and authorization records.

### [ZI-4] Query Healthcare Resources
**From**: Consumer **To**: Data Holder

Retrieves FHIR resources using access token.

## Actor Diagram

```
Data Holder ──[ZI-1]──> Authorization Registry <──[ZI-2]── Consumer
     │                                                        │
     │                                                        │
     └────────[ZI-4] Query Resources─────────────────────────┘
              (with token from [ZI-3])

Consumer ──[ZI-3]──> OAuth Server (at Data Holder)
```

## Content Modules

**Authorization Record**: Verifiable credential specifying access rights (RFC014)

**Access Token**: OAuth 2.0 JWT with user/organization identity and scope

**FHIR Resources**: Patient data based on Nictiz ZIB profiles

## Options

**Data Holder Options**:
- Wabvpz consent support (broad authorization)
- Real-time FHIR generation

**Consumer Options**:
- Multi-source aggregation
- Selective data copying with provenance

## Required Groupings

- Data Holder SHALL be grouped with Authorization Registry and OAuth Server
- Consumer SHALL be grouped with Authorization Registry
