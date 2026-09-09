#> sgp.ci:diorama_cleanup/expect_removed
# {group}
# Dying mannequins may persist briefly, but must leave the visible model immediately.
$assert not entity @e[tag=sgp.ci.removal_$(group),distance=..16,type=mannequin]
$assert not entity @e[tag=sgp.ci.removal_$(group),type=text_display]
