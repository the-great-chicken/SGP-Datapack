#> sgp.ci:pco/expect_teams
# `{total, min, max}`
# Check team sizes without depending on random player assignments.

execute store result score #ci.pco.poule sgp.dummy if entity @a[team=sgp.Poule]
execute store result score #ci.pco.canard sgp.dummy if entity @a[team=sgp.Canard]
execute store result score #ci.pco.oie sgp.dummy if entity @a[team=sgp.Oie]
scoreboard players operation #ci.pco.total sgp.dummy = #ci.pco.poule sgp.dummy
scoreboard players operation #ci.pco.total sgp.dummy += #ci.pco.canard sgp.dummy
scoreboard players operation #ci.pco.total sgp.dummy += #ci.pco.oie sgp.dummy
$assert score #ci.pco.poule sgp.dummy matches $(min)..$(max)
$assert score #ci.pco.canard sgp.dummy matches $(min)..$(max)
$assert score #ci.pco.oie sgp.dummy matches $(min)..$(max)
$assert score #ci.pco.total sgp.dummy matches $(total)
