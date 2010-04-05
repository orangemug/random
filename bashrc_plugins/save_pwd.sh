#
# Save the current directory
#
function save_pwd () {
    if [ "$1" == "-s" ]
    then
        echo "$(pwd)" > ~/.cur_dir
    elif [ "$1" == "-r" ]
    then
        cd "$(cat ~/.cur_dir)"
    elif [ "$1" == "-l" ]
    then
        cat ~/.cur_dir
    else
        echo "Invalid usage"
        echo "    $0 [command]"
        echo "    command: (s)ave"
        echo "    command: (r)estore"
        echo "    command: (l)ist"
    fi
}
alias sd='save_pwd'
