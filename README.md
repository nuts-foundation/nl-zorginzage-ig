# Zorginzage Implementation Guide

This repository contains the source of the Zorginzage Implementation Guide (IG), a FHIR R4 implementation guide
published by the [Nuts community](https://nuts.nl).

- Latest release: https://nuts-foundation.github.io/nl-zorginzage-ig/
- Current development version (main): https://nuts-foundation.github.io/nl-zorginzage-ig/current/

## What is Zorginzage?

Zorginzage ("care insight") lets healthcare professionals view patient data that is stored at other healthcare
organisations, in a way that is user-friendly, secure and scalable. Think of a general practitioner viewing the
observations recorded by a home care organisation, or care providers in maternity care viewing each other's records.

Zorginzage is not a use case in itself. It provides the generic building blocks that a use case needs:
identification, authentication, addressing, localisation, authorisation, consent, network security, and the FHIR
transactions to fetch the data. To design a use case, you build on these blocks and specify only what is particular
to it, such as which data is exchanged, between which organisations, and under which conditions. Use cases that
share the same building blocks don't each have to define their own, and are realised faster.

The building blocks support the exchange patterns "pull" (*gericht bevragen*) and "indexed pull"
(*geïndexeerd bevragen*), as described in the
[Whitepaper Communicatiepatronen](https://www.datavoorgezondheid.nl/documenten/2025/07/14/whitepaper-communicatiepatronen-vws)
of the Dutch Ministry of Health (VWS).

Participants take on two roles: the *data holder organisation* makes its data available to other organisations, and the *data user organisation*
views data held elsewhere. Participation is reciprocal: participants only make data available to parties that do the
same according to this specification. The specification adopts the national generic functions of the
Gezondheidsinformatiestelsel (GIS), such as addressing and localisation, step by step as they become ready for
implementation.

## Local Development

### Building the IG Locally with Docker

You can build and test the Implementation Guide locally using Docker. This is useful for development and testing before pushing changes.

#### Prerequisites
- Docker installed and running on your system

#### Build the Docker Image

First, build the Docker image that contains all necessary tools (FHIR IG Publisher, Sushi, etc.):

```bash
docker build . -t ig-builder
```

This creates a Docker image named `ig-builder` with all the required dependencies. `make builder` does the same.

#### Run the Build

To build the Implementation Guide, run the following command from the project root:

```bash
docker run --rm --name=ig-builder \
  -v ./input:/app/input \
  -v ./output:/app/output \
  -v ./ig.ini:/app/ig.ini \
  -v ./sushi-config.yaml:/app/sushi-config.yaml \
  ig-builder
```

This command:
- Mounts the `input/` directory containing your FHIR resources
- Mounts the `output/` directory where the built IG will be placed
- Mounts the `ig.ini` and `sushi-config.yaml` configuration files
- Runs the IG publisher to generate the output

`make ig` runs the same command.

#### View the Results

After the build completes:
- The generated IG will be in the `output/` directory
- Open `output/index.html` in a web browser to view the IG
- Check `output/qa.html` for validation results and quality checks
- The build log is printed to the console while the container runs

#### Clean Output Directory

Before rebuilding, you may want to clean the output directory:

```bash
rm -rf ./output/*
```

## Publishing on GitHub Pages

The IG is published on GitHub Pages at the canonical URL https://nuts-foundation.github.io/nl-zorginzage-ig/ by the
workflow `.github/workflows/build_deploy.yml`:

Path | Content | Published on
-----|---------|-------------
`/` | Latest release | Push of the release tag with the highest version
`/<major>/`, e.g. `/1/` | Latest release within a major version | Push of the release tag with the highest version within that major version
`/<version>/`, e.g. `/1.0.0/` | A specific release, never changed afterwards | Push of the release tag `v<version>`
`/current/` | The main branch | Push to main

The `gh-pages` branch keeps all published versions; each deployment publishes the complete branch.

To publish a release:

1. Set `version` in `sushi-config.yaml` to the new version, e.g. `1.1.0`, and merge this to main.
2. Tag the commit on main with `v<version>`, e.g. `git tag v1.1.0 && git push origin v1.1.0`.

The workflow refuses a tag that does not match the `version` in `sushi-config.yaml`. A release tag on a commit that
predates this workflow does not start it; publish such a tag by running the workflow manually from the Actions tab
with the tag (e.g. `v1.0.0`) as input.

## FHIR Implementation Guide Auto-Builder

This FHIR IG is set up to auto-build to https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig or https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/branches/<your-branch>

Notifications of these builds are posted on https://chat.fhir.org/#narrow/stream/179297-committers.2Fnotification/topic/ig-build (this can take 2-3 minutes after a commit to the repo).
The build log of a branch is at https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/branches/<your-branch>/build.log
and its validation results are at https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/branches/<your-branch>/qa.html

You can also trigger a build manually. Use this curl command, and change the branch name `main` to the branch you want to build:

```bash
curl -X POST "https://us-central1-fhir-org-starter-project.cloudfunctions.net/ig-commit-trigger" \
  -H "Content-Type:application/json" \
  --data '{"ref": "refs/heads/main", "repository": {"full_name": "nuts-foundation/nl-zorginzage-ig"}}'
```

## Generating FHIR resources from FSH on your desktop

SUSHI generates FHIR resources from the FSH files. It downloads the dependencies listed in `sushi-config.yaml`, such
as the Dutch nl-core profiles, by itself.

Install Node.js and SUSHI as described in the [SUSHI installation guide](https://fshschool.org/docs/sushi/installation/).
Then generate the FHIR resources from the FSH files with:
```
sushi .
```
