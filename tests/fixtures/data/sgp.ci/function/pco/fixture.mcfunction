#> sgp.ci:pco/fixture
# Two small arena sets with distinct cages; discard actors from earlier failed tests before rebuilding.

execute as @a[tag=sgp.ci.pco_actor] run dummy @s leave
kill @e[tag=sgp.ci.pco,type=marker]
function #bs.schedule:cancel_all {with:{id:"pco"}}
data modify storage sgp:data majeurs.pco.locations set value []
data remove storage sgp:data majeurs.pco.pinned_location
data remove storage sgp:data majeurs.pco.active_location
scoreboard players set #pco_phase sgp.dummy 0
scoreboard players set #rounds sgp.dummy 0
scoreboard players set #pco_max_rounds sgp.dummy 1

fill ~ ~ ~ ~22 ~5 ~7 air
fill ~ ~ ~ ~22 ~ ~7 stone
fill ~ ~1 ~ ~1 ~1 ~1 red_concrete
fill ~ ~2 ~ ~1 ~2 ~1 glass
setblock ~1 ~2 ~1 barrel
item replace block ~1 ~2 ~1 container.0 with diamond 7
fill ~3 ~1 ~ ~4 ~1 ~1 red_concrete
fill ~ ~1 ~4 ~1 ~2 ~5 emerald_block
fill ~6 ~1 ~ ~7 ~2 ~1 yellow_concrete
fill ~6 ~1 ~4 ~7 ~2 ~5 blue_concrete
setblock ~10 ~1 ~ gold_block

summon marker ~0.75 ~1.75 ~0.75 {CustomName:"pco_cage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_alpha",cage:"oie",dx:1,dy:1,dz:1}}
summon marker ~3 ~1 ~ {CustomName:"pco_uncage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_alpha",cage:"oie",dx:1,dy:1,dz:1}}
summon marker ~6 ~1 ~ {CustomName:"pco_oie_cage_arena",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_alpha"}}
summon marker ~6.5 ~2 ~0.5 {CustomName:"pco_spawn_cage_Oie",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_alpha"}}
summon marker ~10 ~1 ~ {CustomName:"pco_poule_cage_arena",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_alpha"}}

# Negative extents describe the same two-by-two-by-two source volume from its opposite corner.
summon marker ~1.75 ~2.75 ~5.75 {CustomName:"pco_cage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_beta",cage:"oie",dx:-1,dy:-1,dz:-1}}
summon marker ~3 ~1 ~4 {CustomName:"pco_uncage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_beta",cage:"oie",dx:1,dy:1,dz:1}}
summon marker ~6 ~1 ~4 {CustomName:"pco_oie_cage_arena",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_beta"}}
summon marker ~6.5 ~2 ~4.5 {CustomName:"pco_spawn_cage_Oie",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_beta"}}

tag @s add sgp.ci.pco_actor
gamemode creative @s
tp @s ~12.5 ~1 ~3.5
