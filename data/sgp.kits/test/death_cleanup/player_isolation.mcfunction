#> sgp.kits:death_cleanup/player_isolation
# @dummy
# @environment sgp.ci:death_cleanup/player_isolation
#
# Cleaning up one Tank leaves another Tank's active ability, loadout, and reward progress intact.

function sgp.ci:death_cleanup/fixture
function sgp.ci:death_cleanup/tank
dummy DeathPeer spawn
execute as DeathPeer run function sgp.ci:death_cleanup/fixture
execute as DeathPeer run function sgp.ci:death_cleanup/tank
function sgp.kits:cleanup_after_death
function sgp.ci:death_cleanup/expect_cleared
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}
execute as DeathPeer run function sgp.ci:bigger/expect {scale:"199999..200001",jump:"52499..52501",reach:"449999..450001",damage:"199999..200001"}
assert entity @a[name=DeathPeer,tag=sgp.tank]
assert score DeathPeer sgp.kit_id matches 5
assert score DeathPeer sgp.duration_ability matches 80
assert score DeathPeer sgp.cooldown_ability matches 400
assert score DeathPeer sgp.kills_give_1 matches 4
assert score DeathPeer sgp.kills_give_2 matches 3
assert score DeathPeer sgp.kills_give_3 matches 2
assert data entity DeathPeer Inventory[0]
