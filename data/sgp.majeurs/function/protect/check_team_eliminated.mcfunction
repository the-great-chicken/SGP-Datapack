#> sgp.majeurs:protect/check_team_eliminated
# `{team, name, name_ennemies, color_ennemies}`

$execute if entity @a[team=sgp.$(team)] run return 0
$tellraw @a[tag=sgp.in_game] [{text:"L'Equipe ",color:gold,bold:true},{text:"$(name_ennemies) ",color:"$(color_ennemies)"},"a gagné ! ",{text:"Tous les $(name)s sont éliminés. ",bold:false}]
$title @a[tag=sgp.in_game] title ["",{text:"$(name_ennemies)s ",color:"$(color_ennemies)",bold:true},{text:"gagnent",color:gold}]
function sgp.majeurs:protect/_stop
