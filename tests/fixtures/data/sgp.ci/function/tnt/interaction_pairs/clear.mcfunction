#> sgp.ci:tnt/interaction_pairs/clear
# Remove the two shared TNT charge/interaction pairs.

kill @e[tag=sgp.ci.tnt_interaction_a,type=interaction]
kill @e[tag=sgp.ci.tnt_interaction_b,type=interaction]
kill @e[tag=sgp.ci.tnt_charge_a,type=tnt]
kill @e[tag=sgp.ci.tnt_charge_b,type=tnt]
