#> sgp.cosmetics:reward/give
# `{objective: name of reward scoreboard, reward_name: string, reward_type: Kill Effect|Cloak|..., reward_color, trial_name: string}`

execute unless entity @s[tag=sgp.peaceful] run return \
    run tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, {translate:"Il faut avoir le kit %s pour pouvoir récupérer cette récompense...", color:red, with:[{text:"Paisible", color:green}]}]

$execute if score @s $(objective) matches 1 run return \
    run tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"Tu as déjà récupéré cette récompense...", color:red}]

$tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, \
            {text:"Tu viens de débloquer $(reward_type) ", color:aqua}, {text:"$(reward_name)", bold:true, color: $(reward_color)}, {text:" !", color:aqua}]

tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, \
            {text:"Va dans la Salle des ", color:aqua}, {text:"Cosmétiques", color:light_purple, bold:true}, {text:" pour l'activer !", color:aqua}]

$summon firework_rocket ~ ~ ~ {LifeTime:20,FireworksItem:{id:"firework_rocket",count:1,components:{fireworks:{explosions:[{shape:"large_ball",has_twinkle:true,has_trail:true,colors:[$(reward_color)]}],flight_duration:1}}}}

$scoreboard players set @s $(objective) 1

$scoreboard players add #nbr_players $(objective) 1

$tellraw @a [{storage:"sgp.text", nbt:"prefix", interpret:true}, \
            {translate:"%s est la %se personne à avoir fini le %s ! Bravo à eux !", color:aqua, \
                with:[{selector:"@s", color:yellow}, {score:{name:"#nbr_players",objective:"$(objective)"}}, {text:"$(trial_name)", color:light_purple, bold:true}]}]