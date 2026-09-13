#> sgp.ci:rays/count
# `{count: nonnegative int}`
#
# Count only beam displays linked to the executing caster.

scoreboard players operation $link.to bs.in = @s bs.id
execute positioned 8.0 88.0 8.0 store result score #ci.rays.count sgp.dummy if entity @e[tag=sgp.ray,predicate=bs.link:link_equal,distance=..64,type=item_display]
$assert score #ci.rays.count sgp.dummy matches $(count)
