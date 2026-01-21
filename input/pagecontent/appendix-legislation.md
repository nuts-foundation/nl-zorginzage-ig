# Appendix A: Legislation

The following legal texts are relevant in relation to the Zorginzage Bolt:

- the WGBO (Medical Treatment Agreement Act - Wet op de geneeskundige behandelovereenkomst)
- the GDPR (General Data Protection Regulation - Algemene Verordening Gegevensbescherming, AVG)
- and possibly the Wegiz (Electronic Health Data Exchange Act - Wet elektronische gegevensuitwisseling in de zorg)

The Wabvpz (Additional Provisions for Processing Personal Data in Healthcare Act - Wet aanvullende bepalingen verwerking persoonsgegevens in de zorg) is not applicable because systems that implement the Nuts Zorginzage Bolt do not meet the definition of an Electronic Exchange System. This is explained in more detail in the section on Electronic Exchange System (Wabvpz) below.

The WDO is not relevant for this application, as it regulates the identification of clients/patients. In the context of Zorginzage, we only deal with the identification of healthcare professionals.

## General Data Protection Regulation (GDPR)

In the GDPR (Article 9 Paragraph 1 of the GDPR and Article 22 paragraph 1 of the UAVG) it states that personal data and special (medical) personal data may not be processed without further justification. This concerns both the data holder and the consumer. The GDPR names 6 legal grounds for processing:

1. Consent of the data subject
2. Performance of a contract
3. Legal obligation
4. Vital interest of the data subject
5. Performance of a task carried out in the public interest
6. Legitimate interest of the organization

For the data holder, the ground of legal obligation applies (in fact a legal contract), this is included in the WGBO. For the consumer, things are somewhat less straightforward. We distinguish between 2 scenarios:

1. Data sharing without referral
2. Data sharing in the context of a referral

Data sharing in the context of a transfer is described in more detail in the Nuts eOverdracht Bolt ([link](https://nuts-foundation.gitbook.io/bolts/eoverdracht/leveranciersspecificatie)).

## Data Sharing Without Referral

There are various situations in which multiple healthcare providers want to have access to each other's registered data without a referral taking place. Two examples:

**Example 1: Home Care and General Practitioner**  
A subject may be in care with a home care institution and a general practitioner. In this case, no referral has taken place. The subject has two separate treatment agreements, one with the home care institution and one with the general practitioner. For sharing data between the home care institution and the general practitioner, explicit consent for sharing data between the home care institution and the general practitioner is therefore necessary.

**Example 2: Integrated Maternity Care**  
A subject may simultaneously be in care with multiple different healthcare providers in the context of integrated maternity care, for example a primary care midwifery practice and a maternity care organization. In this case, no referral has taken place. The subject has two separate treatment agreements, one with the primary care midwifery practice and one with the maternity care organization. For sharing data between the primary care midwifery practice and the maternity care organization, explicit consent for sharing data between the primary care midwifery practice and the maternity care organization is therefore necessary.

The Nuts Zorginzage Bolt requires that the data holder can prove that there is explicit consent in advance or presumed consent. This evidence can, for example, consist of a registration in the source system, a signed document or a digital signature. In the authorization records stored in the Nuts nodes of the data holder and consumer, a reference to this evidence can be included.

## Data Sharing in the Context of a Referral

If there is a referral and the subject has already given consent for the referral, relevant data may be shared in accordance with the WGBO.

The Nuts Zorginzage Bolt requires that the data holder can prove that there is a referral (for which the subject has given consent). This evidence can, for example, consist of a registration in the source system. In the authorization records stored in the Nuts nodes of the data holder and consumer, a reference to this evidence can be included.

The Zorginzage Bolt only supports the consulting of data from the referral process. Other parts of the referral process, such as workflow support, do not fall within the scope.

## Electronic Exchange System (Wabvpz)

The Wabvpz states in Article 15a:

*"The healthcare provider only makes data of the data subject available via an electronic exchange system, insofar as the healthcare provider has established that the data subject has given explicit consent to this."*

An "electronic exchange system" is defined as:

*"a system with which healthcare providers can make records, parts of records or data from records accessible to other healthcare providers electronically, not including a system within a healthcare provider for maintaining an electronic record;"*

The "making accessible" has been more clearly described by Minister Bruins as "making available in advance for unknown later use."

Within the Nuts Zorginzage Bolt, data is indeed made available in advance to the authorized consumer(s) from the moment of creating an authorization record. However, there is no "unknown later use" (for multiple consumers not known in advance) because the authorization is only valid for a specific purpose (specific consumer, specific subject, specific care application, specific data set). Per care application, additional authorization agreements can be made that further define the scope of "later use." For the maternity care application, for example, an authorization only applies to one or more specific episodes related to maternity care (e.g., pregnancies). Systems that implement the Nuts Zorginzage Bolt therefore do not make data available for unknown later use and therefore do not fall under the Wabvpz definition of an "electronic exchange system."

The Wabvpz includes that for data exchange via an "electronic exchange system" explicit consent from the data subject is always necessary. This also relates to the GDPR requirement of consent for processing personal data (in an electronic exchange system). Because no processing of personal data by others than the directly involved healthcare providers takes place and the Wabvpz definition of an "electronic exchange system" does not apply to the Nuts Zorginzage Bolt, the Nuts Zorginzage Bolt is suitable for both viewing based on 'explicit consent in advance' and viewing based on 'presumed consent.'

## Summary

The Zorginzage Bolt provides a standardized way to implement applicable legislation:

1. **GDPR Compliance**: Uses explicit or presumed consent as legal ground for data processing
2. **WGBO Compliance**: Respects treatment agreements and treatment relationships
3. **Not a Wabvpz Electronic Exchange System**: Because authorization is always specific (known consumer, subject, and purpose)
4. **NEN7513 Compliance**: Comprehensive audit logging of all data access
5. **Data Minimization**: Pull mechanism ensures only necessary data is retrieved
6. **Purpose Limitation**: Access is always tied to a specific care application and purpose
