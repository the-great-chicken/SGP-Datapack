#> sgp.ci:diorama_mapping/cleanup
# Remove mapping fixtures and restore the mannequin update interval saved by setup.

function sgp.ci:players/cleanup
tp @e[tag=sgp.ci.mapping,type=mannequin] 8.0 -1000.0 8.0
# Retire dying mannequins from the next scenario before reusing these fixture IDs.
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.ci.mapping_first
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.ci.mapping_other_map
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.ci.mapping_other_owner
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.small_mannequin_94001
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.small_mannequin_94002
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.ci.mapping_giant
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.ci.mapping_giant_other_owner
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.ci.mapping_giant_other_map
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.giant_mannequin_94001
tag @e[tag=sgp.ci.mapping,type=mannequin] remove sgp.giant_mannequin_94002
kill @e[tag=sgp.ci.mapping,type=mannequin]
kill @e[tag=sgp.ci.mapping_ready,type=marker]
execute store result score #mannequin_update_time sgp.dummy run data get storage sgp.ci:diorama_mapping update_time
