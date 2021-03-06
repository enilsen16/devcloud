#!/bin/bash

set -x
set -e

# update ubuntu packages
sudo apt-get update
sudo apt-get full-upgrade -y
sudo apt-get autoremove

# Add postgres
sudo apt-get install postgresql postgresql-contrib libpq-dev -y
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"

# Install Kerl/Erlang
sudo apt-get install -y make automake gcc autoconf libncurses5-dev

mkdir ~/.kerl
curl -fsSLo ~/.kerl/kerl https://raw.githubusercontent.com/kerl/kerl/master/kerl
chmod +x ~/.kerl/kerl

~/.kerl/kerl update releases
~/.kerl/kerl build git https://github.com/erlang/otp.git maint maint
~/.kerl/kerl install maint ~/.kerl/maint
. /home/ubuntu/.kerl/maint/activate
~/.kerl/kerl cleanup all

# Install elixir
git clone https://github.com/elixir-lang/elixir.git ~/.elixir
cd ~/.elixir
make install
cd ~/

echo "Erlang and Elixir setup"
