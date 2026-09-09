#> sgp.ci:diorama_cleanup/fixture
fill ~ ~1 ~ ~10 ~5 ~8 air
fill ~ ~ ~ ~10 ~ ~8 stone
gamemode survival @s
tp @s ~1.5 ~1 ~1.5
scoreboard players set @s bs.id 95011
tag @s add sgp.has_small_mannequin_95001
tag @s add sgp.has_giant_mannequin_95001
tag @s add sgp.has_small_mannequin_95002
function sgp.ci:diorama_cleanup/pair {group:small,type:small,map:95001,owner:95011,x:"~2.5"}
function sgp.ci:diorama_cleanup/pair {group:giant,type:giant,map:95001,owner:95011,x:"~4.5"}
function sgp.ci:diorama_cleanup/pair {group:other_owner,type:small,map:95001,owner:95012,x:"~6.5"}
function sgp.ci:diorama_cleanup/pair {group:other_map,type:small,map:95002,owner:95011,x:"~8.5"}
