#> sgp.mineurs:bounty/eliminated
#
# End the event as soon as its last wanted player has died.

tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"BOUNTY! ", color:yellow, bold:true}, {text:"Toutes les personnes recherchées ont été éliminées !", color:yellow}]
function sgp.mineurs:bounty/stop
