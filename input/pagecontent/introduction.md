# Introduction

## Scope

Zorginzage enables healthcare professionals to securely view patient data across organizational boundaries. It addresses authorization management, data localization, secure access, audit logging, and FHIR-based interoperability.

### In Scope
- Authorization record creation and distribution
- Data discovery and localization
- User authentication and access control
- NEN7513 audit logging
- FHIR R4 resource access

### Out of Scope
- Complete referral workflow management
- Permanent data transfer between systems
- Direct patient access (PGO)
- Push notifications
- Data creation or modification

## Use Cases

### GP Views Home Care Data
A general practitioner reviews home care vital signs to assess medication needs. Authorization based on explicit patient consent.

### Midwife Accesses Hospital Results
A community midwife views hospital ultrasound results for ongoing pregnancy care. Authorization based on care episode.

### Specialist Retrieves Basic Healthcare Data
A cardiologist accesses the referring physician's Basic Healthcare Data Set (BgZ) using referral-based authorization.

### Pharmacist Checks Medication Overview
A pharmacist retrieves current medication data from multiple sources using broad consent (Wabvpz).

## Glossary

**Consumer** (Afnemer) - Healthcare provider retrieving data from a Data Holder

**Data Holder** (Bronhouder) - Healthcare provider maintaining patient records

**Authorization Record** - Machine-readable credential specifying access rights (who, what, whom, why, when)

**Subject** (Betrokkene) - Patient whose data is accessed

**User** (Gebruiker) - Healthcare professional viewing data

**Care Application** (Zorgtoepassing) - Specific care domain (maternity, BgZ, medication, etc.)

**ZIB** - Healthcare Information Building Block (Zorginformatiebouwsteen)

**Nuts** - Decentralized trust network for healthcare data exchange

**UZI** - Dutch healthcare professional identification (smartcard)

**IRMA** - Privacy-preserving attribute-based authentication

**BSN** - Dutch citizen service number

**NEN7513** - Dutch audit logging standard

**WGBO** - Medical Treatment Agreement Act

**AVG/GDPR** - Data protection regulations

**Wabvpz** - Additional healthcare data processing provisions
