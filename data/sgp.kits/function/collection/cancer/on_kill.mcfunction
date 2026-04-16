#> sgp.kits:collection/cancer/on_kill
# 
# Gives the Cancer kill rewards

execute as @a[tag=sgp.cancer,scores={sgp.kills_give_1=1..}] run function sgp.kits:kills_give/basic { \
    nb:1, \
    give:'tipped_arrow[ \
        custom_name={text:"Flèche de Lévitation", color:dark_red, italic:false, bold:true}, \
        lore=[ \
            {text:"⟰ Lévitation IV (0:13)", color:"#F2F3F4", italic:false} \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:"levitation", amplifier:3, duration:256} \
                ] \
            }, \
        potion_duration_scale=1.0, \
        tooltip_display={hidden_components:["potion_contents"]}, \
        item_model="sgp.kits:cancer/levitation" \
        ]', \
    give_2:'tipped_arrow[ \
        custom_name={text:"Flèche de Lenteur", color:dark_red, italic:false, bold:true}, \
        lore=[ \
            {text:"⬳ Lenteur IV (0:26)", color:"#555555", italic:false} \
            ], \
        potion_contents={ \
            custom_effects: [ \
                {id:"slowness", amplifier:3, duration:512} \
                ] \
            }, \
        potion_duration_scale=1.0, \
        tooltip_display={hidden_components:["potion_contents"]}, \
        item_model="sgp.kits:cancer/slowness" \
        ]', \
    actionbar:' \
        {text:"+ 1 ⟰ Flèche de Lévitation ", color:"#F2F3F4", bold:true}, \
        {text:"et 1 ⬳ Flèche de Lenteur !", color:"#555555"} \
        ' \
    }

execute as @a[tag=sgp.cancer,scores={sgp.kills_give_2=2..}] run give @s golden_apple[ \
    custom_name={text:"Pomme d'or", color:dark_red, italic:false, bold:true}, \
    lore=[ \
        [ \
            {text:"Régénère jusqu'à 6", color:gray, italic:false}, \
            {text:"❤", color:red}, \
            {text:" + 2"}, \
            {text:"❤", color:yellow} \
            ] \
        ], \
    item_model="sgp.kits:cancer/golden_apple" \
    ]

execute as @a[tag=sgp.cancer,scores={sgp.kills_give_2=2..}] run function sgp.kits:kills_give/basic { \
    nb:2, \
    give: 'splash_potion[ \
        custom_name={text:"Potion de Rapidité", color:dark_red, italic:false, bold:true}, \
        lore=[ \
            {text:"➠ Rapidité II (0:15)", color:aqua, italic:false} \
            ], \
        enchantments={"sgp.kits:perfect_accuracy":1}, \
        enchantment_glint_override=false, \
        potion_contents={ \
            custom_effects: [ \
                {duration:300, id:"speed", amplifier:1b} \
                ] \
            }, \
        tooltip_display={hidden_components:["potion_contents"]}, \
        item_model="sgp.kits:cancer/speed", \
        max_stack_size=64 \
        ]', \
    give_2: 'splash_potion[ \
        custom_name={text:"Potion de Saut", bold:true, color:dark_red, italic:false}, \
        lore=[ \
            {text:"⇪ Sauts améliorés III (0:30)", color:green, italic:false} \
            ], \
        enchantments={"sgp.kits:perfect_accuracy":1}, \
        enchantment_glint_override=false, \
        potion_contents={ \
            custom_effects: [ \
                {duration:600, id:"jump_boost", amplifier:2b} \
                ] \
            }, \
        tooltip_display={hidden_components:["potion_contents"]}, \
        item_model="sgp.kits:cancer/jump", \
        max_stack_size=64 \
        ]', \
    actionbar:' \
        {text:"+ 1 ❤ Pomme d\\\'or, ", color:yellow, bold:true}, \
        {text:"1 ⟰ Flèche de Lévitation, ", color:white}, \
        {text:"1 ⬳ Flèche de Lenteur, ", color:"#555555"}, \
        {text:"1 ➠ Potion de Rapidité ", color:aqua}, \
        {text:"et 1 ⇪ Potion de Saut !", color:green} ' \
    }
