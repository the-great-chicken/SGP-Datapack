#> sgp.majeurs:major_elimination/eliminate_exit_cleanup
# @dummy
# @environment sgp.ci:major_elimination/eliminate_exit_cleanup
#
# Leaving a major-event arena uses the normal synthetic-death cleanup before entering spectator state.

team leave @s
tag @s add sgp.major_participant
tag @s remove sgp.major_spectator
tag @s add sgp.peaceful
gamemode survival @s
scoreboard players set @s sgp.kit_id -1
scoreboard players set @s sgp.cooldown_ability 37
scoreboard players set @s sgp.kills_give_1 4
scoreboard players set @s sgp.kills_give_2 5
scoreboard players set @s sgp.kills_give_3 6
item replace entity @s weapon.mainhand with minecraft:diamond 3
effect give @s night_vision infinite 0 true

function sgp.majeurs:common/eliminate_exit

assert entity @s[gamemode=spectator,team=,tag=!sgp.major_participant,tag=sgp.major_spectator,tag=!sgp.peaceful]
assert not entity @s[nbt={active_effects:[{id:"minecraft:night_vision"}]}]
execute store result score #ci.major.items sgp.dummy run clear @s minecraft:diamond 0
assert score #ci.major.items sgp.dummy matches 0
assert score @s sgp.kit_id matches -1
assert score @s sgp.cooldown_ability matches 0
assert score @s sgp.kills_give_1 matches 0
assert score @s sgp.kills_give_2 matches 0
assert score @s sgp.kills_give_3 matches 0
assert chat ".*quitté l'arène et es éliminé.*" @s
