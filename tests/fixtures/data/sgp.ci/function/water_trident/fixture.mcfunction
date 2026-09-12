#> sgp.ci:water_trident/fixture
# A dry platform and natural water, with a distinctive trident whose other properties must survive enchantment updates.

execute as @a[tag=sgp.ci.water_actor] run dummy @s leave
kill @e[tag=sgp.marker,name=temp_water,type=marker]
fill ~ ~1 ~ ~20 ~4 ~4 air
fill ~ ~ ~ ~20 ~ ~4 stone
setblock ~4 ~1 ~ water strict
tag @s add sgp.ci.water_actor
tag @s add sgp.in_game
tag @s add sgp.poseidon
gamemode creative @s
tp @s ~0.5 ~1 ~0.5
item replace entity @s weapon.mainhand with trident[custom_data={sgp.water_trident:true,ci_keep:7},damage=31,enchantments={unbreaking:3}]
