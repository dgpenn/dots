#!/usr/bin/env bash

function print_welcome_msg {
    echo ""
    echo "~ Welcome to $HOSTNAME! ~"
    echo ""
}

function print_get_out_msg {
    echo ""
    echo "This is a *private* server."
    echo "Please disconnect if you are not authorized."
    echo ""
}

function print_update_msg {
    updates=$(checkupdates 2>/dev/null)
    if [[ "$?" -eq 0 ]]; then
        number=$(echo "$updates" | wc -l)
        echo -e "- There is $number update(s) pending."
    fi
}

function print_ssh_msg {
    REMOTE_IP=$(echo "$SSH_CONNECTION" | awk -F' ' '{printf $1}')
    [[ -n "$SSH_CONNECTION" ]] && echo "- SSH Source: $REMOTE_IP"
}

function login_banner {

    print_welcome_msg

    # Print connecting IP on SSH connection
    [[ -n "$SSH_CONNECTION" ]] && print_ssh_msg

    # Print update reminder
    type checkupdates > /dev/null 2>&1 && print_update_msg

    print_get_out_msg

}

login_banner

# Source .bashrc
[[ -f "${HOME}"/.bashrc ]] && . ~/.bashrc
