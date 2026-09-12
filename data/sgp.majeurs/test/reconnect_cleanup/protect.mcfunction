#> sgp.majeurs:reconnect_cleanup/protect
# @dummy
# @environment sgp.ci:major_reconnect
#
# A Protect participant who missed the end of the round loses king state and
# the synthetic event loadout instead of carrying them back into normal play.

tag @s add sgp.in_game
tag @s add sgp.major_participant
tag @s add sgp.major.protect
tag @s add sgp.roi_rouge
effect give @s minecraft:health_boost infinite 4 true
effect give @s minecraft:regeneration infinite 1 true
give @s minecraft:golden_apple 3
scoreboard players set @s sgp.kit_id 10
gamemode spectator @s

function sgp.majeurs:repair_reconnected_players
assert score @s sgp.synthetic_death matches 1
assert score @s sgp.just_died matches 1
function sgp.misc:on_death

assert entity @s[gamemode=survival,tag=!sgp.major_participant,tag=!sgp.major_spectator,tag=!sgp.major.protect,tag=!sgp.roi_rouge,tag=!sgp.roi_bleu]
assert not entity @s[nbt={active_effects:[{id:"minecraft:health_boost"}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:regeneration"}]}]
assert not entity @s[nbt={Inventory:[{}]}]
assert score @s sgp.kit_id matches -1
