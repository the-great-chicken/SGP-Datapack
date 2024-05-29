#> sgp.majeurs:invasion/dispatch
# 
# Dispatch the players in 2 teams : Attackers and Defenders,
# with 2 times more Defenders

team join sgp.Attaquant @r[tag=in_game,team=!Attaquant,team=!sgp.Defenseur]
team join sgp.Defenseur @r[tag=in_game,team=!Attaquant,team=!sgp.Defenseur]
team join sgp.Defenseur @r[tag=in_game,team=!Attaquant,team=!sgp.Defenseur]
execute if entity @a[tag=in_game,team=!Attaquant,team=!sgp.Defenseur] run function sgp.majeurs:invasion/dispatch