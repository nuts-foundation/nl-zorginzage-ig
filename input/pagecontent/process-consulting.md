# Consulting

Consulting is the actual retrieval and viewing of record data by an individual healthcare professional (user) from a consumer.

Retrieving medical data is an action that cannot take place without the intervention of a user. Instead, it always requires a conscious action by a user. This user identifies and authenticates themselves with an authentication means that complies with RFC002 so that the data holder can be certain who is requesting the data.

Consulting consists of the following steps:

1. The consumer system checks whether there is a treatment agreement between the consumer and the subject.
2. The consumer system checks whether there is a treatment relationship (involvement in treatment) between the logged-in user and the subject.
3. The consumer system checks with the Nuts node of the consumer whether there is one or more valid authorization records.
4. The user identifies themselves with an authentication means resulting in a cryptographically signed authentication contract. Additional requirements regarding user authentication (e.g., regarding the lifespan or repeated use of the authentication contract) can be included in the care application profile.
5. The consumer system requests an access token for the authenticated user per data holder from the Nuts node of the data holder, via the Nuts node of the consumer. Multiple authorization records (from 1 data holder) can be bundled in 1 token request.
6. The consumer system requests the data from the source system using the access token.
7. The data holder evaluates incoming data requests and applies the applicable access policy. This access policy differs per care application and is determined in close coordination with the administrator of the relevant information standard.

## Handling Retrieved Data

After retrieving the data, it is up to the implementation of the consumer system and the legal and organizational choices of the consumer what is done with it. Broadly, there are the following options:

1. Data is only shown once for viewing
2. Data is shown and the user has the option to copy specific data into their own record or into a separate archive (not in their own record), marked as "copy"
3. All data is directly copied into their own archive (not in their own record)

This choice is a responsibility of the consumer and can be made per care application or individual case. The advice is to implement the DIZRA principle "Data stays at the source" as much as possible. In this way:

- data remains under the responsibility of the data holder;
- it is transparent for the subject which data holders register which health data;
- it is transparent for the subject which persons from which consumers consult this health data; and
- it is not necessary to implement an additional process for updating copied data.
