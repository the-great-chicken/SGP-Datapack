#> sgp.ci:protect/expect_finished
# A completed round releases participants and spectators and cannot be counted twice.

assert score #protect_phase sgp.dummy matches 0
assert score #rounds sgp.dummy matches 1
assert not entity @a[team=sgp.rouge]
assert not entity @a[team=sgp.bleue]
assert not entity @a[tag=sgp.ci.protect_actor,tag=sgp.major_participant]
assert not entity @a[tag=sgp.ci.protect_actor,tag=sgp.major_spectator]
assert not entity @a[tag=sgp.roi_rouge]
assert not entity @a[tag=sgp.roi_bleu]
assert entity @a[name=PrRedA,gamemode=survival]
assert entity @a[name=PrBlueA,gamemode=survival]
function sgp.majeurs:protect/running
function sgp.majeurs:protect/_stop
assert score #rounds sgp.dummy matches 1
