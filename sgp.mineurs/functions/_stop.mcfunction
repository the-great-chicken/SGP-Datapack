tellraw @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] [{"text":"Désactivation des Événements Mineurs", "color":"red", "bold":true}]
scoreboard players set #events_mineurs_actifs sgp.dummy 0
execute unless score #confines_secondes sgp.dummy matches 0 unless score #confines_tick sgp.dummy matches 0 run scoreboard players set #confines_minutes sgp.timer 5
scoreboard players set #confines_secondes sgp.timer 0
execute at @e[type=marker,name="Lootdrop"] run setblock ~ ~ ~ air