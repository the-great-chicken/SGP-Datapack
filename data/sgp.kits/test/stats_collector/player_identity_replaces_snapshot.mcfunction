#> sgp.kits:stats_collector/player_identity_replaces_snapshot
# @dummy
# @environment sgp.ci:stats_collector
#
# Refreshing identity data replaces the complete snapshot so stale profile fields cannot survive a reconnect.

data modify storage sgp.kits:stats players.910009 set value {uuid:[I;9,9,9,9],nickname:"Old",stale:1}
data modify storage sgp:macro stats.current_player_identity set value {player_id:910009,uuid:[I;1,2,3,4],nickname:"First"}
function sgp.kits:stats_collector/player_identity/save with storage sgp:macro stats.current_player_identity

assert data storage sgp.kits:stats players.910009{uuid:[I;1,2,3,4],nickname:"First"}
assert not data storage sgp.kits:stats players.910009.stale

data modify storage sgp:macro stats.current_player_identity set value {player_id:910009,uuid:[I;-1,-2,-3,-4],nickname:"Renamed"}
function sgp.kits:stats_collector/player_identity/save with storage sgp:macro stats.current_player_identity
assert data storage sgp.kits:stats players.910009{uuid:[I;-1,-2,-3,-4],nickname:"Renamed"}
