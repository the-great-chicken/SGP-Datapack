#> sgp.mineurs:smol/restart
# @dummy
#
# Starting Smol twice does not compound the size reduction or leave an extra timer registration.

function sgp.ci:minor_events/reset_timer
data modify storage sgp:data tests.smol_restart set value {}
tag @s add sgp.in_game
attribute @s minecraft:scale base set 1
function sgp.mineurs:smol/start
function sgp.mineurs:smol/start
execute store result storage sgp:data tests.smol_restart.during int 1 run attribute @s minecraft:scale get 1000
function sgp.mineurs:smol/stop
execute store result storage sgp:data tests.smol_restart.after int 1 run attribute @s minecraft:scale get 1000
execute store result storage sgp:data tests.smol_restart.active int 1 run scoreboard players get #timed_events_active sgp.dummy
schedule clear sgp.misc:second

assert data storage sgp:data tests.smol_restart{during:500,after:1000,active:0}
data remove storage sgp:data tests.smol_restart
