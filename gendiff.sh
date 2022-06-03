#!/bin/bash
set -e
sudo docker run --rm $(sudo docker build -q -f Dockerfile.ubuntu1804 .) > output-ubuntu1804.txt
sudo docker run --rm $(sudo docker build -q -f Dockerfile.ubuntu2204 .) > output-ubuntu2204.txt

diff output-ubuntu1804.txt output-ubuntu2204.txt > report.diff
