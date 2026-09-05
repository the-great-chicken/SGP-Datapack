#> sgp.majeurs:common/rounds
# `{event, text}`
#
# Register the completed round and schedule another one when needed.
scoreboard players add #rounds sgp.dummy 1
$execute if score #rounds sgp.dummy >= #$(event)_max_rounds sgp.dummy run return 1
$schedule function sgp.majeurs:$(event)/_start 30s
$tellraw @a [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Nouvelle partie de ", color:aqua}, {text:"$(text)", color:gold}, {text:" dans 30 secondes", color:aqua}]
