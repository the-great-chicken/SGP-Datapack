execute in minecraft:minisjeux_crea run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Lancement de l'event Proteger le Roi...", "color":"gold", "bold":true}]
execute in minecraft:minisjeux_crea as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run function world:on_death
execute in minecraft:minisjeux_crea run function majeurs:protect_dispatch
fill 2537 253 2203 2537 251 2193 minecraft:barrier replace air
function mineurs:stop
scoreboard players set #mort_roi_rouge_annoncee dummy 0
scoreboard players set #mort_roi_bleu_annoncee dummy 0
execute at @e[type=marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2] run scoreboard players enable @s devenir_roi_rouge
execute at @e[type=marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2] run title @s title [{"text":"Équipe Rouge", "color":"dark_red"}]
execute at @e[type=marker,name="devenir_roi_bleu",limit=1] as @a[distance=..2] run scoreboard players enable @s devenir_roi_bleu
execute at @e[type=marker,name="devenir_roi_bleu",limit=1] as @a[distance=..2] run title @s title [{"text":"Équipe Bleu", "color":"dark_blue"}]
setblock 2480 230 2166 minecraft:prismarine_brick_slab[type=bottom]
statuswarp pvp disabled
execute at @e[type=marker,name="devenir_roi_bleu",limit=1] as @a[distance=..2] run move @s #Bleus
execute at @e[type=marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2] run move @s #Rouges
sudo Bafy78 useglow toggle
function lore:disable_npcs