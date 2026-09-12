#> sgp.misc:cooldown_hud/render_does_not_advance
# @dummy
# @environment sgp.ci:cooldown_hud/render_does_not_advance
#
# Repeated display builds do not advance or reset the cooldown.

function sgp.ci:cooldown_hud/prepare_player
tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 41
function sgp.kits:abilities/tick
function sgp.ci:cooldown_hud/advance {ticks:20}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
assert score @s sgp.cooldown_ability matches 20
