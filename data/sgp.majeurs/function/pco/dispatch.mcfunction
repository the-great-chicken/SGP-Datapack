#> sgp.majeurs:pco/dispatch
#
# Dispatch the players evenly between the teams.
# Call itself until no one is left without a team.

team join sgp.Poule @r[tag=sgp.in_game,team=!sgp.Poule,team=!sgp.Oie,team=!sgp.Canard]
team join sgp.Oie @r[tag=sgp.in_game,team=!sgp.Poule,team=!sgp.Oie,team=!sgp.Canard]
team join sgp.Canard @r[tag=sgp.in_game,team=!sgp.Poule,team=!sgp.Oie,team=!sgp.Canard]

execute if entity @a[tag=sgp.in_game,team=!sgp.Poule,team=!sgp.Oie,team=!sgp.Canard] \
    run function sgp.majeurs:pco/dispatch