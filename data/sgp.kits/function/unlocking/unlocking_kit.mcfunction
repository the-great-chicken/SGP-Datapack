#> sgp.kits:unlocking/unlocking_kit
# `{kit, kit_color, fw_color: int}`
# 
# Congratulates the player for finding the kit

$execute at @s run summon firework_rocket ~ ~ ~ {LifeTime:20,FireworksItem:{id:"firework_rocket",count:1,components:{fireworks:{explosions:[{shape:"large_ball",has_twinkle:true,has_trail:true,colors:[I;$(fw_color)]}],flight_duration:1}}}}
$title @s title {"text":"$(kit) Trouvé !", "color":"$(kit_color)", "bold":true}
$tellraw @a ["", {"selector":"@s", "bold":true, "color":"white"}, {"text":" a trouvé le kit ", "color":"aqua"}, {"text":"$(kit)", "bold":true, "color":"$(kit_color)"}]
$scoreboard players set @s sgp.$(kit)_found 3