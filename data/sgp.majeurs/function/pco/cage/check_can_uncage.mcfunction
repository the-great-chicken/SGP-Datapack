#> sgp.majeurs:pco/cage/check_can_uncage
# `{team}`
#
# Check if someone is close enough to an uncage sign
# Enable the trigger for him if yes, disable it if he walks away

$execute as @s[distance=..8,scores={sgp.liberer_$(team)s=0}] \
    unless entity @s[scores={sgp.en_cage=1}] \
        run scoreboard players enable @s sgp.liberer_$(team)s

$execute as @s[distance=..8,scores={sgp.liberer_$(team)s=0}] \
    unless entity @s[scores={sgp.en_cage=1}] \
        run scoreboard players set @s sgp.liberer_$(team)s 1
        
$execute as @s[distance=8..,scores={sgp.liberer_$(team)s=1}] \
    run trigger sgp.liberer_$(team)s set 0