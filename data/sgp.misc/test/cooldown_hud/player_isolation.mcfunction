#> sgp.misc:cooldown_hud/player_isolation
# @dummy
#
# Alternating between players preserves each player's progress and kit appearance in the shared render storage.

data modify storage sgp:data tests.hud_players set value {}
tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 41
dummy HudIsolation spawn
tag HudIsolation add sgp.in_game
scoreboard players set HudIsolation sgp.kit_id 4
scoreboard players set HudIsolation sgp.cooldown_ability 81
function sgp.kits:abilities/tick
function sgp.ci:cooldown_hud/advance {ticks:20}

function sgp.misc:actionbar/hud/build
data modify storage sgp:data tests.hud_players.first set from storage sgp:actionbar_hud overlay
execute as HudIsolation run function sgp.misc:actionbar/hud/build
data modify storage sgp:data tests.hud_players.second set from storage sgp:actionbar_hud overlay
dummy HudIsolation leave

assert data storage sgp:data tests.hud_players.first[0]
assert data storage sgp:data tests.hud_players.second[0]
data modify storage sgp:actionbar_hud overlay set from storage sgp:data tests.hud_players.first
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
data modify storage sgp:actionbar_hud overlay set from storage sgp:data tests.hud_players.second
function sgp.ci:cooldown_hud/expect {kit:"pyromane",frame:5}

function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
data remove storage sgp:data tests.hud_players
