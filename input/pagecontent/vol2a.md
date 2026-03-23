#### Authorization

For authorization, we prefer a fine-grained policy based access model over a role based model. Whether a requestor gets
access to the data they are requesting depends on whether they pass the access-polices of the source (bronhouder).

To ensure everyone uses the same rulesets express policies in a domain specific language called Rego. The input for
evaluating the policies is commonly agreed upon information model. A similar model has been described in the proposal
for the generic function authorization.

See also: https://nuts-foundation.github.io/nl-generic-functions-ig/authorization.html

For policy evaluation the PDP functionality in the Nuts Knooppunt can be integrated with any policy enforcement point.
Policies are version controlled in a Git repository controlled by the Nuts Foundation.

Policy are selected based on the use case scope provided by the Nuts node as part of the authentication process.

The following guidelines should be taken into account when designing new policies.

- ura identifier of requesting organization is mandatory
- when the request is for FHIR endpoint, evaluate conformance to a capability statement
- patient context is mandatory for accessing patient data
  - for search interactions either a patient id or patient bsn must be possible to derive from the query
  - for read interactions the resource should have a direct link to a patient (for example through a patient field)
- patient consent should be checked in a local system or Mitz before returning the data
- check on active treatment relation, optionally in context of specific use case
