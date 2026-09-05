#> sgp.misc:cooldown_hud/kit_changes
# @dummy
#
# The ready HUD follows the selected kit's appearance and disappears when the kit is cleared.

tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 0
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:20}

# Supply the next selected kit without invoking the kit-selection statistics pipeline.
scoreboard players set @s sgp.kit_id 4
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"pyromane",frame:20}

function sgp.kits:clear
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
assert not data storage sgp:actionbar_hud overlay[0]
