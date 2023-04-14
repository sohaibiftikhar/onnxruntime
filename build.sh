#!/bin/bash
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

# Get directory this script is in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
    DIR_OS="MacOS"
else
    DIR_OS="Linux"
fi

if [[ "$*" == *"--ios"* ]]; then
    DIR_OS="iOS"
elif [[ "$*" == *"--android"* ]]; then
    DIR_OS="Android"
fi

#requires python3.6 or higher
options=${@:-"--build_shared_lib --parallel --cmake_extra_defines CMAKE_C_COMPILER=/usr/bin/clang --cmake_extra_defines CMAKE_CXX_COMPILER=/usr/bin/clang++ --skip_tests"}
if [[ "$options" == "install" ]]; then
    cmake --install build/Linux/RelWithDebInfo/ --prefix build/install/Linux/RelWithDebInfo/
else
    python3 $DIR/tools/ci_build/build.py --build_dir $DIR/build/$DIR_OS --config RelWithDebInfo $options
fi
