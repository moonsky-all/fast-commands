function version {
    local CMD=$1
    if [ -z "$CMD" ]; then
        echo "Unknown <cmd>"
        return
    fi

    local VERSION=$2
    if [ -z "$VERSION" ]; then
        VERSION=$(eval "$CMD --version")
    elif [ "${VERSION:0:1}" = "-" ]; then
        VERSION=$(eval "$CMD $VERSION")
    fi

    local TYPE=1
    if [[ $VERSION =~ "\n" ]]; then
        TYPE=0
    elif [[ $VERSION =~ "version" ]]; then
        TYPE=0
    fi

    if [ $TYPE -eq 0 ]; then
        echo "\e[1;42m[VERSION]\e[0m $VERSION"
    else
        echo "\e[1;42m[VERSION]\e[0m $CMD current version: $VERSION"
    fi
}

