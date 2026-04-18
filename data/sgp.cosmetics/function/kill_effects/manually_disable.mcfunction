#> sgp.cosmetics:kill_effects/manually_disable

function sgp.cosmetics:kill_effects/disable
tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"Tu as ", color:aqua}, {text:"désactivé", color:red, bold:true}, {text:" ton Kill Effect", color:aqua}]