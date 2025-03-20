#!/bin/bash

weeks=('周一' '周二' '周三' '周四' '周五' '周六' '周日')
sketchybar --set $NAME label="$(date '+%Y年%m月%d日') ${weeks[$(date '+%u')-1]}" 
