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
RUN chmod +x /usr/local/art/bin

# Add directories to PATH
ENV PATH "$PATH:/usr/local/art/bin"
ENV ARTHOME=/usr/local/art

# Create executables
RUN echo '#!/bin/bash\n/usr/local/art/bin/3dwarper "$@"' > /usr/local/art/bin/3dwarper && chmod +x /usr/local/art/bin/3dwarper
RUN echo '#!/bin/bash\n/usr/local/art/bin/acpcdetect "$@"' > /usr/local/art/bin/acpcdetect && chmod +x /usr/local/art/bin/acpcdetect
RUN echo '#!/bin/bash\n/usr/local/art/bin/applywarp3d "$@"' > /usr/local/art/bin/applywarp3d && chmod +x /usr/local/art/bin/applywarp3d
RUN echo '#!/bin/bash\n/usr/local/art/bin/art2 "$@"' > /usr/local/art/bin/3dwarper && chmod +x /usr/local/art/bin/art2
RUN echo '#!/bin/bash\n/usr/local/art/bin/multiplyTransformation "$@"' > /usr/local/art/bin/3dwarper && chmod +x /usr/local/art/bin/multiplyTransformation
RUN echo '#!/bin/bash\n/usr/local/art/bin/scaleImage "$@"' > /usr/local/art/bin/3dwarper && chmod +x /usr/local/art/bin/scaleImage
RUN echo '#!/bin/bash\n/usr/local/art/bin/unwarp2d "$@"' > /usr/local/art/bin/3dwarper && chmod +x /usr/local/art/bin/unwarp2d
