## below part is to install toolchain, this part only for vsi intall environment
toolchain_path=~/.toolchain
toolchain_URL=http://coding-app1.verisilicon.com/shared/tools/
toolchain_name=gcc-arm-linux-gnueabi-8.3
suffix=.tgz
tmpdir=/tmp/

#toolchain name fixed
function install_toolchain()
{
    #local toolchain_name=$1
    #skip if the toolchain exist
    if [ -d ${toolchain_path}/${toolchain_name} ]; then
        return
    fi

    echo "Download and install toolchain: ${toolchain_name}${suffix}"
    rm -rf ${toolchain_name}${suffix}
    wget -q ${toolchain_URL}/${toolchain_name}${suffix}
    if [[ $? = 0 && -f ${toolchain_name}${suffix} ]]; then
        local tmpdir=$(mktemp -d)
        tar xzf ${toolchain_name}${suffix} -C ${tmpdir}
        if [ $? = 0 ]; then
            mv ${tmpdir}/${toolchain_name} ${toolchain_path}
        else
            exit 1
        fi
        rm ${toolchain_name}${suffix}
        return
    fi

    echo "toolchain cannot be found on server: ${toolchain_name}"

    exit 1
}

install_toolchain

## HOME DIR is the directory of the project, the default is the upperlevel of current paddle-lite
## change the home dir to other directory if you want other locatio to save download tim-vx code.
## never set home_dir to / for permission issue
## TOOL_CHAIN is the location of toolchain, for vs680 it use gcc-arm-linux-gnueabihf

export HOME_DIR=`pwd`/..
export TOOL_CHAIN=~/.toolchain/gcc-arm-linux-gnueabi-8.3
export PATH=$PATH:${TOOL_CHAIN}/bin
export ARCH=arm32
export CROSS_COMPILE=arm-linux-gnueabihf-

mkdir -p ${HOME_DIR}/tim-vx

./lite/tools/build_linux.sh --with_extra=ON --with_log=ON --with_nnadapter=ON --nnadapter_with_verisilicon_timvx=ON --nnadapter_verisilicon_timvx_viv_sdk_root=${HOME_DIR}/tim-vx full_publish
