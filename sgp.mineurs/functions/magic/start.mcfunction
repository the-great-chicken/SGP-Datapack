title @a title {"text":"MAGIC!", "color":"dark_purple", "bold":true}
execute store result score #random_magic_roll sgp.dummy run random value 1..20
execute if score #random_magic_roll sgp.dummy matches 1 run effect give @a minecraft:absorption infinite 4
execute if score #random_magic_roll sgp.dummy matches 1 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Absorption V", "color":"yellow", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 2 run effect give @a minecraft:fire_resistance infinite 2
execute if score #random_magic_roll sgp.dummy matches 2 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Résistance au Feu", "color":"gold", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 3 run effect give @a minecraft:wither infinite
execute if score #random_magic_roll sgp.dummy matches 3 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Wither", "color":"#342825", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 4 run effect give @a minecraft:health_boost infinite 1
execute if score #random_magic_roll sgp.dummy matches 4 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Bonus de Vie II", "color":"red", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 5 run effect give @a minecraft:hunger infinite 1
execute if score #random_magic_roll sgp.dummy matches 5 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Faim II", "color":"#547554", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 6 run effect give @a minecraft:instant_damage 1 1
execute if score #random_magic_roll sgp.dummy matches 6 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Dégâts Instantanés II", "color":"#44080b", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 7 run effect give @a minecraft:instant_health 1 2
execute if score #random_magic_roll sgp.dummy matches 7 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Soin Instantané III", "color":"#f62120", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 8 run effect give @a minecraft:invisibility infinite
execute if score #random_magic_roll sgp.dummy matches 8 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Invisibilité", "color":"#f3f3f3", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 9 run effect give @a minecraft:jump_boost infinite 1
execute if score #random_magic_roll sgp.dummy matches 9 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Sauts Améliorés II", "color":"green", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 10 run effect give @a minecraft:levitation infinite
execute if score #random_magic_roll sgp.dummy matches 10 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Lévitation", "color":"#cdffff", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 11 run effect give @a minecraft:nausea infinite
execute if score #random_magic_roll sgp.dummy matches 11 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Nausée", "color":"#364B15", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 12 run effect give @a minecraft:darkness infinite
execute if score #random_magic_roll sgp.dummy matches 12 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Obscurité", "color":"#090505", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 13 run effect give @a minecraft:poison infinite 1
execute if score #random_magic_roll sgp.dummy matches 13 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Poison II", "color":"#85A162", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 14 run effect give @a minecraft:regeneration infinite
execute if score #random_magic_roll sgp.dummy matches 14 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Régénération", "color":"#FF42C6", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 15 run effect give @a minecraft:resistance infinite
execute if score #random_magic_roll sgp.dummy matches 15 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Résistance", "color":"gray", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 16 run effect give @a minecraft:slow_falling infinite
execute if score #random_magic_roll sgp.dummy matches 16 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Chute Lente", "color":"#F5E6CD", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 17 run effect give @a minecraft:slowness infinite 1
execute if score #random_magic_roll sgp.dummy matches 17 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Lenteur II", "color":"#89ADDD", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 18 run effect give @a minecraft:speed infinite
execute if score #random_magic_roll sgp.dummy matches 18 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Vitesse", "color":"#32E8FC", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 19 run effect give @a minecraft:strength infinite
execute if score #random_magic_roll sgp.dummy matches 19 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Force", "color":"dark_red", "bold":true}," !"]
execute if score #random_magic_roll sgp.dummy matches 20 run effect give @a minecraft:weakness infinite
execute if score #random_magic_roll sgp.dummy matches 20 run tellraw @a [{"text":"", "color":"light_purple"},{"text":"MAGIC! ", "color":"dark_purple", "bold":true},"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort d'",{"text":"Faiblesse", "color":"#434945", "bold":true}," !"]