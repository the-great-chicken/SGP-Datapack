#> sgp.mineurs:magic/give_effect
# `{effect: string, amplifier: int, article: string, text: string, color: string}`
#
# Gives the effect to the player

$effect give @s minecraft:$(effect) 120 $(amplifier)
$tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"MAGIC! ", color:dark_purple, bold:true}, {text:"Pour mettre le bazar sur l'arène, le Canarchimage a lancé un sort $(article)", color:light_purple},{text:"$(text)", color:"$(color)", bold:true}, {text:" !", color:light_purple}]