execute if entity @a[scores={sgp.kit_prefix_set=0},tag=alchimiste] run function sgp.kits:kit_tags/prefixes_update {kit:alchimiste}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=archer] run function sgp.kits:kit_tags/prefixes_update {kit:archer}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=cancer] run function sgp.kits:kit_tags/prefixes_update {kit:cancer}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=combattant] run function sgp.kits:kit_tags/prefixes_update {kit:combattant}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=eclaireur] run function sgp.kits:kit_tags/prefixes_update {kit:eclaireur}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=enderman] run function sgp.kits:kit_tags/prefixes_update {kit:enderman}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=pigeon] run function sgp.kits:kit_tags/prefixes_update {kit:pigeon}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=poseidon] run function sgp.kits:kit_tags/prefixes_update {kit:poseidon}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=pyromane] run function sgp.kits:kit_tags/prefixes_update {kit:pyromane}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=roi] run function sgp.kits:kit_tags/prefixes_update {kit:roi}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=tank] run function sgp.kits:kit_tags/prefixes_update {kit:tank}
execute unless entity @a[tag=addingPrefix] if entity @a[scores={sgp.kit_prefix_set=0},tag=vindicateur] run function sgp.kits:kit_tags/prefixes_update {kit:vindicateur}
tag @a remove addingPrefix