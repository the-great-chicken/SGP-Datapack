#> sgp.ci:diorama_weapon/expect_piercing
# {present}
execute store success score @s sgp.dummy if items entity @s weapon.mainhand *[piercing_weapon]
$assert score @s sgp.dummy matches $(present)
