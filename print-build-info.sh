#!/bin/bash
set -e

#bazel build --cpu=k8 //:program

SHA256=`sha256sum bazel-out/k8-fastbuild/bin/program_/program`
LDD_OUTPUT=`ldd --verbose bazel-out/k8-fastbuild/bin/program_/program`

echo "sha256sum bazel-out/k8-fastbuild/bin/program_/program:"
echo "$SHA256"
echo "==========================="
LDD_OUTPUT=`ldd --verbose bazel-out/k8-fastbuild/bin/program_/program`
echo "ldd --verbose bazel-out/k8-fastbuild/bin/program_/program:"
echo "$LDD_OUTPUT"
