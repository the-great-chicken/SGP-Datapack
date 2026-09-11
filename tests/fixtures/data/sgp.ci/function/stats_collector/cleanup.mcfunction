#> sgp.ci:stats_collector/cleanup
# Test-only cleanup for synthetic statistics records used by PackTest.

function sgp.ci:players/cleanup

data remove storage sgp.ci:stats ability
data remove storage sgp.ci:stats damage
data remove storage sgp.ci:stats elo_apply
data remove storage sgp.ci:stats elo_lookup
data remove storage sgp.ci:stats elo_transfer
data remove storage sgp.ci:stats identity
data remove storage sgp.ci:stats kills
data remove storage sgp.ci:stats pick_close
data remove storage sgp.ci:stats positions
data remove storage sgp.ci:stats entry_kill
data remove storage sgp.ci:stats entry_position
data remove storage sgp:macro stats.current_kill_info
data remove storage sgp:macro stats.current_kit_pick_info
data remove storage sgp:macro stats.current_death_position
data remove storage sgp:macro stats.current_player_identity
data remove storage sgp:macro stats.current_elo_player

data remove storage sgp.kits:stats kits_dict.910001
data remove storage sgp.kits:stats kits_dict.910003
data remove storage sgp.kits:stats kits_dict.910005
data remove storage sgp.kits:stats kits_dict.910006
data remove storage sgp.kits:stats kits_dict.910007
data remove storage sgp.kits:stats kits_dict.910013
data remove storage sgp.kits:stats kits_dict.910016
data remove storage sgp.kits:stats kits_dict.910017
data remove storage sgp.kits:stats kits_dict.910018
data remove storage sgp.kits:stats kits_dict.910019
data remove storage sgp.kits:stats kits_dict.910020
data remove storage sgp.kits:stats kits_dict.910021

data remove storage sgp.kits:stats death_positions."sgp.ci:test_dimension"
data remove storage sgp.kits:stats death_positions."minecraft:the_nether"."123,640,-456"
data remove storage sgp.kits:stats death_positions."minecraft:overworld"."1234,800,-457"
data remove storage sgp.kits:stats death_positions."minecraft:overworld"."1235,801,-457"

data remove storage sgp.kits:stats players.910009
data remove storage sgp.kits:stats players.910012
data remove storage sgp.kits:stats players.910013
data remove storage sgp.kits:stats players.910014
data remove storage sgp.kits:stats players.910015

data remove storage sgp.kits:stats elo_ratings.910010
data remove storage sgp.kits:stats elo_ratings.910011
data remove storage sgp.kits:stats elo_ratings.910012
