#> sgp.ci:splash_arrows/scenarios/custom_effects

function sgp.ci:splash_arrows/fixture
function sgp.ci:splash_arrows/create {contents:{custom_effects:[{id:"minecraft:poison",amplifier:2,duration:87},{id:"minecraft:slowness",amplifier:1,duration:145}]}}
function sgp.ci:splash_arrows/convert
execute store result score #ci.splash.count sgp.dummy if entity @e[tag=sgp.ci.splash_potion,distance=..6,type=splash_potion]
assert score #ci.splash.count sgp.dummy matches 1
assert entity @e[tag=sgp.ci.splash_potion,distance=..6,nbt={Item:{components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:poison",amplifier:2,duration:87},{id:"minecraft:slowness",amplifier:1,duration:145}]}}}},type=splash_potion]
function sgp.ci:splash_arrows/cleanup
