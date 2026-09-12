#> sgp.ci:kd_projectiles/fire
# `{kd: K/D * 100, kills, deaths: nonnegative int}`
#
# Set the shooter's K/D inputs and launch one controlled noncritical projectile.

$scoreboard players set @s sgp.kd $(kd)
$scoreboard players set @s sgp.kills $(kills)
$scoreboard players set @s sgp.morts $(deaths)
function sgp.ci:kd_projectiles/launch {weapon:bow}
