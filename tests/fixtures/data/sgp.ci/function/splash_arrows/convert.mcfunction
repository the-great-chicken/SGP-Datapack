#> sgp.ci:splash_arrows/convert
# Run the production tipped-arrow conversion for the executing arrow and tag the resulting splash potion.

execute as @n[tag=sgp.ci.splash_arrow,distance=..6,type=arrow] at @s run function sgp.kits:enchantments/summon_custom_splash_potion
assert not entity @e[tag=sgp.ci.splash_arrow,distance=..6,type=arrow]
tag @e[distance=..6,type=splash_potion] add sgp.ci.splash_potion
