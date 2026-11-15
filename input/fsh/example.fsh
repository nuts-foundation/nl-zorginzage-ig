// Example Patient for Zorginzage IG
Instance: PatientExample
InstanceOf: http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient
Usage: #example
Title: "Patient Example - Maria van den Berg"
Description: "Example patient with BSN identifier for Zorginzage scenarios"

* identifier[bsn].use = #official
* identifier[bsn].system = "http://fhir.nl/fhir/NamingSystem/bsn"
* identifier[bsn].value = "123456789"

* name[nameInformation].use = #official
* name[nameInformation].text = "Maria Anna van den Berg"
* name[nameInformation].family = "van den Berg"
* name[nameInformation].given[0] = "Maria"
* name[nameInformation].given[0].extension[givenOrInitial].valueCode = #BR
* name[nameInformation].given[1] = "Anna"
* name[nameInformation].given[1].extension[givenOrInitial].valueCode = #BR

* gender = #female
* birthDate = "1985-03-15"

* address.use = #home
* address.line = "Hoofdstraat 123"
* address.city = "Amsterdam"
* address.postalCode = "1011 AB"
* address.country = "NL"

* telecom[telephoneNumbers].system = #phone
* telecom[telephoneNumbers].system.extension[telecomType].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-AddressUse#MC "Mobile Phone"
* telecom[telephoneNumbers].value = "+31612345678"
* telecom[telephoneNumbers].use = #home

* telecom[emailAddresses].system = #email
* telecom[emailAddresses].value = "maria.vandenberg@example.nl"
* telecom[emailAddresses].use = #home

* active = true
