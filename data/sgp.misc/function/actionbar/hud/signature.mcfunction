#> sgp.misc:actionbar/hud/signature
#
# The composed overlay is a pure function of the kit, the HUD visibility, the cooldown frame and the
# normal actionbar width (plus load-time constants, invalidated by initialization). Fold them into one
# score so a render can tell whether the cached overlay is still exact. -1 means "no overlay".

scoreboard players set @s sgp.ab.hud_sig -1
execute unless score @s sgp.kit_id matches 0.. run return 0
execute unless score @s sgp.ab.hud_ability matches 1 run return 0
scoreboard players operation @s sgp.ab.hud_sig = @s sgp.ab.normal_width
scoreboard players operation @s sgp.ab.hud_sig *= 32 sgp.dummy
scoreboard players operation @s sgp.ab.hud_sig += @s sgp.ab.hud_ability_fill
scoreboard players operation @s sgp.ab.hud_sig *= 32 sgp.dummy
scoreboard players operation @s sgp.ab.hud_sig += @s sgp.kit_id
