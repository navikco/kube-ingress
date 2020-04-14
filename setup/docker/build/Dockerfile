# LICENSE CDDL 1.0 + GPL 2.0 + SECURUS-MW-KUBE 1.0
#
# KUBE DOCKER
# ----------
# This Dockerfile extends CentOS 7 OpenJDK 8 as Base Image
# It builds KUBE Microservice on top of it with Configurable -
    ## Environment / Active Profile (freeride, green, blue etc.)
    ## Microservice (${kubeMicroservice}, esp-rules etc.)
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Clone/Checkout All KUBE Microservices Project from GitHub
# Checkout Bitbucket Repo for KUBE/ESP Microservice - https://github.com/navikco/kube-ingress.git
#
# Run:
#      $ cd kube-ingress/setup/scripts/
#	   $ ./buildKubeContainerImage.sh accounts
#
# Access:
#      # Access your Microservice running as DOCKER Container at
#           https://localhost:8080/kube/customers/info/index.html

# Pull base image
# ---------------
FROM parrotstream/centos-openjdk:8

# Maintainer
# ----------
MAINTAINER NAVIKCO <NAVIK.HUB@GMAIL.COM>

ARG kubeMicroservice

# KUBE Setup as Root
USER root
VOLUME ["/opt/mw/mount"]
RUN mkdir -p /opt/mw/apps/kube/
WORKDIR /opt/mw/apps/kube/
ADD ./ .

RUN ./bin/setupKUBE.sh ${kubeMicroservice}

# KUBE Docker Container Run as kubeadmin
USER kubeadmin

WORKDIR /opt/mw/apps/kube/bin/
#Start KUBE Microservice with Elastic Search
ENTRYPOINT ["/opt/mw/apps/kube/bin/startKUBE.sh"]
