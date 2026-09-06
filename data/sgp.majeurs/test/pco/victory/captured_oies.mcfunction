#> sgp.majeurs:pco/victory/captured_oies
# @dummy
# @environment sgp.ci:pco/synchronous
#
# A stale cage score or partial capture cannot end the round; capturing both Oies awards the Canards and cleans up once.

function sgp.ci:pco/round_fixture
tp @s ~6.5 ~2 ~0.5
scoreboard players set PcoRoundOie sgp.en_cage 1
function sgp.majeurs:pco/running
assert score #pco_phase sgp.dummy matches 2
assert score #rounds sgp.dummy matches 0
assert score @s sgp.en_cage matches 1
assert score PcoRoundOie sgp.en_cage matches 0
assert not chat ".*Canards victorieux.*" @s

tp PcoRoundOie ~6.5 ~2 ~0.5
function sgp.majeurs:pco/running
assert chat ".*Canards victorieux.*" @s
assert score #pco_phase sgp.dummy matches 0
assert score #rounds sgp.dummy matches 1
function sgp.ci:pco/expect_teams {total:0,min:0,max:0}
assert not entity @a[tag=sgp.ci.pco_actor,tag=sgp.major_participant]
assert not entity @a[tag=sgp.ci.pco_actor,gamemode=!survival]
assert block ~6 ~2 ~ air
function sgp.majeurs:pco/running
assert score #rounds sgp.dummy matches 1
