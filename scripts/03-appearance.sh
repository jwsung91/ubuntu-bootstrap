#!/bin/bash
set -e

echo "--- D2Coding Nerd Font 설치 ---"
mkdir -p ~/.local/share/fonts
TEMP_DIR=$(mktemp -d)
cd $TEMP_DIR
wget https://github.com/naver/d2codingfont/releases/download/VER1.3.2/D2Coding-Ver1.3.2-20180524.zip
sudo apt install -y unzip
unzip D2Coding-Ver1.3.2-20180524.zip
cp D2Coding/*.ttf ~/.local/share/fonts/
fc-cache -f -v
cd -
rm -rf $TEMP_DIR

echo "--- ColorLS 설치 (Ruby Gem) ---"
sudo apt install -y ruby-full
sudo gem install colorls
