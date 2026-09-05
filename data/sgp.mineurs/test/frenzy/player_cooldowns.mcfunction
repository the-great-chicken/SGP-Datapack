#> sgp.mineurs:frenzy/player_cooldowns
# @dummy
#
# Only in-game players' remaining cooldowns are halved; ready abilities and active ability durations stay unchanged.
# Ending the event restores future cooldown settings without extending a cooldown already shortened.

data modify storage sgp:data tests.frenzy_players set value {}
data modify storage sgp:data tests.frenzy_players.original set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data kits.ability_cooldowns set value {cleave:{cooldown:300s}}
tag @s add sgp.in_game
scoreboard players set @s sgp.cooldown_ability 100
scoreboard players set @s sgp.duration_ability 37
dummy FrenzyReady spawn
tag FrenzyReady add sgp.in_game
scoreboard players set FrenzyReady sgp.cooldown_ability 0
dummy FrenzyOutside spawn
scoreboard players set FrenzyOutside sgp.cooldown_ability 100

function sgp.mineurs:frenzy/start
execute store result storage sgp:data tests.frenzy_players.during int 1 run scoreboard players get @s sgp.cooldown_ability
execute store result storage sgp:data tests.frenzy_players.ready int 1 run scoreboard players get FrenzyReady sgp.cooldown_ability
execute store result storage sgp:data tests.frenzy_players.outside int 1 run scoreboard players get FrenzyOutside sgp.cooldown_ability
function sgp.mineurs:frenzy/end
execute store result storage sgp:data tests.frenzy_players.after int 1 run scoreboard players get @s sgp.cooldown_ability
execute store result storage sgp:data tests.frenzy_players.duration int 1 run scoreboard players get @s sgp.duration_ability
dummy FrenzyReady leave
dummy FrenzyOutside leave
data modify storage sgp:data kits.ability_cooldowns set from storage sgp:data tests.frenzy_players.original
schedule clear sgp.misc:second

assert data storage sgp:data tests.frenzy_players{during:50,ready:0,outside:100,after:50,duration:37}
data remove storage sgp:data tests.frenzy_players
