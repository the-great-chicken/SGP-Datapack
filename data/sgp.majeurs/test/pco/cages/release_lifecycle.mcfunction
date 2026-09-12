#> sgp.majeurs:pco/cages/release_lifecycle
# @dummy
# @environment sgp.ci:pco/release
#
# Release frees only captured teammates, leaves other players/cages alone, and restores the closed cage after three seconds.

function sgp.ci:pco/fixture
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.majeurs:pco/locations/add {id:"ci_beta"}
function sgp.majeurs:pco/locations/select
function sgp.majeurs:pco/cage/restore {cage:"oie"}
team join sgp.Oie @s
scoreboard players set @s sgp.en_cage 0
scoreboard players set @s sgp.liberer_oies 2
effect give @s night_vision infinite 0 true

dummy PcoPrisoner spawn
tag PcoPrisoner add sgp.ci.pco_actor
gamemode creative PcoPrisoner
team join sgp.Oie PcoPrisoner
tp PcoPrisoner ~6.5 ~2 ~0.5
scoreboard players set PcoPrisoner sgp.en_cage 1
effect give PcoPrisoner resistance infinite 5 true
dummy PcoFree spawn
tag PcoFree add sgp.ci.pco_actor
gamemode creative PcoFree
team join sgp.Oie PcoFree
tp PcoFree ~15.5 ~1 ~3.5
scoreboard players set PcoFree sgp.en_cage 0
scoreboard players set PcoFree sgp.liberer_oies 1
dummy PcoEnemy spawn
tag PcoEnemy add sgp.ci.pco_actor
gamemode creative PcoEnemy
team join sgp.Canard PcoEnemy
tp PcoEnemy ~14.5 ~1 ~3.5
scoreboard players set PcoEnemy sgp.en_cage 1
scoreboard players set PcoEnemy sgp.liberer_canards 2
effect give PcoEnemy resistance infinite 5 true

function sgp.majeurs:pco/cage/uncage {cage:"oie",team:"Oie",catchers:"Canard",team_color:"yellow"}
assert block ~6 ~2 ~ air
assert block ~7 ~2 ~1 air
assert block ~6 ~1 ~ red_concrete
assert block ~6 ~1 ~4 blue_concrete
assert block ~10 ~1 ~ gold_block
assert entity @e[tag=sgp.ci.pco,tag=sgp.pco.cage_open,name=pco_oie_cage_arena,distance=..24,type=marker]
execute at @s run assert entity @a[name=PcoPrisoner,distance=..0.01]
execute positioned ~15.5 ~1 ~3.5 run assert entity @a[name=PcoFree,distance=..0.01]
execute positioned ~14.5 ~1 ~3.5 run assert entity @a[name=PcoEnemy,distance=..0.01]
assert score PcoPrisoner sgp.en_cage matches 0
assert score PcoFree sgp.en_cage matches 0
assert score PcoEnemy sgp.en_cage matches 1
assert not entity @a[name=PcoPrisoner,nbt={active_effects:[{id:"minecraft:resistance"}]}]
assert entity @a[name=PcoEnemy,nbt={active_effects:[{id:"minecraft:resistance"}]}]
assert entity @s[nbt={active_effects:[{id:"minecraft:night_vision"}]}]
assert not score @s sgp.liberer_oies matches 0..
assert not score PcoFree sgp.liberer_oies matches 0..
assert score PcoEnemy sgp.liberer_canards matches 2

await delay 40t
assert block ~6 ~2 ~ air
await delay 21t
assert block ~6 ~2 ~ glass
assert block ~7 ~2 ~1 barrel
assert data block ~7 ~2 ~1 Items[{Slot:0b,id:"minecraft:diamond",count:7}]
assert not entity @e[tag=sgp.ci.pco,tag=sgp.pco.cage_open,distance=..24,type=marker]
assert block ~6 ~1 ~4 blue_concrete
assert block ~10 ~1 ~ gold_block
