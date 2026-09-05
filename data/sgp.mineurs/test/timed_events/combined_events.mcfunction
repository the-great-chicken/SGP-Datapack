#> sgp.mineurs:timed_events/combined_events
# @dummy
#
# Ending Smol during Frenzy restores size while Frenzy and its timer remain active.

function sgp.ci:minor_events/reset_timer
data modify storage sgp:data tests.minor_combo set value {}
data modify storage sgp:data tests.minor_combo.original set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data kits.ability_cooldowns set value {cleave:{cooldown:300s}}
tag @s add sgp.in_game
attribute @s minecraft:scale base set 1
scoreboard players set @s sgp.cooldown_ability 100
function sgp.mineurs:smol/start
function sgp.ci:minor_events/advance {function:"sgp.misc:second",ticks:10}
function sgp.mineurs:frenzy/start
execute store result storage sgp:data tests.minor_combo.first_deadline int 1 run experience query @s levels
function sgp.mineurs:smol/end
execute store result storage sgp:data tests.minor_combo.scale int 1 run attribute @s minecraft:scale get 1000
execute store result storage sgp:data tests.minor_combo.next_deadline int 1 run experience query @s levels
data modify storage sgp:data tests.minor_combo.frenzy set from storage sgp:data kits.ability_cooldowns
function sgp.mineurs:frenzy/end
data modify storage sgp:data tests.minor_combo.restored set from storage sgp:data kits.ability_cooldowns
function sgp.misc:second
execute store result storage sgp:data tests.minor_combo.finished int 1 run experience query @s levels
data modify storage sgp:data kits.ability_cooldowns set from storage sgp:data tests.minor_combo.original
schedule clear sgp.misc:second

assert data storage sgp:data tests.minor_combo{first_deadline:140,scale:1000,next_deadline:150,frenzy:{cleave:{cooldown:150s}},restored:{cleave:{cooldown:300s}},finished:0}
assert score #timed_events_active sgp.dummy matches 0
data remove storage sgp:data tests.minor_combo
