# =================================================================
#
# Author: Joost van Ulden <joost.vanulden@canada.ca>
#
# Copyright (c) 2020 Government of Canada
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# =================================================================

FROM debian:sid-20200720-slim

LABEL maintainer="Joost van Ulden <joost.vanulden@canada.ca>" 

LABEL org.opencontainers.image.source="https://github.com/opendrr/python-env"

# copy required files
COPY . .

RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/docker-snapshot.conf && \
    sed -i '/snapshot.debian.org/s/^# //; /deb.debian.org/s/^/# /; s/20200720/20200731/' /etc/apt/sources.list && \
    apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y libpq-dev gcc curl git-lfs gdal-bin python3-pip && \
    pip3 install psycopg2~=2.6 && \
    apt-get autoremove -y gcc && \
    apt-get install -y postgresql-client && \
    pip3 install --upgrade pip && pip install -r requirements.txt

ENV PYTHONUNBUFFERED 1
