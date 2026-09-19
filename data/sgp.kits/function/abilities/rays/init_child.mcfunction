#> sgp.kits:abilities/rays/init_child

scoreboard players set @s sgp.timer 70
# The beam's sgp.dummy score caches its length in thousandths of a block.
scoreboard players set @s sgp.dummy 16000
tag @s add sgp.ray_refreshed
tag @s remove sgp.new
