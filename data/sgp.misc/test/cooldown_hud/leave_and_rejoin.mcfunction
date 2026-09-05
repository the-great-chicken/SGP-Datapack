#> sgp.misc:cooldown_hud/leave_and_rejoin
# @dummy
#
# Leaving hides an active HUD; returning with a new cooldown rebuilds it without retaining the old progress.

tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 41
function sgp.kits:abilities/tick
function sgp.ci:cooldown_hud/advance {ticks:20}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}

function sgp.misc:players_in_game/leave
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
assert not data storage sgp:actionbar_hud overlay[0]

tag @s add sgp.in_game
scoreboard players set @s sgp.cooldown_ability 81
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:0}
function sgp.ci:cooldown_hud/advance {ticks:40}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
