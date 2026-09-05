#> sgp.mineurs:reflexes/stop
#
# Cancel the challenge without punishing players and discard its responses.

schedule clear sgp.mineurs:reflexes/running
tag @a[tag=sgp.reflexes_check] remove sgp.reflexes_check
scoreboard players reset @a sgp.reflexes_joueur
