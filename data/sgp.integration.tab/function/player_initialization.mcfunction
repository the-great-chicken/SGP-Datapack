#> sgp.integration.tab:player_initialization
# A score of -1 is clean, 0 is ready, and 1..5 is the location debounce.

scoreboard players add @s sgp.tab_dirty 0
scoreboard players add @s sgp.tab_candidate 0
execute unless score @s sgp.tab_applied matches -2147483648..2147483647 run scoreboard players set @s sgp.tab_applied -1
