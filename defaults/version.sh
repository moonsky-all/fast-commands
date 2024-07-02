#
# 打印输出目标版本
# 如:
# version
# version pnpm
# version npm
# version yarn
# version node
# version nvm
# version mysql
# version java
# version mvn
# version brew
function version {
    local CMD=$1
    local VERSION=$2

    if [ -z "$CMD" ]; then
        CMD="uname"
        VERSION="-a"
    elif [[ $CMD == "--all" ]]; then
        version
        version nvm
        version node
        version nrm
        version npm
        version yarn
        version pnpm
        version java
        version mvn
        version mysql
        version rustup
        version rustc
        version cargo
        version go
        version brew
        version git
        return;
    fi

    if [ -z "$VERSION" ]; then
        if [[ $CMD == "go" ]]; then
            VERSION=$(eval "$CMD version")
        else
            VERSION=$(eval "$CMD --version")
        fi
    elif [ "${VERSION:0:1}" = "-" ]; then
        VERSION=$(eval "$CMD $VERSION")
    fi

    local TYPE=1
    if [[ $VERSION =~ "\n" ]]; then
        TYPE=0
    elif [[ $VERSION =~ "version" ]]; then
        TYPE=0
    fi

    if [[ $VERSION == "" ]]; then
        echo "\033[41;37m[ERROR]\033[0m $CMD"
    elif [ $TYPE -eq 0 ]; then
        echo "\e[1;42m[VERSION]\e[0m $VERSION"
    else
        echo "\e[1;42m[VERSION]\e[0m '$CMD' current version: $VERSION"
    fi
}

