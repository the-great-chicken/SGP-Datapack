#> sgp.ci:cooldown_hud/prepare_player
# Establish a fresh HUD lifecycle even if a reused dummy UUID retains scoreboard values.

function sgp.misc:actionbar/ability_cooldown_clear
scoreboard players set @s sgp.duration_ability 0
scoreboard players set @s sgp.drop_any 0
