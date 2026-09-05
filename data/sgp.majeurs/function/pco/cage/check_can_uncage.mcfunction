#> sgp.majeurs:pco/cage/check_can_uncage
# `{team}`
#
# Keep the cloned release-sign trigger enabled only for nearby free teammates.

$execute unless entity @s[distance=..8,scores={sgp.en_cage=0}] \
    run scoreboard players reset @s sgp.liberer_$(team)s

$execute if entity @s[distance=..8,scores={sgp.en_cage=0}] \
    unless score @s sgp.liberer_$(team)s matches 1.. \
        run scoreboard players enable @s sgp.liberer_$(team)s

$execute if entity @s[distance=..8,scores={sgp.en_cage=0}] \
    unless score @s sgp.liberer_$(team)s matches 1.. \
        run scoreboard players set @s sgp.liberer_$(team)s 1
