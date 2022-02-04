# ====================================================================
# ARTDock
# A dockerfile to create a slim build for Babak Ardekani's 
# registration tools for animal image registration
#
# Maintainer: Siddhartha Dhiman
# ====================================================================
# Base for installation
FROM ubuntu:bionic
LABEL maintainer="dhiman@musc.edu"
RUN apt-get update && \
      apt-get install -y --no-install-recommends\
      libatlas-base-dev \
      libxm4 \
      libmotif-dev

# Create directories
RUN mkdir -p /usr/local/art

# Add required binaries
ADD art /usr/local/art

# Configure executables
RUN chmod -R +x /usr/local/art/bin

# Add directories to PATH
ENV PATH "$PATH:/usr/local/art/bin"
ENV ARTHOME=/usr/local/art
