title @a[tag=sgp.in_game] title {"text":"MAGIC!", "color":"dark_purple", "bold":true}
execute store result score #random_magic_roll sgp.dummy run random value 1..18
execute as @a[tag=sgp.in_game] run function sgp.mineurs:magic/choose_effect