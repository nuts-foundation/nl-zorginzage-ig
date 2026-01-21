# Publishing

Before record data can be viewed, it must be made findable, accessible, interoperable and reusable (FAIR). This is called publishing.

- Record data is **interoperable** when it is structured according to an agreed information standard (for example, in the form of FHIR resources).
- Record data is **accessible** when:
  - it is accessible according to an agreed information standard (for example, in the form of a RESTful FHIR API)
  - authentication and authorization take place according to an agreed standard
- Record data is **findable** when it can be localized by a consumer. Localization concerns answering the following question from a consumer: "At which data holders is data about this subject to be found?"

## Information Standard

Making record data interoperable and standardized accessible falls outside the scope of this Bolt and is explicitly part of information standards (for example, the Information Standard for Maternity Care PWD 3.2). In the Zorginzage Bolt, it is assumed that record data is accessible via an interface specified by a joint information standard (e.g., a RESTful FHIR API). For the correct functioning of an implementation of the Zorginzage Bolt, it is necessary that the management of the information standard used is adequately organized.

## Authorization

Standardized authorization of record data is an essential part of this Bolt. First of all, it is necessary to distinguish between authorization records on the one hand and legal grounds on the other. In the context of this Bolt, an authorization record is a machine-readable right of a healthcare provider to view a certain scope of data about a subject. An authorization record is always based on a legal ground for the processing of personal data. Evidence for a certain legal ground does not necessarily have to be machine-readable. In the case of the legal ground 'consent', the evidence can, for example, consist of a scanned signature or a checked checkbox. However, there may also be verbal consent. For each care application that uses the Zorginzage Bolt, the care application profile describes which legal grounds can be used under which conditions.

This Bolt primarily uses authorization records based on specific consents. These consents can be explicit or presumed.

### Explicit Specific Consent in Advance

An **explicit specific consent in advance** is consent given by the subject to exactly one data holder to make available an agreed scope of record data of that subject to exactly one consumer.

In the case of explicit specific consent in advance, an authorization record is communicated from data holder to consumer as part of the publishing process through the following steps:

1. Subject communicates explicit consent verbally or in writing to a healthcare professional of the data holder.
2. Healthcare professional records the explicit consent of the subject in the source system.
3. The source system communicates this explicit consent in the form of one or more specific authorization records (1 authorization record per intended consumer) to the Nuts node of the data holder.
4. The Nuts node of the data holder stores each authorization record and then communicates it to the Nuts node of the consumer included in that authorization record. The authorization record is always specific to a certain consumer, a certain care application and a certain scope. Per care application, specific additional agreements about authorization records can be described in the care application profile.
5. The Nuts node of the consumer stores the received authorization record.

An important part of authorization is checking the presence of a treatment agreement between the consumer and the subject and the presence of a treatment relationship between the user and the subject. This is part of the Consulting process.

### Presumed Consent

A **presumed consent** is consent to exactly one data holder to make available record data of that subject to exactly one consumer, which arises from a referral from data holder to consumer approved by the subject. In the case of a referral, it is always known which healthcare providers are the data holder and the consumer, so that a presumed consent is always specific in nature.

In the case of a referral, an authorization record is communicated from data holder to consumer as part of the publishing process through the following steps:

1. The subject has previously given consent for a referral from data holder to consumer. By giving consent for a referral, consent for data sharing can be implicitly presumed. This does require that the subject and healthcare professional are well informed about the intended referral and data sharing (informed consent).
2. An employee of the data holder can optionally register (evidence of) the referral in the source system.
3. The source system communicates the presumed consent arising from the referral to the Nuts node of the data holder, in the form of an authorization record.
4. The Nuts node of the data holder stores the authorization record and then communicates it to the Nuts node of the consumer included in that authorization record.
5. The Nuts node of the consumer stores the received authorization record.

### Wabvpz Consent in Advance

In the case of a **Wabvpz consent in advance**, no authorization record is communicated from data holder to consumer.

The Zorginzage Bolt can also support authorization records based on explicit consent for advance availability with multiple healthcare providers not known in advance (via an electronic exchange system) in accordance with Wabvpz (from here: 'Wabvpz consent in advance'). This is consent given by the subject to one specific data holder or to all data holders within a certain category with a treatment agreement with the subject, to make available an agreed scope of record data of that subject to a category of consumers with a treatment agreement with the subject. An example of Wabvpz consent in advance is defined by [Mitz](https://www.programma-otv.nl/documentatie/). When Wabvpz consent in advance is provided with the right cryptographic safeguards, it can be used by a data holder who has implemented the Nuts Zorginzage Bolt for authorization during the consulting process.

## Localization

Within the context of the Nuts Zorginzage Bolt, record data is localized globally in two different ways:

1. **Primary**: Record data is findable based on specific authorization records present in the Nuts node of the consumer. This is described in more detail in the Authorization section above.
2. **Secondary**: Record data is findable via information in a third application, for example Mitz or an application managed by the subject themselves.

The Nuts node of each consumer can easily localize data for which the consumer is authorized based on the stored authorization records. This makes the data findable. In more detail, data localization proceeds according to the following steps:

1. Authorization records containing information about the subject, the data holder, the consumer, the care application and the scope are synchronized between data holder and consumer.
2. Consumer requests active authorization records from its own Nuts node. The identifiers of data holders are included in the authorization records. As a result, the consumer now has an answer to the question "At which data holders is data about this subject to be found that I may view?"
3. Consumer requests endpoints of data holders using the identifiers from the authorization records. As a result, the consumer now has an answer to the question "At which technical endpoints is data about this subject to be found that I may view?"

A Wabvpz consent in advance is different from an explicit specific consent in advance or a presumed consent in that with a Wabvpz consent in advance, no authorization records are synchronized between data holder and consumer (see step 1). Wabvpz consent in advance is developed for broad, less targeted data availability and therefore cannot be used for data localization as described above.

## Implementation of FAIR Principles

Below is described in more detail how the principles of FAIR data are implemented using the Nuts Zorginzage Bolt. This section is not normative.

### Findable

- **F1.** (Meta)data are assigned a globally unique and persistent identifier
  - Part of information standards per care application
- **F2.** Data are described with rich metadata (defined by R1 below)
  - Part of information standards per care application
- **F3.** Metadata clearly and explicitly include the identifier of the data they describe
  - Part of information standards per care application
  - Nuts authorization records contain identifiers of subject and authorized data
- **F4.** (Meta)data are registered or indexed in a searchable resource
  - Data is findable based on specific authorization records present in the Nuts node of the consumer

### Accessible

- **A1.** (Meta)data are retrievable by their identifier using a standardised communications protocol
  - Source systems make data accessible via https
- **A1.1** The protocol is open, free, and universally implementable
  - Nuts standards are open and Nuts software is free and open source
- **A1.2** The protocol allows for an authentication and authorisation procedure, where necessary
  - Covered by the specifications in this implementation guide
- **A2.** Metadata are accessible, even when the data are no longer available
  - Authorization records remain available if desired when the source data is no longer available

### Interoperable

- **I1.** (Meta)data use a formal, accessible, shared, and broadly applicable language for knowledge representation
  - Part of information standards per care application
  - RFC014: Authorization records are standardized
- **I2.** (Meta)data use vocabularies that follow FAIR principles
  - Part of information standards per care application
- **I3.** (Meta)data include qualified references to other (meta)data
  - Part of information standards per care application

### Reusable

- **R1.** (Meta)data are richly described with a plurality of accurate and relevant attributes
  - Part of information standards per care application
- **R1.1.** (Meta)data are released with a clear and accessible data usage license
  - Data may only be used in the context of a relevant legal ground
- **R1.2.** (Meta)data are associated with detailed provenance
  - Part of information standards per care application
- **R1.3.** (Meta)data meet domain-relevant community standards
  - Part of information standards per care application
