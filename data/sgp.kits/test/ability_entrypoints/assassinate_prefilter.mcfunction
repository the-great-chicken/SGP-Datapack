#> sgp.kits:ability_entrypoints/assassinate_prefilter
# @dummy
# @environment sgp.ci:ability_entrypoints/assassinate_prefilter
#
# The assassinate advancement only fires for a player in the assassin stance (score prefilter), never for anyone else.
function sgp.ci:ability_entrypoints/seed_stats {id:920002,kit:9,ability:"assassinate"}
dummy Striker spawn
gamemode survival Striker
tp Striker ~1 ~ ~
# Freshly joined players are protected from damage for a while.
await delay 61t
attribute @s minecraft:max_health base set 1024
effect give @s minecraft:instant_health 1 10 true
tag @s add sgp.enderman
# In stance: a hit from another player triggers the assassination.
tag @s add sgp.assassin
scoreboard players set @s sgp.assassin_stance 1
scoreboard players set @s sgp.damage_resisted 0
damage @s 1 minecraft:player_attack by Striker
assert entity @s[tag=sgp.assassin_triggered]
schedule clear sgp.kits:abilities/assassinate/rotate_delayed
tag @s remove sgp.assassin_triggered
# Tag without the score: the advancement is not even granted.
tag @s add sgp.assassin
scoreboard players reset @s sgp.assassin_stance
damage @s 1 minecraft:player_attack by Striker
assert not entity @s[tag=sgp.assassin_triggered]
assert not entity @s[advancements={sgp.kits:assassinate=true}]
tag @s remove sgp.assassin
dummy Striker leave
