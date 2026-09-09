#> sgp.ci:splash_arrows/scenarios/nearby_potion

function sgp.ci:splash_arrows/fixture
summon splash_potion ~2 ~2 ~2 {Tags:["sgp.ci.splash_potion","sgp.ci.splash_control"],Item:{id:"minecraft:splash_potion",count:1,components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:weakness",duration:333}]}}}}
function sgp.ci:splash_arrows/create {contents:{custom_effects:[{id:"minecraft:poison",amplifier:1,duration:99}]}}
function sgp.ci:splash_arrows/convert
assert entity @e[tag=sgp.ci.splash_control,distance=..6,nbt={Item:{components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:weakness",duration:333}]}}}},type=splash_potion]
assert not entity @e[tag=sgp.ci.splash_control,distance=..6,nbt={Item:{components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:poison"}]}}}},type=splash_potion]
assert entity @e[tag=sgp.ci.splash_potion,tag=!sgp.ci.splash_control,distance=..6,nbt={Item:{components:{"minecraft:potion_contents":{custom_effects:[{id:"minecraft:poison",amplifier:1,duration:99}]}}}},type=splash_potion]
function sgp.ci:splash_arrows/cleanup
