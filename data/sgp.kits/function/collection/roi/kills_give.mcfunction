#> sgp.kits:collection/roi/kills_give
# 
# Gives the reward for each kill as a Roi: it specifically gives a small
# regeneration effect

give @s golden_apple[ \
    custom_name={text:"Pomme d'or", color:yellow, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 6", color:gray, italic:false}, \
            {text:"❤", color:red}, \
            {text:" + 2"}, \
            {text:"❤", color:yellow} \
            ] \
        ] \
    ]

give @s arrow 2
effect give @s regeneration 1 3

function sgp.misc:actionbar/reward { \
    id:"sgp:reward_1", \
    slot:1, \
    text:[ \
        {text:"+ 2 ➶ Flèches, ", color:gray, bold:true}, \
        {text:"1 ❤ Pomme d'or ", color:yellow}, \
        {text:"et 1,5 ❤ !", color:light_purple} \
        ] \
    }
scoreboard players set @s sgp.kills_give_1 0