#> sgp.majeurs:protect/combat/king_disconnect
# @dummy
# @environment sgp.ci:protect
#
# A disconnected king ends his team's respawn protection, but living teammates can keep fighting.

function sgp.ci:protect/roster
dummy PrBlueKing leave
tp PrBlueA ~30.5 ~1 ~0.5
function sgp.majeurs:protect/running
assert chat ".*roi de l'Equipe Bleu est mort.*" @s
assert entity @a[name=PrBlueA,tag=sgp.major_spectator,gamemode=spectator]
assert entity @a[name=PrBlueB,team=sgp.bleue,tag=sgp.major_participant]
assert entity @a[name=PrRedKing,tag=sgp.roi_rouge]
assert score #protect_phase sgp.dummy matches 2
assert score #rounds sgp.dummy matches 0

# Losing the last surviving member must still finish the round without another death.
dummy PrBlueB leave
function sgp.majeurs:protect/running
assert chat ".*Rouge a gagné.*" @s
function sgp.ci:protect/expect_finished
