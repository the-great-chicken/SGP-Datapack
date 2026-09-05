#> sgp.ci:minor_events/check_magic
# `{roll: int, effect: string, amplifier: int}`
#
# Check the effect a selected spell gives, including strength and its two-minute duration.

effect clear @s
$scoreboard players set #random_magic_roll sgp.dummy $(roll)
function sgp.mineurs:magic/choose_effect
$execute store success score @s sgp.dummy if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{effects:{"minecraft:$(effect)":{amplifier:$(amplifier),duration:2400}}}}
assert score @s sgp.dummy matches 1
