#!/bin/sh
set -e # exit on an error

ERROR(){
    /bin/echo -e "\e[101m\e[97m[ERROR]\e[49m\e[39m $@"
}

WARNING(){
    /bin/echo -e "\e[101m\e[97m[WARNING]\e[49m\e[39m $@"
}

INFO(){
    /bin/echo -e "\e[104m\e[97m[INFO]\e[49m\e[39m $@"
}

exists() {
    type $1 > /dev/null 2>&1
}

for f in $@; do
    case $f in
	'--help' )
	    HELP=1
	    ;;
	'--init-only' )
	    INIT_ONLY=1
	    ;;
	*)
	    ERROR "unknown option $1"
	    exit 1
	    ;;
    esac
    shift
done

if [ "$HELP" ]; then
    echo "usage: $0 [OPTION]"
    echo "  --help                                                Display this message"
    echo "  --init-only                                           Initializes the secret, but does not call docker-compose"
    exit 0
fi

exists ssh-keygen || { ERROR "Please install ssh-keygen (apt-get install openssh-client)"; exit 1; }
exists perl || { ERROR "Please install perl (apt-get install perl)"; exit 1; }

mkdir -p ./secret

if [ ! -f ./secret/id_rsa ]; then
    INFO "Generating key pair"
    ssh-keygen -t rsa -N "" -f ./secret/id_rsa

    cp ./secret/id_rsa.pub ./secret/authorized_keys
else
    INFO "No need to generate key pair"
fi

if [ "$INIT_ONLY" ]; then
    exit 0
fi

chmod -R 700 ./secret

exists docker || { ERROR "Please install docker (https://docs.docker.com/engine/installation/)"; exit 1; }
exists docker-compose || { ERROR "Please install docker-compose (https://docs.docker.com/compose/install/)"; exit 1; }

INFO "Running \`docker-compose build\`"
docker-compose build

INFO "Running \`docker-compose up\`"
docker-compose up -d

docker attach jepsen-control

