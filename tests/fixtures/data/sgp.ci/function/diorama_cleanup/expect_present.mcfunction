#> sgp.ci:diorama_cleanup/expect_present
# `{group: fixture group}`
#
# Require both members of a fixture pair to remain alive and correctly mounted.

$assert entity @e[tag=sgp.ci.removal_$(group),distance=..16,nbt={Health:20f},type=mannequin]
$assert entity @e[tag=sgp.ci.removal_$(group),distance=..16,type=text_display]
$execute as @n[tag=sgp.ci.removal_$(group),distance=..16,type=text_display] store success score #ci.removal.mounted sgp.dummy on vehicle if entity @s[tag=sgp.ci.removal_$(group),type=mannequin]
assert score #ci.removal.mounted sgp.dummy matches 1
