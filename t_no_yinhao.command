#!/bin/bash
### chmod +x 本文件的路径 (无权限的问题)

CURRENT_DIR=$(
    cd $(dirname $0)
    pwd
)
cd $CURRENT_DIR
IFS=$'\n'
t1='转换前.txt'
t2='转换后.txt'
rm -rf $t2
touch $t2
toLeftSpaceLenght=0
lastSpaceLenght=0
for line in $(cat $t1); do
    let j=++i
    # echo $j #从1开始打印
    if [[ "$line" != "" ]]; then
        if [[ $toLeftSpaceLenght == 0 ]]; then
            currentSpaceCount=$(echo "$line" | awk '{str=length($0); sub(/^[ ]*/,"",$0); print str-length($0);}')
            cha=$currentSpaceCount-$lastSpaceLenght
            if [[ $currentSpaceCount > 0 && $cha > 0 ]]; then
                if [[ $cha == 2 ]]; then
                    toLeftSpaceLenght=$currentSpaceCount-2
                else
                    toLeftSpaceLenght=$currentSpaceCount
                fi
            fi
            lastSpaceLenght=$currentSpaceCount
            newline=${line:$toLeftSpaceLenght}

            # newline=$(echo ${newline//\"/\\\"})
            # echo "\"$newline"\" >>$t2
            echo $newline >>$t2
        else
            newline=${line:$toLeftSpaceLenght}

            # newline=$(echo ${newline//\"/\\\"})
            # echo "\"$newline"\" >>$t2
            echo $newline >>$t2
        fi
    else
        echo "" >>$t2
    fi
done

echo '转换完成'
open $t2
