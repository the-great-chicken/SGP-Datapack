#> sgp.misc:cooldown_hud/lifecycle
# @dummy
#
# A cooldown starts empty, fills over time, stays incomplete until expiry, and remains full while ready.

tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 41
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:0}

function sgp.ci:cooldown_hud/advance {ticks:20}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}

function sgp.ci:cooldown_hud/advance {ticks:19}
assert score @s sgp.cooldown_ability matches 1
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:19}
assert not data storage sgp:actionbar_hud overlay[{text:{translate:"sgp.kits.ability_bar.20"}}]

function sgp.kits:abilities/tick
assert score @s sgp.cooldown_ability matches 0
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:20}
function sgp.ci:cooldown_hud/advance {ticks:3}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:20}
