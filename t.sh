#!/bin/bash
### chmod +x 本文件的路径 (无权限的问题)
# 介绍:
# 本脚本是用于缩进代码格式的作用

# 提示:
# 执行本脚本后后边可加一个参数
# 参数为1或不传,生成dart.json代码块配置  参数传2生成简单的代码缩进格式化

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
leftSpace=0 #统一的左缩进的空格数

function mulHandler() {
  newline=$(echo ${newline//\"/\\\"}) #把字符串里边所有的"前都加上反斜线\"
  if [[ $j == 1 ]]; then
    echo "\"代码块描述\": {" >>$t2
    echo "  \"prefix\": \"代码块快捷键\"," >>$t2
    echo "  \"body\": [" >>$t2
    echo "    \"$newline"\"\, >>$t2
  else
    echo "    \"$newline"\"\, >>$t2
  fi
}
function simpleHandler() {
  echo "$newline" >>$t2
}
for line in $(cat $t1); do
  let j=++i
  # echo $j #从1开始打印
  if [[ "$line" != "" ]]; then
    #每行的空格数
    current=$(echo "$line" | awk '{str=length($0); sub(/^[ ]*/,"",$0); print str-length($0);}')
    cha=$(($current - $leftSpace))
    echo $j '当前 '$current '左边统一空格 '$leftSpace '差值 '$cha

    if [[ $j == 1 ]]; then
      newline=${line:$current} #第一行缩进到最左侧即可
    elif [[ $j == 2 ]]; then
      leftSpace=$(($current - 2)) #第二行缩进到最左侧2个空格
      newline=${line:$leftSpace}  #拿到公共的缩进空格数
    else
      if [[ $current < $leftSpace ]]; then #仅防下边会比公共的缩进还小的行
        leftSpace=$current                 #这种情况缩进到最左侧即可
      fi
      newline=${line:$leftSpace}
    fi

    if [[ $1 == 2 ]]; then
      simpleHandler #简单的代码缩进格式化
    else
      mulHandler #处理dart.json代码块配置
    fi
  else
    echo "" >>$t2
  fi
done

if [[ $1 != 2 ]]; then
  echo "  ]," >>$t2
  echo "}," >>$t2
fi

echo '转换完成'
open $t2
