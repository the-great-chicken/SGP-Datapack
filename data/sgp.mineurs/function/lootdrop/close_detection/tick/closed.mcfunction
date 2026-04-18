#> sgp.mineurs:lootdrop/close_detection/tick/closed
#
# Things that happen when the chest is closed (remove the chest, particles,...)

scoreboard players enable @a[tag=sgp.container_open] sgp.share_item
tellraw @a[tag=sgp.container_open] [ \
    {storage:"sgp.text", nbt:"prefix", interpret:true}, \
    {translate: "Bravo d'avoir trouvé le %s ! Tu as obtenu un %s intéressant ?\n", "color": "yellow", \
        with: [{"text": "coffre", "color": "green"}, {"text": "item", "color": aqua}]}, \
    {storage:"sgp.text", nbt:"prefix", interpret:true}, \
    {text:"Si oui, ", "color": "yellow"}, \
    {text: "[Clique ici pour le montrer à tout le monde]", underlined:true, "color": "yellow", \
        "hover_event": {"action": "show_text", "value": "Cela affichera dans le chat l'item que tu tiens actuellement"}, \
        click_event: {action: "run_command", command: "/trigger sgp.share_item"}}]

tag @a[tag=sgp.container_open] remove sgp.container_open

setblock ~ ~ ~ air replace

playsound minecraft:block.beacon.power_select master @a[tag=sgp.in_game] ~ ~ ~ 1 0.5

tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"Le coffre a été trouvé !", color:gold}]

particle minecraft:large_smoke ~ ~.5 ~ 0.2 0.2 0.2 0.02 1000

tag @s remove sgp.opened_chest