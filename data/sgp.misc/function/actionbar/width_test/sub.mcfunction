#> sgp.misc:actionbar/width_test/sub
# Appends a new copy of the actionbar component to test

execute if score #test_width_count sgp.dummy matches 0 run data modify storage dah:actbar new set from storage sgp:macro width_test[0]
execute if score #test_width_count sgp.dummy matches 1 run data modify storage dah:actbar new set from storage sgp:macro width_test[1]
execute if score #test_width_count sgp.dummy matches 2 run data modify storage dah:actbar new set from storage sgp:macro width_test[2]
execute if score #test_width_count sgp.dummy matches 3 run data modify storage dah:actbar new set from storage sgp:macro width_test[3]

execute as @a[tag=sgp.is_testing_width] run function dah.actbar_mixer:new/update_id

scoreboard players add #test_width_count sgp.dummy 1
scoreboard players operation #test_width sgp.dummy += #test_width_init sgp.dummy