#> sgp.mineurs:confinement/running

# Passage à la seconde supérieure
scoreboard players add #confines_secondes sgp.timer 1
experience add @a[tag=sgp.in_game] -1 levels

# Démarrage de l'event après x secondes
execute if score #confines_secondes sgp.timer matches 16 run tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"CONFINEMENT ! ", bold:true}, {text:"L'événement a commencé et se terminera dans 2 minutes 30s !", color:white}]
execute if score #confines_secondes sgp.timer matches 16 run stopsound @a[tag=sgp.in_game] master minecraft:music_disc.strad

# Fait des dégâts quand les joueurs ne sont pas en Intérieur
execute if score #confines_secondes sgp.timer matches 16.. run function sgp.mineurs:confinement/damage

# Récursivité sur 1 seconde
execute unless score #confines_secondes sgp.timer matches 181.. run schedule function sgp.mineurs:confinement/running 1s

# Fin de l'event
execute if score #confines_secondes sgp.timer matches 181.. run tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"CONFINEMENT ! ", color:gray, bold:true},{text:"L'événement est terminé ! Vous pouvez ressortir en toute securité !", color:white}]
execute if score #confines_secondes sgp.timer matches 181.. run experience set @a[tag=sgp.in_game] 0 levels
execute if score #confines_secondes sgp.timer matches 181.. run scoreboard players set #confines_secondes sgp.timer 0