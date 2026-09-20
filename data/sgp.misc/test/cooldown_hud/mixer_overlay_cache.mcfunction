#> sgp.misc:cooldown_hud/mixer_overlay_cache
# @dummy
# @environment sgp.ci:mixer_overlay_cache
#
# A Mixer render reuses the cached HUD overlay while its inputs are unchanged, and rebuilds it as soon as they change.

function sgp.ci:actionbar_mixer/fresh_registration
await score @s dah.actbar.UID matches 1..
execute store result storage sgp.ci:cooldown_hud macro.uid int 1 run scoreboard players get @s dah.actbar.UID
function sgp.ci:cooldown_hud/isolate_mixer_entry with storage sgp.ci:cooldown_hud macro
function sgp.ci:cooldown_hud/prepare_player
tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 41
function sgp.kits:abilities/tick
function sgp.ci:cooldown_hud/advance {ticks:20}
function dah.actbar_mixer:z_private/display/prepare
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}
execute store success score #ci.hud.hit sgp.dummy if score @s sgp.ab.hud_sig_cached = @s sgp.ab.hud_sig
assert score #ci.hud.hit sgp.dummy matches 1
data modify storage sgp.ci:cooldown_hud cache.first set from storage sgp:actionbar_hud overlay

# Poison the overlay: an unchanged signature must restore the identical component list from the cache.
data remove storage sgp:actionbar_hud overlay
function dah.actbar_mixer:z_private/display/prepare
data modify storage sgp.ci:cooldown_hud cache.second set from storage sgp:actionbar_hud overlay
execute store success score #ci.hud.changed sgp.dummy run data modify storage sgp.ci:cooldown_hud cache.first set from storage sgp.ci:cooldown_hud cache.second
assert score #ci.hud.changed sgp.dummy matches 0
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:10}

# Frame, kit and width changes each rebuild.
function sgp.ci:cooldown_hud/advance {ticks:10}
function dah.actbar_mixer:z_private/display/prepare
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:15}
scoreboard players set @s sgp.kit_id 4
function dah.actbar_mixer:z_private/display/prepare
function sgp.ci:cooldown_hud/expect {kit:"pyromane",frame:15}
scoreboard players set @s sgp.ab.reward_1 1
scoreboard players set @s sgp.ab.reward_1_width 40
function dah.actbar_mixer:z_private/display/prepare
data modify storage sgp.ci:cooldown_hud cache.third set from storage sgp:actionbar_hud overlay
execute store success score #ci.hud.changed sgp.dummy run data modify storage sgp.ci:cooldown_hud cache.second set from storage sgp.ci:cooldown_hud cache.third
assert score #ci.hud.changed sgp.dummy matches 1
function sgp.ci:cooldown_hud/expect {kit:"pyromane",frame:15}

# A hidden HUD is cached as empty and restored as absent.
function sgp.misc:actionbar/ability_cooldown_clear
function dah.actbar_mixer:z_private/display/prepare
assert not data storage sgp:actionbar_hud overlay[0]
function dah.actbar_mixer:z_private/display/prepare
assert not data storage sgp:actionbar_hud overlay[0]
data remove storage sgp.ci:cooldown_hud cache
data remove storage sgp.ci:cooldown_hud macro
