#> sgp.majeurs:pco/cages/cage_detection
# @dummy
# @environment sgp.ci:pco/synchronous
#
# The cage floor detects standing or jumping players; ordinary ground and distant red concrete do not count as captivity.

function sgp.ci:pco/fixture
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.majeurs:pco/locations/select
function sgp.majeurs:pco/cage/restore {cage:"oie"}
tp @s ~6.5 ~2 ~0.5
execute positioned ~6 ~1 ~ run function sgp.majeurs:pco/cage/check_if_inside
assert score @s sgp.en_cage matches 1
tp @s ~6.5 ~3 ~0.5
execute positioned ~6 ~1 ~ run function sgp.majeurs:pco/cage/check_if_inside
assert score @s sgp.en_cage matches 1
tp @s ~12.5 ~1 ~3.5
execute positioned ~6 ~1 ~ run function sgp.majeurs:pco/cage/check_if_inside
assert score @s sgp.en_cage matches 0
setblock ~22 ~1 ~ red_concrete
tp @s ~22.5 ~2 ~0.5
scoreboard players set @s sgp.en_cage 1
execute positioned ~6 ~1 ~ run function sgp.majeurs:pco/cage/check_if_inside
assert score @s sgp.en_cage matches 0
