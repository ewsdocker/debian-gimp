# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for debian-gimp
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.6.0
# @copyright © 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-gimp
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2018. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-gimp.
#
#   ewsdocker/debian-gimp is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-gimp is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-gimp.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================
FROM ewsdocker/debian-kaptain:9.6.0-gtk3

MAINTAINER Jay Wheeler <ewsdocker@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
 
# =========================================================================

ENV LMSBUILD_VERSION="9.6.0"
ENV LMSBUILD_NAME=debian-gimp 
ENV LMSBUILD_REPO=ewsdocker 
ENV LMSBUILD_REGISTRY="" 

ENV LMSBUILD_PARENT="gimp 5.2.11"
ENV LMSBUILD_DOCKER="${LMSBUILD_REPO}/${LMSBUILD_NAME}:${LMSBUILD_VERSION}" 
ENV LMSBUILD_PACKAGE="${LMSBUILD_PARENT}, debian-kaptain:9.6.0-gtk3"

# =========================================================================

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install \
               alsa-utils \
               cups-common \
               fonts-droid-fallback \
               gcc \
               gfortran \
               ghostscript \
               gimp \
               gimp-data-extras \
               gimp-help-common \
               gimp-help-en \
               gpm \
               gsfonts \
               gvfs \
               gvfs-backends \
               libaacs0 \
               libasound2-plugins \
               libbluray-bdj \
               libcupsfilters1 \
               libgail-common \
               liblcms2-utils \
               libpaper-utils \
               librsvg2-bin \
               opus-tools \
               poppler-utils \
               pulseaudio \
               python-dev \
               python-gobject-2-dbg \
               python-gtk2-doc \
               python-nose \
               python-numpy-dbg \
               python-numpy-doc \
               speex \
 && apt-get clean all \
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt  

# =========================================================================

COPY scripts/. /

RUN chmod +x /usr/bin/lms/* \
 && chmod 775 /usr/local/bin/* \
 && chmod 600 /usr/local/share/applications/debian-gimp-${LMSBUILD_VERSION}.desktop \
 && chmod 600 /usr/local/share/applications/debian-gimp.desktop  

# =========================================================================

VOLUME /artwork
VOLUME /pictures
VOLUME /workspace
VOLUME /www

#WORKDIR /workspace

# =========================================================================

ENTRYPOINT ["/my_init", "--quiet"]
CMD ["gimp"]
