#> sgp.mineurs:confinement/running

# Passage à la seconde supérieure
scoreboard players add #confines_secondes sgp.timer 1
experience add @a[tag=sgp.in_game] -1 levels

# Démarrage de l'event après x secondes
execute if score #confines_secondes sgp.timer matches 15 run tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"CONFINEMENT ! ", bold:true}, {text:"L'événement a commencé et se terminera dans 2 minutes 30s !", color:white}]
execute if score #confines_secondes sgp.timer matches 15 run stopsound @a[tag=sgp.in_game] master minecraft:music_disc.strad
execute if score #confines_secondes sgp.timer matches 15 run gamerule advance_time false

# Fait des dégâts quand les joueurs ne sont pas en Intérieur
execute if score #confines_secondes sgp.timer matches 15.. run function sgp.mineurs:confinement/damage

# Advance time for visual effect via timeline
execute if score #confines_secondes sgp.timer matches 15.. run time add 1t

# Récursivité sur 1 seconde
execute unless score #confines_secondes sgp.timer matches 165.. run schedule function sgp.mineurs:confinement/running 1s

# Fin de l'event
execute if score #confines_secondes sgp.timer matches 165.. run function sgp.mineurs:confinement/stop