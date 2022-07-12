
## HOME DIR is the directory of the project, the default is the upperlevel of current paddle-lite
## change the home dir to other directory if you want other locatio to save download tim-vx code.
## never set home_dir to / for permission issue
## TOOL_CHAIN is the location of toolchain, for vs680 it use gcc-arm-linux-gnueabihf

export HOME_DIR=`pwd`/..
export TOOL_CHAIN=~/project/vs680/Synaptics_Git_Ext_Linux/syna-release/toolchain/aarch32/gcc-arm-linux-gnueabi-8.3
export PATH=$PATH:${TOOL_CHAIN}/bin
export ARCH=arm32
export CROSS_COMPILE=arm-linux-gnueabihf-

mkdir -p ${HOME_DIR}/tim-vx

./lite/tools/build_linux.sh --with_extra=ON --with_log=ON --with_nnadapter=ON --nnadapter_with_verisilicon_timvx=ON --nnadapter_verisilicon_timvx_viv_sdk_root=/home/zhangjf/project/vs680/tim-vx full_publish
