execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.alchimiste] run function sgp.kits:kit_tags/prefixes_update {kit:alchimiste}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.archer] run function sgp.kits:kit_tags/prefixes_update {kit:archer}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.cancer] run function sgp.kits:kit_tags/prefixes_update {kit:cancer}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.combattant] run function sgp.kits:kit_tags/prefixes_update {kit:combattant}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.eclaireur] run function sgp.kits:kit_tags/prefixes_update {kit:eclaireur}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.enderman] run function sgp.kits:kit_tags/prefixes_update {kit:enderman}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.pigeon] run function sgp.kits:kit_tags/prefixes_update {kit:pigeon}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.poseidon] run function sgp.kits:kit_tags/prefixes_update {kit:poseidon}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.pyromane] run function sgp.kits:kit_tags/prefixes_update {kit:pyromane}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.roi] run function sgp.kits:kit_tags/prefixes_update {kit:roi}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.tank] run function sgp.kits:kit_tags/prefixes_update {kit:tank}
execute unless entity @a[tag=sgp.adding_prefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.vindicateur] run function sgp.kits:kit_tags/prefixes_update {kit:vindicateur}
tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix