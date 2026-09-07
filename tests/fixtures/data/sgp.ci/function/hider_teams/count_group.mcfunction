#> sgp.ci:hider_teams/count_group
# Count the living hiders sharing this player's group, independently of the allocated group IDs.

assert score @s sgp.link_teams matches 1..
scoreboard players operation #ci.hs.group sgp.link_teams = @s sgp.link_teams
scoreboard players set #ci.hs.size sgp.dummy 0
execute as @a[team=sgp.hider,tag=sgp.ci.hider_actor] if score @s sgp.link_teams = #ci.hs.group sgp.link_teams run scoreboard players add #ci.hs.size sgp.dummy 1
assert score #ci.hs.size sgp.dummy matches 1..5
execute if score #ci.hs.size sgp.dummy matches 1 run scoreboard players add #ci.hs.g1 sgp.dummy 1
execute if score #ci.hs.size sgp.dummy matches 2 run scoreboard players add #ci.hs.g2 sgp.dummy 1
execute if score #ci.hs.size sgp.dummy matches 3 run scoreboard players add #ci.hs.g3 sgp.dummy 1
execute if score #ci.hs.size sgp.dummy matches 4 run scoreboard players add #ci.hs.g4 sgp.dummy 1
execute if score #ci.hs.size sgp.dummy matches 5 run scoreboard players add #ci.hs.g5 sgp.dummy 1
