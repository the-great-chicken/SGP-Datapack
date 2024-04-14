$execute at @s run summon firework_rocket ~ ~ ~ {LifeTime:20,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;$(fw_color)]}],Flight:1}}}}
$title @s title {"text":"Kit $(kit) Trouvé !","color":"$(kit_color)","bold":true}
$tellraw @a [{"selector":"@s","bold":true,"color":"white"},{"text":" a trouvé le kit ","bold":false,"color":"aqua"},{"text":"$(kit)","bold":true,"color":"$(kit_color)"}]
$scoreboard players set @s $(kit)_found 3