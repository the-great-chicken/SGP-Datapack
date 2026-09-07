#> sgp.ci:hider_teams/linked_roster
# A three-player group and an unrelated two-player group, with normal hider bonuses.

function sgp.ci:hider_teams/populate {count:4}
fill ~ ~1 ~ ~6 ~4 ~4 air
fill ~ ~ ~ ~6 ~ ~4 stone
summon marker ~2 ~1 ~2 {CustomName:"spawn_seeker",Tags:["sgp.marker","sgp.ci.hider_teams"]}
summon marker ~4 ~1 ~2 {CustomName:"spawn_hider",Tags:["sgp.marker","sgp.ci.hider_teams"]}
tag @s add sgp.ci.hider_actor
team join sgp.hider @s
tag @a[tag=sgp.ci.hider_actor] add sgp.hider
tag @a[tag=sgp.ci.hider_actor] add sgp.major_participant
tag @a[tag=sgp.ci.hider_actor] add sgp.in_game
scoreboard players set @a[tag=sgp.ci.hider_actor] sgp.teammate_deaths 0
scoreboard players set @a[tag=sgp.ci.hider_actor] sgp.link_teams 9
scoreboard players set @s sgp.link_teams 7
scoreboard players set HsGroup1 sgp.link_teams 7
scoreboard players set HsGroup2 sgp.link_teams 7
execute as @a[tag=sgp.ci.hider_actor] run attribute @s minecraft:movement_speed base set 0.1
execute as @a[tag=sgp.ci.hider_actor] run function sgp.majeurs:hide_and_seek/role/effect/hider
