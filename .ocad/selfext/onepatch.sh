#!/bin/bash
#__author__:Open-CAD
#__version__: V0.4

#Argv define

#Func define
usage(){
    echo -e "\E[1;32mUsage :
    1patch V0.3
    ./1patch -options installDirectory
         options: 
             [-noecc ] : Used for tools \E[1;31mwithout ECC check\E[1;32m patch
             [-ecc ]   : Used for tools \E[1;31mwith ECC check\E[1;32m patch
             [-jre ]   : Used for \E[1;31mjava\E[1;32m patch
         InstallDirectory:
             The tools you want to patch.
         Example:
            ./1patch.sh -ecc /software/syn2019 \E[0m";
    exit 0; 
}

noeccPatch(){
    if [ ! -d $1 ]; then
        echo -e "\E[1;31m\n<ERROR-1> Cannot access directory:$1.Exit...\n\E[0m";
        exit 255;
    fi
    echo -e "\E[1;32m\n<INFO-1> Start patching...\n\E[0m"
    sleep 3
    libcStr="`/usr/lib/libc.so.6 | grep 'GNU C Library'`"
    libcStr=($libcStr)
    libcVerStr=${libcStr[8]}
    libcVer=${libcVerStr:0-5:4}
    if [[ $libcVer < 2.17 ]]; then
      ./.ocad/selfext/sfk-gc212-64.exe rep -yes -pat -bin /5589E557565381ECD00000008B5508/31C0C357565381ECD00000008B5508/ -bin /5589E557565381ECD8000000E8000000005B81C3/33C0C357565381ECD8000000E8000000005B81C3/ -bin /41574989FF415641554154554889CD534489C3/33C0C389FF415641554154554889CD534489C3/ -dir $1
    else
      ./.ocad/selfext/sfk-64.exe rep -yes -pat -bin /5589E557565381ECD00000008B5508/31C0C357565381ECD00000008B5508/ -bin /5589E557565381ECD8000000E8000000005B81C3/33C0C357565381ECD8000000E8000000005B81C3/ -bin /41574989FF415641554154554889CD534489C3/33C0C389FF415641554154554889CD534489C3/ -dir $1
    fi
    echo -e "\E[1;32m\n<INFO-2> Patched:$1...\n\E[0m"
    rm -rf .ocad/
    exit 0
}

eccPatch(){
    if [ ! -d $1 ]; then
        echo -e "\E\n[1;31m<ERROR-1> Cannot access directory:$1.Exit...\E\n[0m";
        exit;
    fi
    sleep 3
    currentDir=`pwd`
    echo -e "\E[1;34m\n<INFO-1> Current directory: $currentDir\n\E[0m"
    cd $1 && echo -e "\E[1;34m\n<INFO-3> Change directory to: $1...\n\E[0m"
    echo -e "\E[1;32m\n<INFO-2> Start patching...\n\E[0m"
    sleep 3
    $currentDir/.ocad/selfext/pubkey_verify -y
    $currentDir/.ocad/selfext/pubkey_checksum -y
    echo -e "\E[1;32m\n<INFO-3> Patched:$1...\n\E[0m"
    cd $currentDir && echo -e "\E[1;34m\n<INFO-6> Go back to: $currentDir...\n\E[0m"
    rm -rf $currentDir/.ocad/
    exit 0
}

javaPatch(){
    if [ ! -d $1 ]; then
        echo -e "\E[1;31m\n<ERROR-1> Cannot access directory:$1.Exit...\n\E[0m";
        exit 255;
    fi
    sleep 3
    currentDir=`pwd`
    echo -e "\E[1;34m\n<INFO-1> Current directory: $currentDir\n\E[0m"
    cd $1 && echo -e "\E[1;34m\n<INFO-3> Change directory to: $1...\n\E[0m"
    echo -e "\E[1;32m\n<INFO-2> Start patching...\n\E[0m"
    sleep 3
    echo -e "\E[1;32m\n<INFO-3> Searching...\n\E[0m"
    $currentDir/.ocad/selfext/pubkey_verify_java
    echo -e "\E[1;32m\n<INFO-4> Patching...\n\E[0m"
    $currentDir/.ocad/selfext/pubkey_verify_java -y
    echo -e "\E[1;32m\n<INFO-5> Patched:$1...\n\E[0m"
    cd $currentDir && echo -e "\E[1;34m\n<INFO-6> Go back to: $currentDir...\n\E[0m"
    rm -rf $currentDir/.ocad/
    exit 0

}

run(){
    case $1 in 
        "-h" | "-help" | "--help")
            usage ;; 
        "-ecc")
            eccPatch $2 ;;
        "-noecc")
            noeccPatch $2 ;;
        "-jre")
            javaPatch $2 ;;
        *)
            echo -e "\E[1;34m\n<WARN> Unknown options: \E[1;31m$1 \n\E[0m"
            usage ;;
    esac
}

#Run below
run $1 $2




        
