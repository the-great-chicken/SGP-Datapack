#> sgp.kits:splash_arrows/combined_effects
# @environment sgp.ci:splash_arrows

function sgp.ci:splash_arrows/fixture
function sgp.ci:splash_arrows/create {contents:{potion:"minecraft:long_poison",custom_effects:[{id:"minecraft:slowness",amplifier:1,duration:99}]}}
function sgp.ci:splash_arrows/convert
execute store result score #ci.splash.count sgp.dummy if entity @e[tag=sgp.ci.splash_potion,distance=..6,type=splash_potion]
assert score #ci.splash.count sgp.dummy matches 1
assert entity @e[tag=sgp.ci.splash_potion,distance=..6,nbt={Item:{components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:slowness",amplifier:1b,duration:99},{id:"minecraft:poison",duration:220}]}}}},type=splash_potion]
# Minecraft omits the default amplifier (0) from the saved effect.
assert not data entity @n[tag=sgp.ci.splash_potion,distance=..6,type=splash_potion] Item.components."minecraft:potion_contents".custom_effects[{id:"minecraft:poison"}].amplifier
function sgp.ci:splash_arrows/cleanup
