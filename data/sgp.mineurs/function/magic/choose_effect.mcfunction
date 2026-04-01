#> sgp:mineurs/choose_effect
# 
# Checks the global #random_magic_roll score and passes the corresponding
# potion effect parameters into the give_effect macro function.

execute if score #random_magic_roll sgp.dummy matches 1 \
    run data modify storage sgp:data mineurs.magic set value {effect:"absorption", amplifier:4, article:"d'", text:"Absorption V", color:"yellow"}

execute if score #random_magic_roll sgp.dummy matches 2 \
    run data modify storage sgp:data mineurs.magic set value {effect:fire_resistance, amplifier:2, article:"de ", text:"Résistance au Feu", color:gold}

execute if score #random_magic_roll sgp.dummy matches 3 \
    run data modify storage sgp:data mineurs.magic set value {effect:wither, amplifier:0, article:"de ", text:"Wither", color:"#342825"}

execute if score #random_magic_roll sgp.dummy matches 4 \
    run data modify storage sgp:data mineurs.magic set value {effect:health_boost, amplifier:1, article:"de ", text:"Bonus de  Vie II", color:red}

execute if score #random_magic_roll sgp.dummy matches 5 \
    run data modify storage sgp:data mineurs.magic set value {effect:hunger, amplifier:1, article:"de ", text:"Faim II", color:"#547554"}

execute if score #random_magic_roll sgp.dummy matches 6 \
    run data modify storage sgp:data mineurs.magic set value {effect:invisibility, amplifier:0, article:"d'", text:"Invisibilité", color:"#f3f3f3"}

execute if score #random_magic_roll sgp.dummy matches 7 \
    run data modify storage sgp:data mineurs.magic set value {effect:jump_boost, amplifier:1, article:"de ", text:"Sauts Améliorés II", color:green}

execute if score #random_magic_roll sgp.dummy matches 8 \
    run data modify storage sgp:data mineurs.magic set value {effect:levitation, amplifier:0, article:"de ", text:"Lévitation", color:"#cdffff"}

execute if score #random_magic_roll sgp.dummy matches 9 \
    run data modify storage sgp:data mineurs.magic set value {effect:nausea, amplifier:0, article:"de ", text:"Nausée", color:"#364B15"}

execute if score #random_magic_roll sgp.dummy matches 10 \
    run data modify storage sgp:data mineurs.magic set value {effect:darkness, amplifier:0, article:"d'", text:"Obscurité", color:"#090505"}

execute if score #random_magic_roll sgp.dummy matches 11 \
    run data modify storage sgp:data mineurs.magic set value {effect:poison, amplifier:1, article:"de ", text:"Poison II", color:"#85A162"}

execute if score #random_magic_roll sgp.dummy matches 12 \
    run data modify storage sgp:data mineurs.magic set value {effect:regeneration, amplifier:0, article:"de ", text:"Régénération", color:"#FF42C6"}

execute if score #random_magic_roll sgp.dummy matches 13 \
    run data modify storage sgp:data mineurs.magic set value {effect:resistance, amplifier:0, article:"de ", text:"Résistance", color:gray}

execute if score #random_magic_roll sgp.dummy matches 14 \
    run data modify storage sgp:data mineurs.magic set value {effect:slow_falling, amplifier:0, article:"de ", text:"Chute Lente", color:"#F5E6CD"}

execute if score #random_magic_roll sgp.dummy matches 15 \
    run data modify storage sgp:data mineurs.magic set value {effect:slowness, amplifier:1, article:"de ", text:"Lenteur II", color:"#89ADDD"}

execute if score #random_magic_roll sgp.dummy matches 16 \
    run data modify storage sgp:data mineurs.magic set value {effect:speed, amplifier:0, article:"de ", text:"Vitesse", color:"#32E8FC"}

execute if score #random_magic_roll sgp.dummy matches 17 \
    run data modify storage sgp:data mineurs.magic set value {effect:strength, amplifier:0, article:"de ", text:"Force", color:dark_red}

execute if score #random_magic_roll sgp.dummy matches 18 \
    run data modify storage sgp:data mineurs.magic set value {effect:weakness, amplifier:0, article:"de ", text:"Faiblesse", color:"#434945"}

execute as @a[tag=sgp.in_game,tag=!sgp.peaceful] run function sgp.mineurs:magic/give_effect with storage sgp:data mineurs.magic