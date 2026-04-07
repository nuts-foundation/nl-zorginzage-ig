### Authorization

For authorization, we prefer a fine-grained policy based access model over a role based model. Whether a requestor gets
access to the data they are requesting depends on whether they pass the access-polices of the source (bronhouder).

To ensure everyone uses the same rulesets express policies in a domain specific language called Rego. The input for
evaluating the policies is commonly agreed upon information model. A similar model has been described in the proposal
for the generic function authorization.

See also: https://nuts-foundation.github.io/nl-generic-functions-ig/authorization.html

Note: Implementors are free to choose to not implement a Rego-interpreter as part of their authorization solution, as
long as the implemented authorization solution follows the exact same rules as specified in the Rego-policy-file.

For policy evaluation the PDP functionality in the Nuts Knooppunt can be integrated with any policy enforcement point.
Policies are version controlled in a Git repository controlled by the Nuts Foundation.

Policy are selected based on the use case scope provided by the Nuts node as part of the authentication process. A
single name is used that connects the scope, Nuts policy and authentication policy.

The following guidelines should be taken into account when designing new policies.

- ura identifier of requesting organization is mandatory
- when the request is for FHIR endpoint, evaluate conformance to a capability statement
- patient context is mandatory for accessing patient data
    - for search interactions either a patient id or patient bsn must be possible to derive from the query
    - for read interactions the requested resource should have a direct link to a patient (for example through a patient
      field)
- For data requests that require explicit consent, patient consent must be checked in a local system or in Mitz before
  returning the data
- check on active treatment relation, optionally in context of specific use case

For data requests in which explicit consent is not checked, one of the following is mandatory:

- The treatment relation of the data user organisation with the patient is checked technically by the data holder
  organisation (e.g. using a PatientEnrollmentCredential). This treatment relation can be scoped to a
  specific context (e.g. a use case).
- A legal construction has been created in which explicit consent is not necessary. This is not be checked technically.

The treatment relation of the data holder organisation with the patient may be checked technically by the data holder
organisation.
