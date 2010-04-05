#
# Bookmark Jump - bookmarks directories for east access (usage inline)
#
bookmark () {
    RED="\[\033[1;30m\]"
    RESET="\[\033[1;0m\]"

    if [ "$1" == "-l" ]
    then
        # LIST
        echo "[List]"

        awk '{
            # JBLTEST - need to check if a dir exists.
            isdir1=system("test -d "$0)
            if (isdir1) {
                print "["NR"]\t\033[1;31m"$0"\033[1;0m"
            } else {
                print "["NR"]\t"$0
            }
        }' ~/.bookmarks_app
    elif [ "$1" == "-a" ]
    then
        # ADD
        echo "Adding `pwd`"
        echo `pwd` >> ~/.bookmarks_app
    elif [ "$1" == "-g" ]
    then
        # GO
        entry="`awk '{if (NR == s_str) {print $0}}' s_str=$2 ~/.bookmarks_app`"

        if [ "$entry" != "" ]
        then
            cd $entry
            echo "Going to $2"
        else
            echo "No such entry"
        fi
    elif [ "$1" == "-c" ]
    then
        # Just test if the files exists...
        FILE_TO_RM="`awk '{isdir1=system("test -d "$0); if (isdir1) { print $0 } }' ~/.bookmarks_app`"

        for FILE in $FILE_TO_RM; do
            echo "--->>>> $FILE"
            new_file="`awk '{if ($0 !~ s_str) {print $0}}' s_str=$FILE ~/.bookmarks_app`"
            echo "$new_file" > ~/.bookmarks_app
            echo "Removed $FILE from the list."
        done

    elif [ "$1" == "-r" ]
    then
        # REMOVE
        count=`wc -l ~/.bookmarks_app | awk '{print $1}'`

        if [ $2 -le $count ]
        then
            new_file="`awk '{if (NR != s_str) {print $0}}' s_str=$2 ~/.bookmarks_app`"
            echo "$new_file" > ~/.bookmarks_app
            echo "Removed [$2]"
        else
            echo "No such entry"
        fi
    else
        echo "Invalid usage"
        echo "    bm [command] [file]"
        echo "    command: (l)ist"
        echo "    command: (g)oto"
        echo "    command: (r)emove"
		echo "    command: (c)lean, removes all dead bookmarks"
    fi
}
alias bm="bookmark"

