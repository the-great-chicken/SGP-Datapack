#> sgp.bench:scenarios/systems/locations/spawn_marker
# `{index, x, y, z, dx, dy, dz, width}`
# One marker in the exact production shape of README.md, plus its objective
# (sgp.world:initialization -> sgp.world:lieu/initialization).

$function sgp.world:lieu/initialization {lieu:"bench_loc_$(index)"}
$summon marker $(x) $(y) $(z) {CustomName:"lieu",Tags:["sgp.marker","sgp.bench.locations"],data:{lieu:"bench_loc_$(index)",lieu_propre:"Bench Location $(index)",couleur:"#DDDDDD",width:$(width),dx:$(dx),dy:$(dy),dz:$(dz)}}
