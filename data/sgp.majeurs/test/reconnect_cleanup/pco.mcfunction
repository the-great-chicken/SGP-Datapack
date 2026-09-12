#> sgp.majeurs:reconnect_cleanup/pco
# @dummy
# @environment sgp.ci:major_reconnect
#
# A PCO participant who missed stop-time cleanup loses cage/refuge state and
# event effects when they return.

tag @s add sgp.in_game
tag @s add sgp.major_participant
tag @s add sgp.major.pco
tag @s add sgp.pco.awaiting_cage
scoreboard players set @s sgp.en_cage 1
scoreboard players set @s sgp.temps_cabane_pco 42
scoreboard players set @s sgp.temps_cabane_pco_secondes 3
scoreboard players set @s sgp.liberer_oies 2
effect give @s minecraft:strength infinite 1 true
effect give @s minecraft:resistance infinite 1 true
effect give @s minecraft:wither infinite 1 true
give @s minecraft:feather 1

function sgp.majeurs:repair_reconnected_players
assert score @s sgp.synthetic_death matches 1
assert score @s sgp.just_died matches 1
function sgp.misc:on_death

assert entity @s[gamemode=survival,tag=!sgp.major_participant,tag=!sgp.major_spectator,tag=!sgp.major.pco,tag=!sgp.pco.awaiting_cage]
assert not entity @s[scores={sgp.en_cage=0..}]
assert not entity @s[scores={sgp.temps_cabane_pco=0..}]
assert not entity @s[scores={sgp.temps_cabane_pco_secondes=0..}]
assert not entity @s[scores={sgp.liberer_oies=0..}]
assert not data entity @s active_effects[0]
assert not entity @s[nbt={Inventory:[{}]}]
