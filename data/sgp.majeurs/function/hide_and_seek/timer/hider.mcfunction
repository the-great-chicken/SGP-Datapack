#> sgp.majeurs:hide_and_seek/timer/hider
#
# This function is called every second to update the timer of the hider.

execute as @a[team=sgp.hider] run scoreboard players set @s sgp.ab.hide_hider 40
data modify storage dah:actbar new set value {id:"sgp:hide_hider",order:0,text:[{text:"Tu as "},{score:{name:"#hider",objective:"sgp.timer"}},{text:" secondes pour te cacher"}]}
execute as @a[team=sgp.hider] run function dah.actbar_mixer:new/update_id


#debug
#execute unless score #hider sgp.timer matches ..0 run tellraw @a {score: {name: "#hider", objective: "sgp.timer"}}

execute unless score #hider sgp.timer matches ..0 run schedule function sgp.majeurs:hide_and_seek/timer/hider 1s
execute if score #hider sgp.timer matches ..0 as @a[team=sgp.hider] run function sgp.majeurs:hide_and_seek/timer/end {role:'hider'}
scoreboard players remove #hider sgp.timer 1