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
RUN echo 'PATH="/usr/loca/ART/bin"'
ENV ARTHOME=/usr/local/ART

# Create aliases
RUN echo 'alias 3dwarper="./usr/local/ART/bin/3dwarper"' >> ~/.bashrc
RUN echo 'alias acpcdetect="./usr/local/ART/bin/acpcdetect"' >> ~/.bashrc
RUN echo 'alias applywarp3d="./usr/local/ART/bin/applywarp3d"' >> ~/.bashrc
