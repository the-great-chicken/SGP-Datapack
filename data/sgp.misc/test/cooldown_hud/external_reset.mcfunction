#> sgp.misc:cooldown_hud/external_reset
# @dummy
# @environment sgp.ci:cooldown_hud/external_reset
#
# An externally cleared cooldown becomes ready immediately and the next cooldown uses its own duration.

function sgp.ci:cooldown_hud/prepare_player
tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 41
function sgp.kits:abilities/tick
function sgp.ci:cooldown_hud/advance {ticks:10}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:5}
scoreboard players set @s sgp.cooldown_ability 0
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:20}
scoreboard players set @s sgp.cooldown_ability 11
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:0}
function sgp.ci:cooldown_hud/advance {ticks:5}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
