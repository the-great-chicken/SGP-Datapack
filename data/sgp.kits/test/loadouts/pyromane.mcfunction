#> sgp.kits:loadouts/pyromane
# @dummy
#
# Pyromane keeps its fire-themed weapon set, explosive charges, ignition tool, and armor profile.

function sgp.kits:give {kit:"pyromane"}

assert score @s sgp.kit_id matches 4
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.pyromane_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:blaze_rod"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.1",item:"minecraft:bow"}
function sgp.ci:loadouts/expect_slot {slot:"armor.legs",item:"minecraft:diamond_leggings"}
function sgp.ci:loadouts/expect_slot {slot:"weapon.offhand",item:"minecraft:flint_and_steel"}
function sgp.ci:inventory/expect_count {item:"minecraft:strider_spawn_egg",count:4}
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:4}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:2}
