#> sgp.kits:bats/equipment/player_isolation
# @dummy
# @environment sgp.ci:bats_equipment
#
# Ending one player's hiding restores only their equipment, even with another hidden player beside them.

function sgp.ci:bats_equipment/fixture
dummy BatOther spawn
tag BatOther add sgp.ci.bats_actor
gamemode creative BatOther
tp BatOther ~1.5 ~1 ~0.5
execute as BatOther run function sgp.ci:bats_equipment/equip
item replace entity BatOther weapon.offhand with apple 5
function sgp.ci:bats_equipment/snapshot {key:first_before}
execute as BatOther run function sgp.ci:bats_equipment/snapshot {key:other_before}
function sgp.ci:bats_equipment/hide
execute as BatOther run function sgp.ci:bats_equipment/hide
execute as BatOther run function sgp.ci:bats_equipment/snapshot {key:other_hidden}
function sgp.kits:abilities/bats/end
function sgp.ci:bats_equipment/expect_snapshot {key:first_before}
execute as BatOther run function sgp.ci:bats_equipment/expect_snapshot {key:other_hidden}
execute as BatOther run function sgp.kits:abilities/bats/end
execute as BatOther run function sgp.ci:bats_equipment/expect_snapshot {key:other_before}
