#> sgp.mineurs:confinement/running

scoreboard players add #confines_secondes sgp.timer 1

# Démarrage de l'event après x secondes
execute if score #confines_secondes sgp.timer matches 15 run tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"CONFINEMENT ! ", bold:true}, {text:"L'événement a commencé et se terminera dans 2 minutes 15s !", color:white}]
execute if score #confines_secondes sgp.timer matches 15 run schedule clear sgp.mineurs:confinement/add_time_clock

# Fait des dégâts quand les joueurs ne sont pas en Intérieur
execute if score #confines_secondes sgp.timer matches 15.. run function sgp.mineurs:confinement/damage
execute if score #confines_secondes sgp.timer matches 15.. run time of sgp.mineurs:confinement_clock add 1t

execute unless score #confines_secondes sgp.timer matches 150.. run schedule function sgp.mineurs:confinement/running 1s

execute if score #confines_secondes sgp.timer matches 150.. run function sgp.mineurs:confinement/end