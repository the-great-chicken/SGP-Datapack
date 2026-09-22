#> sgp.misc:cooldown_hud/frame_gate
# @dummy
# @environment sgp.ci:cooldown_hud/frame_gate
#
# The per-tick cooldown HUD refresh only recomputes the frame when it can change. Frame, max
# and the "next change" threshold stay exact through normal ticking, a cooldown halved by
# frenzy, a new cooldown right after the previous one expired, and an unset threshold.
function sgp.ci:cooldown_hud/prepare_player
tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 100
function sgp.misc:actionbar/ability_cooldown_gate
assert score @s sgp.ab.hud_ability_fill matches 0
assert score @s sgp.ab.ability_cooldown_max matches 100
assert score @s sgp.ab.ability_cooldown_next matches 95
# Ticks that cannot change the frame skip the recompute (last_current stays stale on purpose).
scoreboard players set @s sgp.cooldown_ability 97
function sgp.misc:actionbar/ability_cooldown_gate
assert score @s sgp.ab.ability_cooldown_last_current matches 100
assert score @s sgp.ab.hud_ability_fill matches 0
scoreboard players set @s sgp.cooldown_ability 95
function sgp.misc:actionbar/ability_cooldown_gate
assert score @s sgp.ab.hud_ability_fill matches 1
assert score @s sgp.ab.ability_cooldown_last_current matches 95
assert score @s sgp.ab.ability_cooldown_next matches 90
# A cooldown that drops several frames at once (frenzy halves it) is redrawn the same tick.
scoreboard players set @s sgp.cooldown_ability 47
function sgp.misc:actionbar/ability_cooldown_gate
assert score @s sgp.ab.hud_ability_fill matches 10
assert score @s sgp.ab.ability_cooldown_next matches 45
scoreboard players set @s sgp.cooldown_ability 46
function sgp.misc:actionbar/ability_cooldown_gate
assert score @s sgp.ab.hud_ability_fill matches 10
assert score @s sgp.ab.ability_cooldown_last_current matches 47
scoreboard players set @s sgp.cooldown_ability 45
function sgp.misc:actionbar/ability_cooldown_gate
assert score @s sgp.ab.hud_ability_fill matches 11
# The real ability tick produces the same frames as the ungated path: 45 -> 1 over 44 ticks.
function sgp.ci:cooldown_hud/advance {ticks:44}
assert score @s sgp.cooldown_ability matches 1
assert score @s sgp.ab.hud_ability_fill matches 19
# Expiry, then a new cooldown: its max is re-inferred and the threshold restarts.
function sgp.ci:cooldown_hud/advance {ticks:1}
assert score @s sgp.cooldown_ability matches 0
assert score @s sgp.ab.hud_ability_fill matches 20
assert score @s sgp.ab.ability_cooldown matches 0
scoreboard players set @s sgp.cooldown_ability 200
function sgp.misc:actionbar/ability_cooldown_gate
assert score @s sgp.ab.ability_cooldown_max matches 200
assert score @s sgp.ab.hud_ability_fill matches 0
assert score @s sgp.ab.ability_cooldown_next matches 190
function sgp.ci:cooldown_hud/advance {ticks:1}
assert score @s sgp.cooldown_ability matches 199
assert score @s sgp.ab.ability_cooldown_last_current matches 200
assert score @s sgp.ab.hud_ability_fill matches 0
# An unset threshold (objective created by a reload mid-cooldown) forces a recompute.
scoreboard players reset @s sgp.ab.ability_cooldown_next
scoreboard players set @s sgp.cooldown_ability 150
function sgp.misc:actionbar/ability_cooldown_gate
assert score @s sgp.ab.hud_ability_fill matches 5
assert score @s sgp.ab.ability_cooldown_next matches 140
function sgp.misc:actionbar/ability_cooldown_clear
tag @s remove sgp.in_game
