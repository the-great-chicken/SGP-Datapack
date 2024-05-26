execute if score #bossbar_color sgp.dummy matches 0 run bossbar set sgp:lgp color blue
execute if score #bossbar_color sgp.dummy matches 1 run bossbar set sgp:lgp color purple
execute if score #bossbar_color sgp.dummy matches 2 run bossbar set sgp:lgp color pink 
execute if score #bossbar_color sgp.dummy matches 3 run bossbar set sgp:lgp color white
execute if score #bossbar_color sgp.dummy matches 4 run bossbar set sgp:lgp color red
execute if score #bossbar_color sgp.dummy matches 5 run bossbar set sgp:lgp color yellow

scoreboard players add #bossbar_color sgp.dummy 1
execute if score #bossbar_color sgp.dummy matches 7 run scoreboard players set #bossbar_color sgp.dummy 0
schedule function sgp.misc:bossbar/cycle_color 8