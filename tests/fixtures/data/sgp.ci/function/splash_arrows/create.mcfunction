#> sgp.ci:splash_arrows/create
# {contents}
$summon arrow ~2 ~2 ~2 {Tags:["sgp.ci.splash_arrow"],item:{id:"minecraft:tipped_arrow",count:1,components:{"minecraft:potion_contents":$(contents)}}}
assert entity @e[tag=sgp.ci.splash_arrow,distance=..6,type=arrow]
