#> sgp.majeurs:protect/combat/inactive_phases
# @dummy
# @environment sgp.ci:protect/combat/inactive_phases
#
# The combat update must not eliminate players or apply the king aura before combat starts or after it is inactive.

function sgp.ci:protect/roster
tp PrRedKing ~30.5 ~1 ~0.5
scoreboard players set #protect_phase sgp.dummy 0
function sgp.majeurs:protect/running
assert entity @a[name=PrRedKing,tag=sgp.roi_rouge,tag=sgp.major_participant]
assert not entity @a[tag=sgp.ci.protect_actor,tag=sgp.major_spectator]
execute store result score PrBlueA sgp.dummy run attribute PrBlueA minecraft:max_health get
assert score PrBlueA sgp.dummy matches 20
assert score #rounds sgp.dummy matches 0

scoreboard players set #protect_phase sgp.dummy 1
function sgp.majeurs:protect/running
assert entity @a[name=PrRedKing,tag=sgp.roi_rouge,tag=sgp.major_participant]
assert not entity @a[tag=sgp.ci.protect_actor,tag=sgp.major_spectator]
execute store result score PrBlueA sgp.dummy run attribute PrBlueA minecraft:max_health get
assert score PrBlueA sgp.dummy matches 20
assert score #rounds sgp.dummy matches 0
assert not chat ".*est mort.*" @s
