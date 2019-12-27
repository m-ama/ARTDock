# ====================================================================
# ARTDock
# A dockerfile to create a slim build for Babak Ardekani's 
# registration tools for animal image registration
#
# Maintainer: Siddhartha Dhiman
# ====================================================================
LABEL maintainer="dhiman@musc.edu"

# Base for installation
FROM alpine:latest

# Create directories
RUN mkdir -p /usr/local/3dwarper
RUN mkdir -p /usr/local/applywarp3d
RUN mkdir -p /usr/local/acpcdetect

# Add required binaries
COPY filestoadd/3dwarper.gz /usr/local/3dwarper/3dwarper.gz
COPY filestoadd/acpcdetect_v2.0_LinuxCentOS6.7.tar.gz \
    /usr/local/acpcdetect/acpcdetect_v2.0_LinuxCentOS6.7.tar.gz
COPY filestoadd/applywarp3d.gz /usr/local/applywarp3d/applywarp3d.gz

# Unzip to directories
RUN cd /usr/local/3dwarper && gunzip 3dwarper.gz
RUN cd /usr/local/acpcdetect && \
    tar -zxf acpcdetect_v2.0_LinuxCentOS6.7.tar.gz
RUN cd /usr/local/applywarp3d && gunzip applywarp3d.gz

# Configure executables
RUN chmod +x /usr/local/3dwarper/3dwarper
RUN chmod +x /usr/local/applywarp3d/applywarp3d
RUN chmod +x /usr/local/acpcdetect/bin/acpcdetect

# Remove old files
RUN rm /usr/local/acpcdetect/acpcdetect_v2.0_LinuxCentOS6.7.tar.gz

# Add directories to PATH
ENV PATH="/usr/loca/3dwarper:${PATH}"
ENV PATH="/usr/loca/acpcdetect/bin:${PATH}"
ENV PATH="/usr/loca/applywarp3d:${PATH}"
