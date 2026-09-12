#> sgp.kits:splash_arrows/eligibility
# @environment sgp.ci:splash_arrows

function sgp.ci:splash_arrows/fixture
summon arrow ~2 ~2 ~2 {Tags:["sgp.ci.splash_arrow"]}
execute as @n[tag=sgp.ci.splash_arrow,distance=..6,type=arrow] run function sgp.kits:enchantments/tag_special_arrow
assert not entity @e[tag=sgp.ci.splash_arrow,tag=sgp.special_splash_arrow,distance=..6,type=arrow]
kill @e[tag=sgp.ci.splash_arrow,type=arrow]
function sgp.ci:splash_arrows/create {contents:{potion:"minecraft:long_poison"}}
execute as @n[tag=sgp.ci.splash_arrow,distance=..6,type=arrow] run function sgp.kits:enchantments/tag_special_arrow
assert entity @e[tag=sgp.ci.splash_arrow,tag=sgp.special_splash_arrow,distance=..6,type=arrow]
function sgp.ci:splash_arrows/cleanup
