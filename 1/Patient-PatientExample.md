# Patient Example - Maria van den Berg - Netherlands - Zorginzage Implementation Guide v1.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Patient Example - Maria van den Berg**

## Example Patient: Patient Example - Maria van den Berg

Profile: [nl core Patient](https://simplifier.net/resolve?scope=nictiz.fhir.nl.r4.nl-core@0.12.0-beta.4&canonical=http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient)

Maria Anna van den Berg(official) Female, DoB: 1985-03-15 ( http://fhir.nl/fhir/NamingSystem/bsn#123456789 (use: official))

-------

| | |
| :--- | :--- |
| Active: | true |
| Contact Detail | * [+31612345678](tel:+31612345678)
* [maria.vandenberg@example.nl](mailto:maria.vandenberg@example.nl)
* Hoofdstraat 123 Amsterdam 1011 AB NL (home)
 |



## Resource Content

```json
{
  "resourceType" : "Patient",
  "id" : "PatientExample",
  "meta" : {
    "profile" : ["http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient"]
  },
  "identifier" : [{
    "use" : "official",
    "system" : "http://fhir.nl/fhir/NamingSystem/bsn",
    "value" : "123456789"
  }],
  "active" : true,
  "name" : [{
    "use" : "official",
    "text" : "Maria Anna van den Berg",
    "family" : "van den Berg",
    "given" : ["Maria", "Anna"],
    "_given" : [{
      "extension" : [{
        "url" : "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier",
        "valueCode" : "BR"
      }]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier",
        "valueCode" : "BR"
      }]
    }]
  }],
  "telecom" : [{
    "system" : "phone",
    "_system" : {
      "extension" : [{
        "url" : "http://nictiz.nl/fhir/StructureDefinition/ext-CodeSpecification",
        "valueCodeableConcept" : {
          "coding" : [{
            "system" : "http://terminology.hl7.org/CodeSystem/v3-AddressUse",
            "code" : "MC",
            "display" : "mobile contact"
          }]
        }
      }]
    },
    "value" : "+31612345678",
    "use" : "home"
  },
  {
    "system" : "email",
    "value" : "maria.vandenberg@example.nl",
    "use" : "home"
  }],
  "gender" : "female",
  "birthDate" : "1985-03-15",
  "address" : [{
    "use" : "home",
    "line" : ["Hoofdstraat 123"],
    "city" : "Amsterdam",
    "postalCode" : "1011 AB",
    "country" : "NL"
  }]
}

```
