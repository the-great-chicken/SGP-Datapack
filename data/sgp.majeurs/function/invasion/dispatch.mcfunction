#> sgp.majeurs:invasion/dispatch
# 
# Dispatch the players in 2 teams : Attackers and Defenders,
# with 2 times more Defenders

team join sgp.Attaquant @r[tag=sgp.in_game,team=!sgp.Attaquant,team=!sgp.Defenseur]
team join sgp.Defenseur @r[tag=sgp.in_game,team=!sgp.Attaquant,team=!sgp.Defenseur]
team join sgp.Defenseur @r[tag=sgp.in_game,team=!sgp.Attaquant,team=!sgp.Defenseur]
execute if entity @a[tag=sgp.in_game,team=!sgp.Attaquant,team=!sgp.Defenseur] run function sgp.majeurs:invasion/dispatch