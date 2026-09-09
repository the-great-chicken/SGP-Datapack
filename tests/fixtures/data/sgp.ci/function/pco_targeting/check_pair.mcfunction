#> sgp.ci:pco_targeting/check_pair
# {hunter,prey,damage}: test a team matchup with the same visible target.

$team join sgp.$(hunter) @s
$team join sgp.$(prey) PcoPrey
effect clear @s minecraft:strength
function sgp.majeurs:pco/empower
$function sgp.ci:pco_targeting/expect_damage {damage:$(damage)}
