#> sgp.integration.tab:prefix/check

tag @a remove sgp.tab_target
tag @a[scores={sgp.kit_prefix_set=0},limit=1,sort=arbitrary] add sgp.tab_target

execute if entity @a[tag=sgp.tab_target,tag=sgp.alchimiste,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:alchimiste}
execute if entity @a[tag=sgp.tab_target,tag=sgp.archer,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:archer}
execute if entity @a[tag=sgp.tab_target,tag=sgp.cancer,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:cancer}
execute if entity @a[tag=sgp.tab_target,tag=sgp.combattant,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:combattant}
execute if entity @a[tag=sgp.tab_target,tag=sgp.eclaireur,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:eclaireur}
execute if entity @a[tag=sgp.tab_target,tag=sgp.enderman,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:enderman}
execute if entity @a[tag=sgp.tab_target,tag=sgp.peaceful,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:peaceful}
execute if entity @a[tag=sgp.tab_target,tag=sgp.pigeon,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:pigeon}
execute if entity @a[tag=sgp.tab_target,tag=sgp.poseidon,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:poseidon}
execute if entity @a[tag=sgp.tab_target,tag=sgp.pyromane,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:pyromane}
execute if entity @a[tag=sgp.tab_target,tag=sgp.roi,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:roi}
execute if entity @a[tag=sgp.tab_target,tag=sgp.tank,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:tank}
execute if entity @a[tag=sgp.tab_target,tag=sgp.vindicateur,limit=1] run return run function sgp.integration.tab:prefix/apply {kit_name:vindicateur}

tag @a[tag=sgp.tab_target,limit=1] remove sgp.tab_target
return 0
