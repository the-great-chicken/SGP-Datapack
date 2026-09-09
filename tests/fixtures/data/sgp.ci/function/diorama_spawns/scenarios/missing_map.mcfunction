#> sgp.ci:diorama_spawns/scenarios/missing_map

function sgp.ci:diorama_spawns/fixture
function sgp.ci:diorama_spawns/rebuild
data remove storage sgp:data spawns[{id:96003}]
function sgp.ci:diorama_spawns/rebuild
function sgp.ci:diorama_spawns/count {count:0}
assert not data storage sgp:data misc.diorama.spawn_interactions.id_96003[0]
