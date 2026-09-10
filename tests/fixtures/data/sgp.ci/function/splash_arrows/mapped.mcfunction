#> sgp.ci:splash_arrows/mapped
# `{potion: potion id, effect: effect id}`
#
# Convert a mapped vanilla potion and require the resulting splash potion to contain the expected custom effect.

function sgp.ci:splash_arrows/fixture
$function sgp.ci:splash_arrows/create {contents:{potion:"$(potion)"}}
function sgp.ci:splash_arrows/convert
execute store result score #ci.splash.count sgp.dummy if entity @e[tag=sgp.ci.splash_potion,distance=..6,type=splash_potion]
assert score #ci.splash.count sgp.dummy matches 1
$assert entity @e[tag=sgp.ci.splash_potion,distance=..6,nbt={Item:{components:{"minecraft:potion_contents":{custom_effects:[{id:"$(effect)",duration:220}]}}}},type=splash_potion]
