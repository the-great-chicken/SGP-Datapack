#> sgp.ci:diorama_cleanup/cleanup
# Disconnect the owner and remove every mannequin/label created by the removal fixture.

function sgp.ci:players/cleanup
kill @e[tag=sgp.ci.removal,type=text_display]
tp @e[tag=sgp.ci.removal,type=mannequin] ~ ~-1000 ~
tag @e[tag=sgp.ci.removal,type=mannequin] remove sgp.small_mannequin_95001
tag @e[tag=sgp.ci.removal,type=mannequin] remove sgp.giant_mannequin_95001
tag @e[tag=sgp.ci.removal,type=mannequin] remove sgp.small_mannequin_95002
kill @e[tag=sgp.ci.removal,type=mannequin]
