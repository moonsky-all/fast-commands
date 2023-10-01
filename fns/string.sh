function str-len {
    echo ${#1}
}

alias str-length="str-len"

function str-first() {
    if [[ "$1" =~ ^[0-9]{1,3}$ ]]; then
        if [[ $1 -gt 1 ]]; then
            echo "git rebase -i HEAD~$1"
        else
            echo "git rebase -i HEAD~3"
        fi
    else
        echo "git rebase -i $1"
    fi
}
