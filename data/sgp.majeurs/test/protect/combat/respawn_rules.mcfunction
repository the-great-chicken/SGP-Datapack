#> sgp.majeurs:protect/combat/respawn_rules
# @dummy
# @environment sgp.ci:protect/combat/respawn_rules
#
# Respawning is allowed while the king lives. After his death, only that team's players reaching the respawn area are eliminated.

function sgp.ci:protect/roster
tp PrRedA ~33.5 ~1 ~0.5
tp PrRedB ~33.6 ~1 ~0.5
tp PrBlueA ~30.5 ~1 ~0.5
function sgp.majeurs:protect/running
assert entity @a[name=PrRedA,team=sgp.rouge,tag=sgp.major_participant]
assert entity @a[name=PrBlueA,team=sgp.bleue,tag=sgp.major_participant]
assert not entity @a[tag=sgp.ci.protect_actor,tag=sgp.major_spectator]

tp PrRedKing ~30.5 ~1 ~0.5
function sgp.majeurs:protect/running
assert not entity @a[name=PrRedKing,tag=sgp.roi_rouge]
assert entity @a[name=PrRedKing,tag=sgp.major_spectator,gamemode=spectator]
assert entity @a[name=PrRedA,tag=sgp.major_spectator,gamemode=spectator]
assert not entity @a[name=PrRedA,tag=sgp.major_participant]
assert entity @a[name=PrRedB,team=sgp.rouge,tag=sgp.major_participant]
assert entity @a[name=PrBlueA,team=sgp.bleue,tag=sgp.major_participant]
assert entity @a[name=PrBlueKing,tag=sgp.roi_bleu]
assert chat ".*roi de l'Equipe Rouge est mort.*" @s
assert score #protect_phase sgp.dummy matches 2
assert score #rounds sgp.dummy matches 0
