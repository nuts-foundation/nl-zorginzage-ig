// Examples for addressing via the generic function Care Service Directory (trial-use)
// The NL-GF profiles are referenced via meta.profile, as the CSD package is not yet available in the FHIR package registry

Alias: $sbi = https://www.cbs.nl/standaard-bedrijfsindeling
Alias: $provenance-participant-type = http://terminology.hl7.org/CodeSystem/provenance-participant-type
Alias: $endpoint-connection-type = http://terminology.hl7.org/CodeSystem/endpoint-connection-type
Alias: $endpoint-payload-type = http://terminology.hl7.org/CodeSystem/endpoint-payload-type
Alias: $nl-gf-authorization-server = http://fhir.generiekefuncties.nl/csd/CodeSystem/nl-gf-authorization-server-cs
Alias: $nl-gf-data-categories = http://fhir.generiekefuncties.nl/csd/CodeSystem/nl-gf-data-categories-cs

Instance: DataHolderOrganizationExample
InstanceOf: Organization
Usage: #example
Title: "Organization Example - Data holder in the LRZa"
Description: "Example data holder organisation as registered in the LRZa, identified by URA and referring to its Nuts authorisation server and its FHIR endpoint for the Patient search"

* meta.profile = "http://fhir.generiekefuncties.nl/csd/StructureDefinition/nl-gf-organization"
* identifier[0].use = #official
* identifier[0].system = "urn:oid:2.16.528.1.1007.3.3"
* identifier[0].value = "12345678"
* identifier[0].assigner.identifier.type = $provenance-participant-type#custodian
* identifier[0].assigner.identifier.system = "urn:oid:2.16.528.1.1007.3.3"
* identifier[0].assigner.identifier.value = "12345678"
* active = true
* type = $sbi#8710 "Residential nursing care activities"
* name = "Zorggroep Voorbeeld"
* endpoint[0] = Reference(DataHolderOAuthEndpointExample)
* endpoint[+] = Reference(DataHolderFhirEndpointExample)

Instance: DataHolderOAuthEndpointExample
InstanceOf: Endpoint
Usage: #example
Title: "Endpoint Example - Nuts authorisation server"
Description: "Example oauth-nuts Endpoint of a data holder organisation, used as authorization_server in the access token request"

* meta.profile = "http://fhir.generiekefuncties.nl/csd/StructureDefinition/nl-gf-endpoint"
* identifier[0].use = #official
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[0].value = "urn:uuid:5d0e6a3c-2f4b-4c1e-9a7d-3b8e1f6c2a90"
* identifier[0].assigner.identifier.type = $provenance-participant-type#custodian
* identifier[0].assigner.identifier.system = "urn:oid:2.16.528.1.1007.3.3"
* identifier[0].assigner.identifier.value = "12345678"
* status = #active
* connectionType = $nl-gf-authorization-server#oauth-nuts "OAuth 2.0 NUTS"
* name = "Nuts authorisation server Zorggroep Voorbeeld"
* managingOrganization.identifier.system = "http://kvk.nl"
* managingOrganization.identifier.value = "87654321"
* managingOrganization.display = "Voorbeeld XIS B.V."
* payloadType = $endpoint-payload-type#any "Any"
* address = "https://nuts.zorggroep-voorbeeld.example.org/oauth2/zorggroep-voorbeeld"

Instance: DataHolderFhirEndpointExample
InstanceOf: Endpoint
Usage: #example
Title: "Endpoint Example - FHIR endpoint for the Patient search"
Description: "Example hl7-fhir-rest Endpoint of a data holder organisation that supports the Patient data category and FHIR R4, used for the Patient search"

* meta.profile = "http://fhir.generiekefuncties.nl/csd/StructureDefinition/nl-gf-endpoint"
* identifier[0].use = #official
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[0].value = "urn:uuid:9b2c4e71-6a3d-4f8e-b05c-1d7a2e9f4c36"
* identifier[0].assigner.identifier.type = $provenance-participant-type#custodian
* identifier[0].assigner.identifier.system = "urn:oid:2.16.528.1.1007.3.3"
* identifier[0].assigner.identifier.value = "12345678"
* status = #active
* connectionType = $endpoint-connection-type#hl7-fhir-rest "HL7 FHIR"
* name = "FHIR endpoint Zorggroep Voorbeeld"
* managingOrganization.identifier.system = "http://kvk.nl"
* managingOrganization.identifier.value = "87654321"
* managingOrganization.display = "Voorbeeld XIS B.V."
* payloadType[0] = $nl-gf-data-categories#Patient "Patient"
* payloadType[+] = $nl-gf-data-categories#ObservationVitalSigns "Observation (category: Vital Signs)"
* payloadMimeType = #"application/fhir+json; fhirversion=4.0"
* address = "https://fhir.zorggroep-voorbeeld.example.org/fhir"
