#> sgp.ci:hider_teams/expect_groups
# `{g1, g2, g3, g4, g5: nonnegative int}`
#
# Check the resulting distribution of hider group sizes without depending on which players were grouped.

assert not entity @a[team=sgp.hider,tag=sgp.ci.hider_actor,tag=!sgp.hider]
scoreboard players set #ci.hs.g1 sgp.dummy 0
scoreboard players set #ci.hs.g2 sgp.dummy 0
scoreboard players set #ci.hs.g3 sgp.dummy 0
scoreboard players set #ci.hs.g4 sgp.dummy 0
scoreboard players set #ci.hs.g5 sgp.dummy 0
execute as @a[team=sgp.hider,tag=sgp.ci.hider_actor] run function sgp.ci:hider_teams/count_group
scoreboard players operation #ci.hs.g2 sgp.dummy /= 2 sgp.dummy
scoreboard players operation #ci.hs.g3 sgp.dummy /= 3 sgp.dummy
scoreboard players operation #ci.hs.g4 sgp.dummy /= 4 sgp.dummy
scoreboard players operation #ci.hs.g5 sgp.dummy /= 5 sgp.dummy
$assert score #ci.hs.g1 sgp.dummy matches $(g1)
$assert score #ci.hs.g2 sgp.dummy matches $(g2)
$assert score #ci.hs.g3 sgp.dummy matches $(g3)
$assert score #ci.hs.g4 sgp.dummy matches $(g4)
$assert score #ci.hs.g5 sgp.dummy matches $(g5)
