#> sgp.ci:cooldown_hud/scenarios/active_kit_change

function sgp.ci:cooldown_hud/prepare_player
tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 41
function sgp.kits:abilities/tick
function sgp.ci:cooldown_hud/advance {ticks:20}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
scoreboard players set @s sgp.kit_id 4
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"pyromane",frame:10}
function sgp.ci:cooldown_hud/advance {ticks:10}
function sgp.misc:actionbar/hud/build
function sgp.ci:cooldown_hud/expect {kit:"pyromane",frame:15}
