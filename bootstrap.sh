#!/bin/sh

GITHUB_USER=waynew

command=$1

function show_help(){
    echo "Usage: "
    echo "bootstrap.sh help         Show this message"
    echo "bootstrap.sh              Bootstrap yer dotfiles"
    echo "bootstrap.sh gentoken     Generate GitHub api token"
}

case $command in
    help)
        show_help
        ;;

    gentoken)
        echo "Time to generate token"
        curl https://api.github.com/authorizations \
            --user "$GITHUB_USER" \
            --data '{"scopes": ["repo"], "note":"dotfiles-cli"}' \
            -o auth.json
        if grep -q '"already_exists"' auth.json
        then
            echo "ERROR: token already exists."
            echo "Regenerate your token at https://github.com/settings/applications"
            echo "and place it in token.txt"
            echo "<replace with your token>" > token.txt
        else
            grep -Po '"token":.*?[^\\]",' auth.json | sed 's/"token": "//' | sed 's/".*$//' > token.txt
            echo "Manage your authorizations at https://github.com/settings/applications - this is dotfiles-cli";
        fi
        ;;

    upload)
        # TODO: write uploading stuff
        echo "Upload stuff"
        ;;

    change-user)
        echo $1 $2;
        if [ "$#" -lt 2 ]; then
            printf "Changing GITHUB_USER to: "
            read user
        else
            user=$2
        fi
        cat $0 | sed "0,/GITHUB_USER=.*$/{s/GITHUB_USER=.*$/GITHUB_USER=$user/}" > /tmp/dotfilesbootstrap.sh
        exec /bin/sh -c "mv /tmp/dotfilesbootstrap.sh $0 && chmod +x $0"
        ;;

    *)
        # TODO: download .vimrc and other dotfiles
        user=${1:-$GITHUB_USER}
        repo=${2:-ww.files}
        url=https://github.com/$user/$repo/archive/master.tar.gz
        echo "Downloading dotfiles for $user from $url"
        has_wget=true
        if ! type "wget" > /dev/null; then
            echo "No wget found on path";
            has_wget=false
        fi

        if ! type "curl" > /dev/null; then
            if ! $has_wget; then 
                echo "No curl either, I die!";
                exit 1
            fi
        fi

        if [ has_wget ]; then
            wget -qO- $url | tar xz -C /tmp/
        else
            curl $url | tar xz -C /tmp/
        fi

        mv /tmp/$repo-master/dotfiles ~/test-dotfiles
        ;;
esac
