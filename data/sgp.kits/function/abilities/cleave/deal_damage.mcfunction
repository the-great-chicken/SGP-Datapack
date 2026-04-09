#> sgp.kits:abilities/cleave/deal_damage
#
# `{last_damage: float}`
# The damage type bypasses cooldown, which makes it deal kb even during the 10t period
$damage @s $(last_damage) sgp.kits:giant_sweep by @a[tag=sgp.attacker,limit=1,sort=nearest] from @a[tag=sgp.attacker,limit=1,sort=nearest]