# Dockerfile documentation can be found at:
# https://docs.docker.com/reference/builder/

FROM centos:centos6

RUN yum -y update; yum clean all

# Install 'Extra Packages for Linux'
# https://fedoraproject.org/wiki/EPEL
RUN yum -y install epel-release; yum clean all

## Install Apache + MySQL + PHP and some command line utilities
RUN yum -y install httpd mysql mysql-server php php-mysql php-gd pwgen supervisor tar; yum clean all

ADD ./docker-template/start.sh          /root/start.sh
ADD ./docker-template/foreground.sh     /etc/apache2/foreground.sh
ADD ./docker-template//supervisord.conf  /etc/supervisord.conf

RUN echo %sudo	ALL=NOPASSWD: ALL >> /etc/sudoers

RUN chmod 755 /root/start.sh /etc/apache2/foreground.sh

VOLUME ["/var/www/html"]

EXPOSE 80

#CMD ["/bin/bash", "/root/start.sh"]










# LICENSE
#
# This is free and unencumbered software released into the public domain.
# 
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
# 
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
# 
# For more information, please refer to [http://unlicense.org]