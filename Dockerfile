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
      libatlas-base-dev

# Create directories
RUN mkdir -p /usr/local/ART/bin

# Add required binaries
COPY filestoadd/3dwarper.gz /usr/local/ART/bin/3dwarper.gz
COPY filestoadd/acpcdetect_v2.0_LinuxCentOS6.7.tar.gz \
    /usr/local/ART/acpcdetect_v2.0_LinuxCentOS6.7.tar.gz
COPY filestoadd/applywarp3d.gz /usr/local/ART/bin/applywarp3d.gz

# Unzip to directories
RUN cd /usr/local/ART && \
    tar -zxf acpcdetect_v2.0_LinuxCentOS6.7.tar.gz
RUN cd /usr/local/ART/bin && gunzip 3dwarper.gz
RUN cd /usr/local/ART/bin && gunzip applywarp3d.gz

# Configure executables
RUN chmod +x /usr/local/ART/bin/3dwarper
RUN chmod +x /usr/local/ART/bin/applywarp3d
RUN chmod +x /usr/local/ART/bin/acpcdetect

# Remove old files
RUN rm /usr/local/ART/acpcdetect_v2.0_LinuxCentOS6.7.tar.gz

# Add directories to PATH
ENV PATH "$PATH:/usr/loca/ART/bin"
ENV ARTHOME=/usr/local/ART

# Create executables
RUN echo '#!/bin/bash\n/usr/local/ART/bin/3dwarper "$@"' > /usr/bin/3dwarper && chmod +x /usr/bin/3dwarper
RUN echo '#!/bin/bash\n/usr/local/ART/bin/acpcdetect "$@"' > /usr/bin/acpcdetect && chmod +x /usr/bin/acpcdetect
RUN echo '#!/bin/bash\n/usr/local/ART/bin/applywarp3d "$@"' > /usr/bin/applywarp3d && chmod +x /usr/bin/applywarp3d
