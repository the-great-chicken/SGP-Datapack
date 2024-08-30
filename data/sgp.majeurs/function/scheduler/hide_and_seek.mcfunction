#> sgp.majeurs:function/common/rounds
#`{event}`
# 
# check if the number of rounds is less than the maximum number of rounds
# if true, schedule the next round in 30 seconds
schedule function sgp.majeurs:hide_and_seek/_start 120s
function sgp.majeurs:scheduler/message with storage sgp:data majeurs.hide_and_seek