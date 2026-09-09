#> sgp.ci:diorama_lifecycle/count
# {type, count}
# Count this owner's visible representations, not dying entities removed below the world.
scoreboard players operation $link.to bs.in = @s bs.id
$execute positioned 24.0 80.0 24.0 store result score #ci.lifecycle.count sgp.dummy if entity @e[tag=sgp.$(type)_mannequin_96001,predicate=bs.link:link_equal,distance=..50,type=mannequin]
$assert score #ci.lifecycle.count sgp.dummy matches $(count)
