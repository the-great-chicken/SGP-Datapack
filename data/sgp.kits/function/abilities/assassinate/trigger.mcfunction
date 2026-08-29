#> sgp.kits:abilities/assassinate/trigger
#
# Mark the triggered assassin and get his attacker's position

tag @s add sgp.assassin_triggered
function sgp.kits:stats_collector/ability/mark_success {kit_id:9,ability_path:"assassinate"}

scoreboard players operation #ability_metric_delta sgp.dummy = @s sgp.damage_resisted
function sgp.kits:stats_collector/ability/increment_score {kit_id:9,ability_path:"assassinate",metric:"damage_resisted"}

execute on attacker at @s rotated ~ 0 run function sgp.kits:abilities/assassinate/check_tp_position

schedule function sgp.kits:abilities/assassinate/rotate_delayed 2t

function sgp.kits:abilities/assassinate/end
