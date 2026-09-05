#> sgp.majeurs:pco/cabane/actionbar_build_width
# Add the active PCO refuge segment to the HUD width.

execute if score @s sgp.ab.pco_cabane matches 1.. run scoreboard players operation @s sgp.ab.normal_width += #sgp.ab.width.pco_cabane sgp.dummy
execute if score @s sgp.ab.pco_cabane matches 1.. run scoreboard players add @s sgp.ab.normal_count 1
