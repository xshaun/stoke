#!/bin/bash

echo "[setup.sh] TRAVIS=$TRAVIS"
# install packages
apt-get update
apt-get install -y software-properties-common
add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt-get update && apt-get install -y \
  antlr \
  autoconf \
  bison \
  ccache \
  cmake \
  doxygen \
  exuberant-ctags \
  flex \
  g++-multilib \
  ghc \
  git \
  libantlr3c-dev \
  libboost-dev \
  libboost-filesystem-dev \
  libboost-regex-dev \
  libboost-thread-dev \
  libboost-iostreams-dev \
  libcln-dev \
  libghc-regex-compat-dev \
  libghc-regex-tdfa-dev \
  libghc-split-dev \
  libgmp-dev \
  libjsoncpp-dev \
  libiml-dev \
  libpqxx-dev \
  libtool \
  openssh-server \
  pccts \
  pkg-config \
  python \
  subversion \
  time \
  vim

# SSH setup/config
mkdir /var/run/sshd
chmod 0755 /var/run/sshd
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
echo "export VISIBLE=now" >> /etc/profile
sed -i "s/stoke:.*/stoke:\$1\$bXW0K4Te\$5UHZQ8CHFS\/RkwfnN6.FS.:17947:0:99999:7:::/" /etc/shadow
usermod -a -G sudo stoke

# gcc setup
#update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9

# Compile everything, etc.
chown -R stoke /home/stoke/base
cd /home/stoke/base
chmod +x scripts/docker/base-user-setup.sh
su stoke -c "TRAVIS=$TRAVIS ./scripts/docker/base-user-setup.sh"
