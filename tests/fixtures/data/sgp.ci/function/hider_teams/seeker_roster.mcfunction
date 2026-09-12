#> sgp.ci:hider_teams/seeker_roster
# Two waiting seekers and one hider, using the production role setup.

function sgp.ci:hider_teams/populate {count:2}
fill ~ ~1 ~ ~6 ~4 ~4 air
fill ~ ~ ~ ~6 ~ ~4 stone
summon marker ~2.5 ~1 ~2.5 {CustomName:"spawn_seeker",Tags:["sgp.marker","sgp.ci.hider_teams"]}
summon marker ~4.5 ~1 ~2.5 {CustomName:"spawn_hider",Tags:["sgp.marker","sgp.ci.hider_teams"]}
tag @s add sgp.ci.hider_actor
tag @a[tag=sgp.ci.hider_actor] add sgp.major_participant
tag @a[tag=sgp.ci.hider_actor] add sgp.in_game
gamemode creative @a[tag=sgp.ci.hider_actor]
execute as @a[tag=sgp.ci.hider_actor] run attribute @s minecraft:movement_speed base set 0.1
execute as @a[tag=sgp.ci.hider_actor] run attribute @s minecraft:attack_damage base set 1
function sgp.majeurs:hide_and_seek/role/seeker
execute as HsGroup1 run function sgp.majeurs:hide_and_seek/role/seeker
tag HsGroup2 add sgp.hider
scoreboard players set HsGroup2 sgp.teammate_deaths 0
scoreboard players set HsGroup2 sgp.link_teams 7
execute as HsGroup2 run function sgp.majeurs:hide_and_seek/role/hider
