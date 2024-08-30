#> sgp.majeurs:pco/dispatch
#
# Dispatch the players evenly between the teams.
# Call itself until no one is left without a team.

team join sgp.Poule @r[tag=sgp.in_game,team=]
team join sgp.Oie @r[tag=sgp.in_game,team=]
team join sgp.Canard @r[tag=sgp.in_game,team=]

execute if entity @a[tag=sgp.in_game,team=!] \
    run function sgp.majeurs:pco/dispatch