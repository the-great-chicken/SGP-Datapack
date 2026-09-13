#> sgp.ci:diorama_cleanup/retire
# Retire every mannequin from this fixture while its test chunk is still loaded.
# Mannequins keep a short DYING state after /kill; letting the test await removal
# prevents PackTest from unloading/serializing that transient non-persistent pose.

kill @e[tag=sgp.ci.removal,type=text_display]
tp @e[tag=sgp.ci.removal,type=mannequin] ~ ~-1000 ~
tag @e[tag=sgp.ci.removal,type=mannequin] remove sgp.small_mannequin_95001
tag @e[tag=sgp.ci.removal,type=mannequin] remove sgp.giant_mannequin_95001
tag @e[tag=sgp.ci.removal,type=mannequin] remove sgp.small_mannequin_95002
kill @e[tag=sgp.ci.removal,type=mannequin]
