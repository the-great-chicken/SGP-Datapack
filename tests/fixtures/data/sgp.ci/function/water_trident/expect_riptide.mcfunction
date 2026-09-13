#> sgp.ci:water_trident/expect_riptide
# `{present: 0|1}`
#
# Check whether the requesting player's held trident can use Riptide.

execute store success score @s sgp.dummy if items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]]
$assert score @s sgp.dummy matches $(present)
