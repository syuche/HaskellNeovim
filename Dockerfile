FROM centos:centos7

# Import the Centos-7 RPM GPG key to prevent warnings
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7
RUN rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7

# system update
RUN yum -y update && yum clean all

# set locale
RUN yum reinstall -y glibc-common && yum clean all
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

# ===============================================================================================================
# BASE packages
# ===============================================================================================================
RUN yum --enablerepo=extras clean metadata
RUN yum install -y zlib zlib-devel make gcc gcc-c++ openssl openssl-devel readline-devel pcre pcre-devel
RUN yum install -y openssh openssh-server
RUN yum install -y net-tools wget sudo
RUN yum install -y tar zip unzip bzip2 which tree
RUN yum install -y git

# Python for Neovim
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y python36u python36u-libs python36u-devel python36u-pip
RUN pip3.6 install neovim

# Neovim
RUN yum -y install epel-release
RUN curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo 
RUN yum -y install neovim

# dein.vim install
RUN mkdir -p ~/.cache/dein
RUN cd ~/.cache/dein; \
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh; \
    sh ./installer.sh ~/.cache/dein

# dein.vim setting
RUN mkdir -p ~/.config/nvim/dein/toml
COPY init.vim /root/.config/nvim/init.vim
COPY dein.toml /root/.config/nvim/dein/toml/dein.toml

# haskell stack
RUN curl -sSL https://get.haskellstack.org/ | sh
# RUN curl -sSL https://s3.amazonaws.com/download.fpcomplete.com/centos/7/fpco.repo | sudo tee /etc/yum.repos.d/fpco.repo
# RUN yum install -y stack
RUN stack install stylish-haskell
RUN stack install hlint
RUN stack install hindent
RUN rm -f /root/.stack/global-project/stack.yaml
COPY stack.yaml /root/.stack/global-project/stack.yaml
RUN stack build ghc-mod
