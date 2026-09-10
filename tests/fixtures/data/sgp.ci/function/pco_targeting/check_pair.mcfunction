#> sgp.ci:pco_targeting/check_pair
# `{hunter, prey: Poule|Canard|Oie, damage: attack damage * 1000}`
#
# Apply PCO targeting for one hunter/prey team pairing and verify the hunter's resulting melee damage.

$team join sgp.$(hunter) @s
$team join sgp.$(prey) PcoPrey
effect clear @s minecraft:strength
function sgp.majeurs:pco/empower
$function sgp.ci:pco_targeting/expect_damage {damage:$(damage)}
