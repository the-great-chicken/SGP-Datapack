#> sgp.ci:pco_targeting/fixture

fill ~ ~ ~ ~8 ~ ~8 stone
fill ~ ~1 ~ ~8 ~5 ~8 air
gamemode survival @s
clear @s
attribute @s minecraft:attack_damage base set 1
tp @s ~2.5 ~1 ~2.5 0 0
dummy PcoPrey spawn
gamemode survival PcoPrey
attribute PcoPrey minecraft:attack_damage base set 1
tp PcoPrey ~2.5 ~1 ~5.5 180 0
team join sgp.Poule @s
team join sgp.Canard PcoPrey
