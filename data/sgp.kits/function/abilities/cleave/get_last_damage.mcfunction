#> sgp.kits:abilities/cleave/get_last_damage
#
# `{current_uuid: player UUID}`

$execute store result score #math_instant sgp.dummy run scoreboard players get @a[nbt={UUID:$(current_uuid)},limit=1] sgp.current_attack_damage