#> sgp.majeurs:hide_and_seek/actionbar/build_width
#
# Add the active Cache-cache hiding timer segment to the HUD width.

execute if score @s sgp.ab.hide_hider matches 1.. run scoreboard players operation @s sgp.ab.normal_width += #sgp.ab.width.hide_hider sgp.dummy
execute if score @s sgp.ab.hide_hider matches 1.. if score #hider sgp.timer matches 10.. run scoreboard players operation @s sgp.ab.normal_width += 12 sgp.dummy
execute if score @s sgp.ab.hide_hider matches 1.. run scoreboard players add @s sgp.ab.normal_count 1
