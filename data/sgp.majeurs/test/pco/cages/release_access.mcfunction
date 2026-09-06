#> sgp.majeurs:pco/cages/release_access
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Free teammates can use the release trigger within eight blocks; pending clicks survive refresh, and departure or captivity revokes access.

function sgp.ci:pco/fixture
team join sgp.Oie @s
scoreboard players set @s sgp.en_cage 0
tp @s ~8 ~1 ~
execute positioned ~ ~1 ~ run function sgp.majeurs:pco/cage/check_can_uncage {team:"oie"}
trigger sgp.liberer_oies add 1
assert score @s sgp.liberer_oies matches 2
execute positioned ~ ~1 ~ run function sgp.majeurs:pco/cage/check_can_uncage {team:"oie"}
assert score @s sgp.liberer_oies matches 2

tp @s ~8.01 ~1 ~
execute positioned ~ ~1 ~ run function sgp.majeurs:pco/cage/check_can_uncage {team:"oie"}
assert not score @s sgp.liberer_oies matches 0..
tp @s ~7.99 ~1 ~
execute positioned ~ ~1 ~ run function sgp.majeurs:pco/cage/check_can_uncage {team:"oie"}
trigger sgp.liberer_oies add 1
assert score @s sgp.liberer_oies matches 2
scoreboard players set @s sgp.en_cage 1
execute positioned ~ ~1 ~ run function sgp.majeurs:pco/cage/check_can_uncage {team:"oie"}
assert not score @s sgp.liberer_oies matches 0..
