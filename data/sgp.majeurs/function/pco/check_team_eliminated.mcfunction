#> sgp.majeurs:pco/check_team_eliminated
# `{team, name_ennemies, color_ennemies, victory}`

$execute if entity @a[team=sgp.$(team)] run return 0
$tellraw @a[tag=sgp.in_game] [{storage:"sgp:text",nbt:"prefix",interpret:true},{text:"Les $(name_ennemies) gagnent : l'équipe $(team) n'a plus de participant.",color:"$(color_ennemies)"}]
$title @a[tag=sgp.in_game] title {text:"$(name_ennemies) $(victory)",color:"$(color_ennemies)",bold:true}
function sgp.majeurs:pco/_stop
