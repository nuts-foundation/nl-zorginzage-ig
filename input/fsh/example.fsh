// Example Patient for Zorginzage IG
Instance: PatientExample
InstanceOf: http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient
Usage: #example
Title: "Patient Example - Maria van den Berg"
Description: "Example patient with BSN identifier for Zorginzage scenarios"

* identifier[bsn].use = #official
* identifier[bsn].system = "http://fhir.nl/fhir/NamingSystem/bsn"
* identifier[bsn].value = "123456789"

* name.use = #official
* name.family = "van den Berg"
* name.given = "Maria"
* name.given[+] = "Anna"

* gender = #female
* birthDate = "1985-03-15"

* address.use = #home
* address.line = "Hoofdstraat 123"
* address.city = "Amsterdam"
* address.postalCode = "1011 AB"
* address.country = "NL"

* telecom[0].system = #phone
* telecom[0].value = "+31612345678"
* telecom[0].use = #mobile

* telecom[1].system = #email
* telecom[1].value = "maria.vandenberg@example.nl"
* telecom[1].use = #home

* active = true
