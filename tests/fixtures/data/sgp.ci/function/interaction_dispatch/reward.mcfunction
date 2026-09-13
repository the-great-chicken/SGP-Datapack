#> sgp.ci:interaction_dispatch/reward
# `{item: item id, count: positive int}`
#
# An observable callback result on the recipient, plus a count to detect duplicate dispatch.

$item replace entity @s hotbar.0 with $(item) $(count)
scoreboard players add @s sgp.dummy 1
