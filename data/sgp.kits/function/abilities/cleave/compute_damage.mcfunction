#> sgp.kits:abilities/cleave/compute_damage

# If the target is in the 10 ticks invulnerability period, we check who last dealt them damage
# We then get the attack_damage attribute of that person, and add it to the damage of the cleave
# The cleave damage will be higher, and will replace (not add to) the damage of said last attack
# This will not be precise if the last attack taken was by something else than a player (ex: arrow): it will deal the damage of a hit instead
# But considering that there is a combattant meleeing them, it's improbable they didn't take a melee hit during this period.
scoreboard players set #math_instant sgp.dummy 0
execute unless data entity @s {HurtTime:0s} run data modify storage sgp:data kits.cleave.current_uuid set from entity @s last_hurt_by_player
execute unless data entity @s {HurtTime:0s} run function sgp.kits:abilities/cleave/get_last_damage with storage sgp:data kits.cleave

# Cleave damage here
scoreboard players add #math_instant sgp.dummy 60

execute store result storage sgp:data kits.cleave.last_damage float 0.1 run scoreboard players get #math_instant sgp.dummy
function sgp.kits:abilities/cleave/deal_damage with storage sgp:data kits.cleave