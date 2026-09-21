#> sgp.bench:scenarios/events/minor_event/swap/setup
# `{first, last, players, event}`
# The twelve kit-selection interactions a map provides (sgp.kits:random_kit picks one at random
# and calls check_and_give with its data.args), every kit unlocked for the actors, then the event.
kill @e[tag=sgp.bench.choose_kit,type=interaction]
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"pigeon",kit_name:"Pigeon",kit_color:"dark_gray",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"combattant",kit_name:"Combattant",kit_color:"red",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"archer",kit_name:"Archer",kit_color:"green",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"vindicateur",kit_name:"Vindicateur",kit_color:"dark_green",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"pyromane",kit_name:"Pyromane",kit_color:"gold",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"tank",kit_name:"Tank",kit_color:"gray",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"roi",kit_name:"Roi",kit_color:"yellow",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"eclaireur",kit_name:"Eclaireur",kit_color:"aqua",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"alchimiste",kit_name:"Alchimiste",kit_color:"light_purple",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"enderman",kit_name:"Enderman",kit_color:"dark_purple",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"cancer",kit_name:"Cancer",kit_color:"dark_red",hint:"",hint_color:"white"}}}
summon interaction -30 60 -30 {Tags:["sgp.choose_kit","sgp.bench.choose_kit"],data:{args:{kit:"poseidon",kit_name:"Poseidon",kit_color:"dark_aqua",hint:"",hint_color:"white"}}}
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.pigeon_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.combattant_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.archer_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.vindicateur_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.pyromane_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.tank_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.roi_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.eclaireur_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.alchimiste_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.enderman_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cancer_found 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.poseidon_found 1
function sgp.mineurs:swap/start
