#!/bin/bash
### chmod +x 本文件的路径 (无权限的问题)

CURRENT_DIR=$(
    cd $(dirname $0)
    pwd
)
cd $CURRENT_DIR

sh t.sh 2
