#> sgp.ci:diorama_weapon/expect_piercing
# `{present: 0|1}`
#
# Check whether the held weapon has the production piercing marker.

execute store success score @s sgp.dummy if items entity @s weapon.mainhand *[piercing_weapon]
$assert score @s sgp.dummy matches $(present)
