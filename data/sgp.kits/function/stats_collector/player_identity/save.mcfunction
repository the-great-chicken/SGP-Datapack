#> sgp.kits:stats_collector/player_identity/save
# @within sgp.kits:stats_collector/player_identity/capture
#
# `{player_id: int, uuid: int array, nickname: string}`

$data modify storage sgp.kits:stats players.$(player_id) set value {}
$data modify storage sgp.kits:stats players.$(player_id).uuid set from storage sgp:macro stats.current_player_identity.uuid
$data modify storage sgp.kits:stats players.$(player_id).nickname set from storage sgp:macro stats.current_player_identity.nickname
