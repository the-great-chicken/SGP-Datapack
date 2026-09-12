#> sgp.ci:pco/refuge_fixture
# Separate the three refuge areas so the team routing cannot accidentally pass against another cage.

function sgp.ci:pco/fixture
fill ~ ~1 ~ ~2 ~4 ~2 air
fill ~32 ~1 ~ ~34 ~4 ~2 air
fill ~ ~1 ~32 ~2 ~4 ~34 air
setblock ~ ~ ~ green_concrete
setblock ~32 ~ ~ green_concrete
setblock ~ ~ ~32 green_concrete
tp @e[tag=sgp.ci.pco,name=pco_poule_cage_arena,nbt={data:{pco_location:"ci_alpha"}},distance=..24,limit=1,type=marker] ~ ~1 ~
tp @e[tag=sgp.ci.pco,name=pco_oie_cage_arena,nbt={data:{pco_location:"ci_alpha"}},distance=..24,limit=1,type=marker] ~ ~1 ~32
summon marker ~32 ~1 ~ {CustomName:"pco_canard_cage_arena",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_alpha"}}
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.majeurs:pco/locations/select
team join sgp.Oie @s
tp @s ~0.5 ~1 ~0.5
