#> sgp.ci:ability_entrypoints/cleanup
# Remove only artifacts explicitly claimed by this test family, then disconnect its dummies.

kill @e[tag=sgp.ci.ability_entrypoint]
function sgp.ci:players/cleanup
data remove storage sgp.kits:stats kits_dict.920001
data remove storage sgp.kits:stats kits_dict.920002
data remove storage sgp.kits:stats kits_dict.920003
data remove storage sgp.kits:stats kits_dict.920004
data remove storage sgp.kits:stats kits_dict.920005
data remove storage sgp.kits:stats kits_dict.920006
