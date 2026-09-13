#> sgp.kits:loadouts/pigeon
# @dummy
#
# Pigeon keeps its elytra flight package, single infinity arrow, rockets, food, and Jump Boost III.

function sgp.kits:give {kit:"pigeon"}

assert score @s sgp.kit_id matches 0
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.pigeon_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:feather"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.1",item:"minecraft:bow"}
function sgp.ci:loadouts/expect_slot {slot:"armor.chest",item:"minecraft:elytra"}
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:1}
function sgp.ci:inventory/expect_count {item:"minecraft:firework_rocket",count:3}
function sgp.ci:inventory/expect_count {item:"minecraft:bread",count:64}
assert entity @s[nbt={active_effects:[{id:"minecraft:jump_boost",amplifier:2b}]}]
