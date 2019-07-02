# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for debian-gimp
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.7.0
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
# ========================================================================================
#
#	             Build-time arguements (--build-arg)
#
# ========================================================================================
#
#   ARG_NAME    = version of the library (defaults to "0.1.2")
#   ARG_LIBRARY = name of the lms library (defaults to "lms-library")
#
#   ARG_SOURCE  = url to the requested library
#      (defaults to "https://github.com/ewsdocker/lms-utilities/releases/download/lms-utilities-${ARG_NAME}")
#
# ========================================================================================
#
#   ARGBUILD_REPO = repository name of the image being built
#   ARGBUILD_REGISTRY = registry name of the image being built
#
#   ARGBUILD_NAME = version of the image being built
#   ARGBUILD_VERSION = name of the image being built
#
# ========================================================================================
#
#   ARG_FROM_REPO = repository name of the build-from image
#   ARG_FROM_VERS = version of the build-from image
#   ARG_FROM_PARENT = name of the build-from image parent
#
# ========================================================================================

ARG ARG_NAME="lms-library"
ARG ARG_LIBRARY="0.1.2"

#ARG ARG_SOURCE=http://alpine-nginx-pkgcache

# ========================================================================================

ARG ARGBUILD_REGISTRY=""
ARG ARGBUILD_REPO=ewsdocker

ARG ARGBUILD_NAME="debian-gimp" 
ARG ARGBUILD_VERSION="9.7.0"
ARG ARGBUILD_VERS_EXT=""

ARG ARGBUILD_TEMPLATE="gui"

ARG ARGBUILD_CATEGORIES="Graphics"
ARG ARGBUILD_DESKTOP_NAME="Gimp"
ARG ARGBUILD_ICON="gimp.png"

# ========================================================================================

ARG ARGOPT_QUIET=0

# ========================================================================================

ARG ARG_FROM_PARENT="debian-base-gui"

ARG ARG_FROM_REPO="ewsdocker/debian-base-gui"
ARG ARG_FROM_VERS="9.7.0"
ARG ARG_FROM_EXT="-gtk2"

FROM ${ARG_FROM_REPO}:${ARG_FROM_VERS}${ARG_FROM_EXT}

MAINTAINER Jay Wheeler <ewsdocker@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
 
# ========================================================================================
# ========================================================================================

# ========================================================================================
#
#   Re-declare build-args, but don't change any assignments 
#       (makes the settings available inside the build)
#
# ========================================================================================

ARG ARG_NAME
ARG ARG_LIBRARY

ARG ARG_SOURCE

ARG ARGBUILD_REGISTRY
ARG ARGBUILD_REPO

ARG ARGBUILD_NAME 
ARG ARGBUILD_VERSION
ARG ARGBUILD_VERS_EXT

ARG ARGBUILD_TEMPLATE
ARG ARGBUILD_CATEGORIES
ARG ARGBUILD_DESKTOP_NAME
ARG ARGBUILD_ICON

ARG ARG_FROM_PARENT
ARG ARG_FROM_REPO
ARG ARG_FROM_VERS
ARG ARG_FROM_EXT

ARG ARGOPT_QUIET

# ========================================================================================
# ========================================================================================
#
# https://github.com/ewsdocker/lms-utilities/releases/download/lms-utilities-0.1.2/lms-library-0.1.2.tar.gz
#
# ========================================================================================
# ========================================================================================

ENV \
    \
    LMS_BASE="/usr/local" \
    LMS_HOME= \
    LMS_CONF= \
    \
    \
    LMSBUILD_REGISTRY=${ARGBUILD_REGISTRY} \
    LMSBUILD_REPO=${ARGBUILD_REPO} \
    \
	\
    LMSBUILD_NAME=${ARGBUILD_NAME} \
    LMSBUILD_VERSION=${ARGBUILD_VERSION} \
    LMSBUILD_VERS_EXT=${ARGBUILD_VERS_EXT} \
    LMSBUILD_TEMPLATE=${ARGBUILD_TEMPLATE:-"run"} \
    LMSBUILD_DESKTOP_CATEGORIES=${ARGBUILD_CATEGORIES} \
    LMSBUILD_DESKTOP_NAME=${ARGBUILD_DESKTOP_NAME} \
    LMSBUILD_ICON=${ARGBUILD_ICON}   

ENV LMSBUILD_DOCKER="${LMSBUILD_REPO}/${LMSBUILD_NAME}:${LMSBUILD_VERSION}${LMSBUILD_VERS_EXT}" \
    LMSBUILD_PACKAGE="${ARG_FROM_REPO}:${ARG_FROM_VERS}${ARG_FROM_EXT}" \
    LMSBUILD_BASE="${ARG_FROM_PARENT}:${ARG_FROM_VERS}${ARG_FROM_EXT}"

# ========================================================================================

ENV PKG_VERS="${ARG_LIBRARY}" 

ENV PKG_HOST=${ARG_SOURCE:-"https://github.com/ewsdocker/lms-utilities/releases/download/lms-library-${PKG_VERS}"} \
    PKG_NAME="lms-library-${PKG_VERS}.tar.gz" 

ENV PKG_URL="${PKG_HOST}/${PKG_NAME}"

# =========================================================================

ENV LMSOPT_QUIET=${ARGOPT_QUIET:-"0"}

# =========================================================================

COPY scripts/. /

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
 #
 # =========================================================================
 #
 #   download and install lms-library
 #
 # =========================================================================
 #
 && cd / \
 && wget "${PKG_URL}" \
 && tar -xvf "${PKG_NAME}" \
 && rm "${PKG_NAME}" \
 #
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt  

# =========================================================================

VOLUME /artwork
VOLUME /pictures
VOLUME /workspace
VOLUME /www

#WORKDIR /workspace

# =========================================================================

ENTRYPOINT ["/my_init", "--quiet"]
CMD ["gimp"]
