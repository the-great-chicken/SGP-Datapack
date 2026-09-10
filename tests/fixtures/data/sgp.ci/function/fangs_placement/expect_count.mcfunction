#> sgp.ci:fangs_placement/expect_count
# `{count: nonnegative int}`
#
# Require exactly the expected number of fixture fangs near the cast area.

execute store result score #ci.fangs.count sgp.dummy if entity @e[tag=sgp.ci.fang,distance=..24,type=evoker_fangs]
$assert score #ci.fangs.count sgp.dummy matches $(count)
