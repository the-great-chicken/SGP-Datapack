#> sgp.kits:abilities/bats/setup_bat
# `{duration: int}`
#
# Executed as a newly summoned grenade bat.

scoreboard players operation @s sgp.damage_owner = #damage_owner sgp.dummy
scoreboard players operation @s sgp.ability_cast = #bat_ability_cast sgp.dummy
$function #bs.health:time_to_live {with:{time:$(duration),unit:"s"}}
