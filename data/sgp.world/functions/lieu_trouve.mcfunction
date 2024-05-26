$execute as @a[x=$(x), y=$(y), z=$(z), dx=$(dx), dy=$(dy), dz=$(dz), scores={sgp.lieu_$(lieu)=0}] run title @s subtitle "Nouveau lieu trouvé !"
$execute as @a[x=$(x), y=$(y), z=$(z), dx=$(dx), dy=$(dy), dz=$(dz), scores={sgp.lieu_$(lieu)=0}] run title @s title {"text":"$(lieu_propre)", "color":"$(couleur)"}
$execute as @a[x=$(x), y=$(y), z=$(z), dx=$(dx), dy=$(dy), dz=$(dz), scores={sgp.lieu_$(lieu)=0}] at @s run playsound minecraft:ui.cartography_table.take_result ambient @s
$execute as @a[x=$(x), y=$(y), z=$(z), dx=$(dx), dy=$(dy), dz=$(dz), scores={sgp.lieu_$(lieu)=0}] run scoreboard players set @s sgp.lieu_$(lieu) 1
$execute as @a[x=$(x), y=$(y), z=$(z), dx=$(dx), dy=$(dy), dz=$(dz), scores={sgp.lieu_$(lieu)=1}] run data modify storage smithed.actionbar:input message set value {json:'{"text":"$(lieu_propre)", "color":"$(couleur)", "bold":true}',priority:'notification'}
$execute as @a[x=$(x), y=$(y), z=$(z), dx=$(dx), dy=$(dy), dz=$(dz), scores={sgp.lieu_$(lieu)=1}] run function #smithed.actionbar:message
$execute as @a[x=$(x), y=$(y), z=$(z), dx=$(dx), dy=$(dy), dz=$(dz), scores={sgp.lieu_$(lieu)=1}] run scoreboard players set @s sgp.lieu_$(lieu) 2
$execute as @a[scores={sgp.lieu_$(lieu)=2}] unless entity @s[x=$(x), y=$(y), z=$(z), dx=$(dx), dy=$(dy), dz=$(dz)] run scoreboard players set @s sgp.lieu_$(lieu) 1