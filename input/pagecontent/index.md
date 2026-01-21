# Netherlands Zorginzage Implementation Guide

## Overview

The Zorginzage (Healthcare Viewing) Implementation Guide enables healthcare professionals to securely view patient data across organizational boundaries using FHIR, OAuth 2.0, and decentralized trust infrastructure.

## Key Features

- **Secure Access**: Healthcare professionals view data from other organizations with proper authorization
- **Patient Control**: Patients control access through consent management  
- **Standards-Based**: FHIR R4, OAuth 2.0, Nuts decentralized network
- **Pull Architecture**: Data retrieved on-demand, not pushed
- **Comprehensive Auditing**: NEN7513 compliant logging

## Quick Start

1. **[Introduction](introduction.html)** - Scope, use cases, and key concepts
2. **[Actors & Transactions](actors-transactions.html)** - System roles and interactions
3. **[Process Flow](process-flow.html)** - Publishing and consulting workflows
4. **[Security](security-considerations.html)** - Authentication and authorization
5. **[Specifications](specifications.html)** - Technical implementation details

## Core Concepts

### Authorization Records
Machine-readable credentials specifying who can access what data for which patient and purpose.

### Care Applications  
Domain-specific profiles (maternity care, medication overview, etc.) with their own governance and access policies.

### Actors
- **Data Holder**: Maintains and provides access to patient data
- **Consumer**: Retrieves patient data on behalf of users
- **Authorization Registry**: Stores and syncs authorization records
- **OAuth Server**: Issues access tokens

## Standards Used

**International**: FHIR R4, OAuth 2.0, JWT, mTLS, Verifiable Credentials

**Dutch National**: ZIBs (Healthcare Information Building Blocks), Nictiz FHIR profiles, Nuts network, UZI/IRMA authentication, NEN7513 audit logging

## Implementation

Systems must implement:
- Authorization record creation/validation
- User authentication (UZI or IRMA)
- OAuth 2.0 token flow
- FHIR R4 API
- Mutual TLS
- NEN7513 audit logging

## Support

- **Nuts Community**: [nuts.nl](https://nuts.nl)
- **Nictiz Standards**: [nictiz.nl](https://nictiz.nl)
- **Technical Docs**: [Nuts RFCs](https://nuts-foundation.gitbook.io/drafts)

---

**Version**: 0.1.0 (Draft) | **License**: EUPL 1.2 | **Publisher**: Stichting Nuts
