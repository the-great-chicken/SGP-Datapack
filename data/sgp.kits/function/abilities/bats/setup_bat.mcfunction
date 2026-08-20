#> sgp.kits:abilities/bats/setup_bat
# `{duration: int}`
#
# Executed as a newly summoned grenade bat.

scoreboard players operation @s sgp.damage_owner = #damage_owner sgp.dummy
$function #bs.health:time_to_live {with:{time:$(duration),unit:"s"}}
