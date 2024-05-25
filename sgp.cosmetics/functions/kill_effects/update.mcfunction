$execute if score @s sgp.$(effect)_kill_unlocked matches 1 run function sgp.cosmetics:kill_effects/reset
$execute if score @s sgp.$(effect)_kill_unlocked matches 1 run tag @s add $(effect)_kill
$execute if score @s sgp.$(effect)_kill_unlocked matches 1 run tellraw @s ["Ton Kill Effect est maintenant ",{"text":"$(effet)", "color":"$(couleur)", "bold":true}]
$scoreboard players enable @s sgp.veut_kill_$(effect)
$scoreboard players set @s sgp.veut_kill_$(effect) 0
$execute as @s unless score @s sgp.$(effect)_kill_unlocked matches 1 run tellraw @s [{"text":"Tu n'as pas encore débloqué le Kill Effect ", "color":"red"},{"text":"$(effet)", "bold":true, "color":"$(couleur)"}," !\n",{"text":"Tu trouveras peut-être une façon de le débloquer durant la soirée !","color":"aqua"}]