#> sgp.bench:scenarios/systems/locations/spawn_marker_excluded
# `{index, x, y, z, dx, dy, dz, width}`
# Same marker with an exclusion box 8 blocks above its corner: it never contains an actor, so
# membership is unchanged, but sgp.world:lieu/check_exclusion gets a distinct macro key per marker.

$function sgp.world:lieu/initialization {lieu:"bench_loc_$(index)"}
$summon marker $(x) $(y) $(z) {CustomName:"lieu",Tags:["sgp.marker","sgp.bench.locations"],data:{lieu:"bench_loc_$(index)",lieu_propre:"Bench Location $(index)",couleur:"#DDDDDD",width:$(width),dx:$(dx),dy:$(dy),dz:$(dz),exclusion_box:{x:0,y:8,z:0,dx:2,dy:2,dz:2}}}
