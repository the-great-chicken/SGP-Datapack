#> sgp.mineurs:frenzy/repeated_start
# @dummy
#
# Starting an already running Frenzy neither quarters cooldowns nor replaces the restoration snapshot.

data modify storage sgp:data tests.frenzy_repeated_start set value {}
data modify storage sgp:data tests.frenzy_repeated_start.original set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data kits.ability_cooldowns set value {cleave:{cooldown:301s}}
tag @s add sgp.in_game
scoreboard players set @s sgp.cooldown_ability 101
function sgp.mineurs:frenzy/start
function sgp.mineurs:frenzy/start
data modify storage sgp:data tests.frenzy_repeated_start.during set from storage sgp:data kits.ability_cooldowns
execute store result storage sgp:data tests.frenzy_repeated_start.player int 1 run scoreboard players get @s sgp.cooldown_ability
function sgp.mineurs:frenzy/stop
data modify storage sgp:data tests.frenzy_repeated_start.after set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data kits.ability_cooldowns set from storage sgp:data tests.frenzy_repeated_start.original
schedule clear sgp.misc:second

assert data storage sgp:data tests.frenzy_repeated_start{during:{cleave:{cooldown:150s}},player:50,after:{cleave:{cooldown:301s}}}
data remove storage sgp:data tests.frenzy_repeated_start
