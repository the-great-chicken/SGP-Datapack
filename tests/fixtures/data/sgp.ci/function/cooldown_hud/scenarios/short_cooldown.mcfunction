#> sgp.ci:cooldown_hud/scenarios/short_cooldown

function sgp.ci:cooldown_hud/prepare_player
tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 5
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:0}
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:5}
function sgp.ci:cooldown_hud/advance {ticks:2}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:15}
function sgp.kits:abilities/tick
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:20}
