#> sgp.ci:diorama_rejoin/count
# `{type: small|giant, count: nonnegative int}`
scoreboard players operation $link.to bs.in = @s bs.id
$execute positioned 24.0 80.0 24.0 store result score #ci.rejoin.count sgp.dummy if entity @e[tag=sgp.$(type)_mannequin_96001,predicate=bs.link:link_equal,distance=..128,type=mannequin]
$assert score #ci.rejoin.count sgp.dummy matches $(count)
