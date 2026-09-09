#> sgp.ci:splash_arrows/scenarios/combined_effects

function sgp.ci:splash_arrows/fixture
function sgp.ci:splash_arrows/create {contents:{potion:"minecraft:long_poison",custom_effects:[{id:"minecraft:slowness",amplifier:1,duration:99}]}}
function sgp.ci:splash_arrows/convert
assert entity @e[tag=sgp.ci.splash_potion,distance=..6,nbt={Item:{components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:poison",duration:220}]}}}},type=splash_potion]
assert entity @e[tag=sgp.ci.splash_potion,distance=..6,nbt={Item:{components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:slowness",amplifier:1,duration:99}]}}}},type=splash_potion]
function sgp.ci:splash_arrows/cleanup
