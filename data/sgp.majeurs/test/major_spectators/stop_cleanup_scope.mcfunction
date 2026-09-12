#> sgp.majeurs:major_spectators/stop_cleanup_scope
# @dummy
# @environment sgp.ci:major_spectators/stop_cleanup_scope
#
# Only competitors are queued for synthetic death cleanup; spectators are simply released.

tag @s add sgp.major_participant
scoreboard players set @s sgp.streak_en_cours 7
dummy MajorPeer spawn
tag MajorPeer add sgp.major_spectator
scoreboard players set MajorPeer sgp.just_died 0
scoreboard players set MajorPeer sgp.synthetic_death 0
scoreboard players set MajorPeer sgp.streak_en_cours 11
function sgp.majeurs:common/stop
assert score @s sgp.just_died matches 1
assert score @s sgp.synthetic_death matches 1
assert score @s sgp.streak_en_cours matches 0
assert score MajorPeer sgp.just_died matches 0
assert score MajorPeer sgp.synthetic_death matches 0
assert score MajorPeer sgp.streak_en_cours matches 11
