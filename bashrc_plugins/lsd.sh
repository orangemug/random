#
# lsd - list directory with options to cd by number
# 
# Why: Because tab completion can be a pain in the ass with dirs of similar
#      name. I find this easier.
#
# TODO: Tidy formatting for double numbers. Find out the sprintf command in bash
lsd() {
    action="$1"
    arg="$2"
    # List
    if [[ "$action" == "-l" || "$action" == "" ]]; then
        ls -l | awk '
            BEGIN {
                i=0
            }
            NF==8 && $1~/^d/ {
                print "[\033[1;31m"++i"\033[1;0m] "$0
            }
            NF==8 && $1~/^[^d]/ {
                print "    "$0
            }'
    # Go
    elif [[ "$action" == "-g" ]]; then
        go_dir="$(ls -l | awk -v DIR_NUM=$arg '
            BEGIN {i=0}
            NF==8 && $1~/^d/ {
                ++i;
                if(i==DIR_NUM) {print $8}
            }')"
        cd "$go_dir"
        
        # Doing this after to get full path in output
        echo "Going to \"$(pwd)\""  
    # Show help!
    else
        echo "Invalid usage"
        echo "    $0 [command]"
        echo "    command: (l)ist"
        echo "    command: (g)o <<num>>"
    fi
}
alias lsd="lsd"
