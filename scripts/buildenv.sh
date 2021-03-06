#!/bin/bash
export TOOLCHAIN="/home/zefie/dev/g6dev/toolchains/uber/out/aarch64-linux-android-6.x/bin/aarch64-linux-android-"

if [ -z "${WORKSPACE}" ]; then
	if [ "${JOB_BASE_NAME}" != "lg-g6-kernel" ]; then
		export TOOLCHAIN="${WORKSPACE}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
	fi
fi

export KERNEL_NAME="Melina" # please change from Melina for custom builds
export KERNEL_DEVNAME="${USER}" # can be normal name, defaults to linux username ;)

export ANDROID_TARGET="STOCK" # Could be Lineage-14.0, or whatever. Just for zip name.
export KERNEL_BUILDDIR="build" # A subdirectory in this repo that is in .gitignore and doesn't already exist. Best just leave it be.

# These can be overridden by the env, using vars that replace DEFAULT_ with KERNEL_, ex: KERNEL_DEVMODEL
export DEFAULT_MANU="LG" # for zip filename
export DEFAULT_MODEL="G6" # for zip filename
export DEFAULT_DEVMODEL="US997" # for zip filename, and anykernel whitelist (converted to lowercase for whitelist)


# Do not edit below this line

export SUPPORTED_MODELS="US997 H870"
export PATH="${PWD}/.zefie/lz4demo:${PATH}"
export ARCH="arm64"
export KERNEL_NAME_LOWER="$(echo "${KERNEL_NAME}" | tr '[:upper:]' '[:lower:]')"
export DEFCONFIG_DIR="arch/${ARCH}/configs"

# Allow env override
if [ -z "${TC_NAME}" ]; then export TC_NAME="${ZEFIE_TC_NAME}"; fi
if [ -z "${TC_TYPE}" ]; then export TC_TYPE="${ZEFIE_TC_TYPE}"; fi
if [ -z "${TC_VER}" ]; then export TC_VER="${ZEFIE_TC_VER}"; fi
if [ -z "${KERNEL_MANU}" ]; then export KERNEL_MANU="${DEFAULT_MANU}"; fi
if [ -z "${KERNEL_MODEL}" ]; then export KERNEL_MODEL="${DEFAULT_MODEL}"; fi
if [ -z "${KERNEL_DEVMODEL}" ]; then export KERNEL_DEVMODEL="${DEFAULT_DEVMODEL}"; fi
export KERNEL_DEVMODEL_LOWER="$(echo "${KERNEL_DEVMODEL}" | tr '[:upper:]' '[:lower:]')"

export CROSS_COMPILE="${TOOLCHAIN}"

if [ "$(basename $0)" == "buildenv.sh" ]; then
	if [ ! -z "$1" ]; then
		$@
	fi
fi

