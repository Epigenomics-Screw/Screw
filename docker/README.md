# Docker containers for SCREW and SIDEARM workflows

The goal is to provide Docker containers for running individual tools in **SCREW** and **SIDEARM** workflows. This github repository contains a set of **Dockerfile** descriptors and is designed to be linked by **Dockstore**.
In the future changes in this repository will automatically trigger a rebuild process in **Dockstore**.
Docker files should follow [best practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/).

![](https://github.com/ga4gh/dockstore/wiki/dockstore_overview.png)

The workflows are described in CWL and linked with the corresponding docker images using "Hints" section.
This section tells CWL runner to pull docker images from a public **quay.io** or **dockerhub.org** repository.

![](https://dockstore.org/docs/dockstore_lifecycle.png)

## The structure of container storage
The main path to container repositories is https://quay.io/epigenomic_screw/screw

We created a hierarchy of **base** docker containers in order to simplify their maintenance:
* base (ubuntu xenial) - development packages, R and Python
* screw (base) - single cell BS methylation data analysis software

* sidearm (base) temporary container

## Data containers
In addition we provide several **data** containers that can be combined with tool containers.

* Viruses 1.1
* XXXXXX GEO ??

