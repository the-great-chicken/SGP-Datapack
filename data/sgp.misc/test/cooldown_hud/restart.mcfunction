#> sgp.misc:cooldown_hud/restart
# @dummy
#
# A shorter replacement cooldown starts empty without a ready frame in between; a later longer cooldown uses its own duration.

tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 81
function sgp.kits:abilities/tick
function sgp.ci:cooldown_hud/advance {ticks:79}
assert score @s sgp.cooldown_ability matches 1
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:19}

scoreboard players set @s sgp.cooldown_ability 21
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:0}
function sgp.ci:cooldown_hud/advance {ticks:10}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}

function sgp.ci:cooldown_hud/advance {ticks:10}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:20}
scoreboard players set @s sgp.cooldown_ability 81
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:0}
function sgp.ci:cooldown_hud/advance {ticks:40}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
