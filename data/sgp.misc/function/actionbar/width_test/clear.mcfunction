#> sgp.misc:actionbar/width_test/clear

execute as @a[tag=sgp.is_testing_width] run function dah.actbar_mixer:remove/this {id:"sgp:test_1"}
execute as @a[tag=sgp.is_testing_width] run function dah.actbar_mixer:remove/this {id:"sgp:test_2"}
execute as @a[tag=sgp.is_testing_width] run function dah.actbar_mixer:remove/this {id:"sgp:test_3"}
execute as @a[tag=sgp.is_testing_width] run function dah.actbar_mixer:remove/this {id:"sgp:test_4"}

scoreboard players set #test_width sgp.dummy 0
scoreboard players set #test_width_count sgp.dummy 0

execute as @a[tag=sgp.is_testing_width] run tag @s remove sgp.is_testing_width