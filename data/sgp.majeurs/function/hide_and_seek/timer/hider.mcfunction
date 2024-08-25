#> sgp.majeurs:hide_and_seek/timer/hider
#
# This function is called every second to update the timer of the hider.

data modify storage smithed.actionbar:input message set value { \
    json:'[{"text": "vous avez "},{"score":{"name":"#hider","objective":"sgp.timer"}},{"text": " secondes pour vous cacher"}]', \
    priority:'notification'}
execute as @a[team=sgp.hider] run function #smithed.actionbar:message

execute unless score #hider sgp.timer matches ..0 run tellraw @a {"score": {"name": "#hider", "objective": "sgp.timer"}}

execute unless score #hider sgp.timer matches ..0 run schedule function sgp.majeurs:hide_and_seek/timer/hider 1s
execute if score #hider sgp.timer matches ..0 as @a[team=sgp.hider] run function sgp.majeurs:hide_and_seek/timer/end {role:'hider'}
scoreboard players remove #hider sgp.timer 1

say timer hider