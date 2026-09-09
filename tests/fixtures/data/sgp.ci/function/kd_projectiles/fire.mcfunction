#> sgp.ci:kd_projectiles/fire
# {kd,kills,deaths}: a noncritical arrow with ten base damage and unit speed.

$scoreboard players set @s sgp.kd $(kd)
$scoreboard players set @s sgp.kills $(kills)
$scoreboard players set @s sgp.morts $(deaths)
function sgp.ci:kd_projectiles/launch {weapon:bow}
