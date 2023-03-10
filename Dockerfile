FROM centos:latest

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y install openssh-server

RUN yum -y install mysql

RUN yum -y install python3 && \
    python3-pip

RUN pip3 install --upgrade pip3 && \
    pip3 install --upgrade awscli

RUN useradd remote_user && \
  echo "remote_user:1234" | chpasswd && \
  mkdir /home/remote_user/.ssh && \
  chmod 700 /home/remote_user/.ssh
COPY remote-key.pub /home/remote_user/.ssh/authorized_keys