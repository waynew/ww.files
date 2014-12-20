GITHUB_USER=waynew


if [ -z $1 ] 
then
    command=help
elif [ -n $1 ] 
then
    command=$1
fi

case $command in
    help)
        echo "Usage: "
        echo "bootstrap.sh help         Show this message"
        echo "bootstrap.sh gentoken     Generate GitHub api token"
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
esac
