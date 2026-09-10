#> sgp.ci:death_cleanup/tank
# Turn the actor into an active Tank with Bigger applied, so cleanup also covers kit-specific attributes.

tag @s add sgp.tank
scoreboard players set @s sgp.kit_id 5
attribute @s minecraft:scale base set 1
attribute @s minecraft:jump_strength base set 0.42
attribute @s minecraft:entity_interaction_range base set 3
attribute @s minecraft:attack_damage base set 1
function sgp.kits:abilities/bigger/apply
function sgp.ci:bigger/expect {scale:"199999..200001",jump:"52499..52501",reach:"449999..450001",damage:"199999..200001"}
