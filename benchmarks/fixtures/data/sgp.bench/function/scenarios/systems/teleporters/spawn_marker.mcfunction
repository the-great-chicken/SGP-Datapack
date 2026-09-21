#> sgp.bench:scenarios/systems/teleporters/spawn_marker
# `{index, x, y, z}`
# One marker in the exact production shape of README.md; its destination is itself.

$summon marker $(x) $(y) $(z) {CustomName:"teleporter",Tags:["sgp.marker","sgp.bench.teleporters"],data:{x:$(x),y:$(y),z:$(z),yaw:0,pitch:0}}
