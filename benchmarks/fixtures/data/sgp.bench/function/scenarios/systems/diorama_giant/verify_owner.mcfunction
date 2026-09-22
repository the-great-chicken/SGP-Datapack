#> sgp.bench:scenarios/systems/diorama_giant/verify_owner
# Executed outside profiling, once per actor.

scoreboard players operation $link.to bs.in = @s bs.id
execute positioned 0 121 0 store result score #diorama_owned sgp.bench if entity @e[tag=sgp.giant_mannequin_99001,predicate=bs.link:link_equal,distance=..256,type=mannequin]
execute if score #diorama_owned sgp.bench matches 1 run scoreboard players add #diorama_valid_owners sgp.bench 1
