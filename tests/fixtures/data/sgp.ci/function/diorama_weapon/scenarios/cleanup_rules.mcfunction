#> sgp.ci:diorama_weapon/scenarios/cleanup_rules

function sgp.ci:diorama_weapon/fixture
item replace entity @s weapon.mainhand with stick
function sgp.diorama:left_click/add_piercing_weapon
function sgp.diorama:left_click/remove_piercing_weapon
function sgp.ci:diorama_weapon/expect_piercing {present:1}
function sgp.ci:diorama_weapon/nearby
item replace entity WeaponOther weapon.mainhand with stick[piercing_weapon={}]
tag @s add sgp.around_model
function sgp.diorama:left_click/remove_piercing_weapon
function sgp.ci:diorama_weapon/expect_piercing {present:1}
tag @s remove sgp.around_model
function sgp.diorama:left_click/remove_piercing_weapon
function sgp.ci:diorama_weapon/expect_piercing {present:0}
execute as WeaponOther run function sgp.ci:diorama_weapon/expect_piercing {present:1}
dummy WeaponOther leave
