#> sgp.ci:stats_collector/cleanup
# Test-only cleanup for synthetic statistics records used by PackTest.

function sgp.ci:players/cleanup

data remove storage sgp.ci:stats

data remove storage sgp.kits:stats kits_dict.910001
data remove storage sgp.kits:stats kits_dict.910003
data remove storage sgp.kits:stats kits_dict.910005
data remove storage sgp.kits:stats kits_dict.910006
data remove storage sgp.kits:stats kits_dict.910007
data remove storage sgp.kits:stats kits_dict.910013
data remove storage sgp.kits:stats kits_dict.910016
data remove storage sgp.kits:stats kits_dict.910017

data remove storage sgp.kits:stats death_positions."sgp.ci:test_dimension"
data remove storage sgp.kits:stats death_positions."minecraft:the_nether"."123,640,-456"

data remove storage sgp.kits:stats players.910009
data remove storage sgp.kits:stats players.910012
data remove storage sgp.kits:stats players.910013
data remove storage sgp.kits:stats players.910014
data remove storage sgp.kits:stats players.910015

data remove storage sgp.kits:stats elo_ratings.910010
data remove storage sgp.kits:stats elo_ratings.910011
data remove storage sgp.kits:stats elo_ratings.910012
