#> sgp.mineurs:magic/start
# 
# Starts the magic minor event. Rolls a random effect (1-18) and runs the
# selection function for all active, non-peaceful players.

title @a[tag=sgp.in_game,tag=!sgp.peaceful] title {text:"MAGIC!", color:dark_purple, bold:true}
execute store result score #random_magic_roll sgp.dummy run random value 1..18
function sgp.mineurs:magic/choose_effect