#> sgp.misc:player_uuid/load
# {id}: sgp.id of the executing player.

$execute unless data storage sgp:data misc.uuid_cache."$(id)" run data modify storage sgp:data misc.uuid_cache."$(id)" set from entity @s UUID
$data modify storage sgp:macro owner.uuid set from storage sgp:data misc.uuid_cache."$(id)"
