#> sgp.bench:actors/spawn
# Spawn only the requested prefix of Bench01..Bench40 and initialize production player state.

execute if score #players sgp.bench matches 1.. run dummy Bench01 spawn
execute if entity @a[name=Bench01] run tag Bench01 add sgp.bench.actor
execute if entity @a[name=Bench01] run scoreboard players set Bench01 sgp.bench 1
execute if entity @a[name=Bench01] run scoreboard players set Bench01 sgp.id 1
execute if entity @a[name=Bench01] run tp Bench01 -23.5 81 -13.5 0 0
execute if score #players sgp.bench matches 2.. run dummy Bench02 spawn
execute if entity @a[name=Bench02] run tag Bench02 add sgp.bench.actor
execute if entity @a[name=Bench02] run scoreboard players set Bench02 sgp.bench 2
execute if entity @a[name=Bench02] run scoreboard players set Bench02 sgp.id 2
execute if entity @a[name=Bench02] run tp Bench02 -16.5 81 -13.5 0 0
execute if score #players sgp.bench matches 3.. run dummy Bench03 spawn
execute if entity @a[name=Bench03] run tag Bench03 add sgp.bench.actor
execute if entity @a[name=Bench03] run scoreboard players set Bench03 sgp.bench 3
execute if entity @a[name=Bench03] run scoreboard players set Bench03 sgp.id 3
execute if entity @a[name=Bench03] run tp Bench03 -9.5 81 -13.5 0 0
execute if score #players sgp.bench matches 4.. run dummy Bench04 spawn
execute if entity @a[name=Bench04] run tag Bench04 add sgp.bench.actor
execute if entity @a[name=Bench04] run scoreboard players set Bench04 sgp.bench 4
execute if entity @a[name=Bench04] run scoreboard players set Bench04 sgp.id 4
execute if entity @a[name=Bench04] run tp Bench04 -2.5 81 -13.5 0 0
execute if score #players sgp.bench matches 5.. run dummy Bench05 spawn
execute if entity @a[name=Bench05] run tag Bench05 add sgp.bench.actor
execute if entity @a[name=Bench05] run scoreboard players set Bench05 sgp.bench 5
execute if entity @a[name=Bench05] run scoreboard players set Bench05 sgp.id 5
execute if entity @a[name=Bench05] run tp Bench05 4.5 81 -13.5 0 0
execute if score #players sgp.bench matches 6.. run dummy Bench06 spawn
execute if entity @a[name=Bench06] run tag Bench06 add sgp.bench.actor
execute if entity @a[name=Bench06] run scoreboard players set Bench06 sgp.bench 6
execute if entity @a[name=Bench06] run scoreboard players set Bench06 sgp.id 6
execute if entity @a[name=Bench06] run tp Bench06 11.5 81 -13.5 0 0
execute if score #players sgp.bench matches 7.. run dummy Bench07 spawn
execute if entity @a[name=Bench07] run tag Bench07 add sgp.bench.actor
execute if entity @a[name=Bench07] run scoreboard players set Bench07 sgp.bench 7
execute if entity @a[name=Bench07] run scoreboard players set Bench07 sgp.id 7
execute if entity @a[name=Bench07] run tp Bench07 18.5 81 -13.5 0 0
execute if score #players sgp.bench matches 8.. run dummy Bench08 spawn
execute if entity @a[name=Bench08] run tag Bench08 add sgp.bench.actor
execute if entity @a[name=Bench08] run scoreboard players set Bench08 sgp.bench 8
execute if entity @a[name=Bench08] run scoreboard players set Bench08 sgp.id 8
execute if entity @a[name=Bench08] run tp Bench08 25.5 81 -13.5 0 0
execute if score #players sgp.bench matches 9.. run dummy Bench09 spawn
execute if entity @a[name=Bench09] run tag Bench09 add sgp.bench.actor
execute if entity @a[name=Bench09] run scoreboard players set Bench09 sgp.bench 9
execute if entity @a[name=Bench09] run scoreboard players set Bench09 sgp.id 9
execute if entity @a[name=Bench09] run tp Bench09 -23.5 81 -6.5 0 0
execute if score #players sgp.bench matches 10.. run dummy Bench10 spawn
execute if entity @a[name=Bench10] run tag Bench10 add sgp.bench.actor
execute if entity @a[name=Bench10] run scoreboard players set Bench10 sgp.bench 10
execute if entity @a[name=Bench10] run scoreboard players set Bench10 sgp.id 10
execute if entity @a[name=Bench10] run tp Bench10 -16.5 81 -6.5 0 0
execute if score #players sgp.bench matches 11.. run dummy Bench11 spawn
execute if entity @a[name=Bench11] run tag Bench11 add sgp.bench.actor
execute if entity @a[name=Bench11] run scoreboard players set Bench11 sgp.bench 11
execute if entity @a[name=Bench11] run scoreboard players set Bench11 sgp.id 11
execute if entity @a[name=Bench11] run tp Bench11 -9.5 81 -6.5 0 0
execute if score #players sgp.bench matches 12.. run dummy Bench12 spawn
execute if entity @a[name=Bench12] run tag Bench12 add sgp.bench.actor
execute if entity @a[name=Bench12] run scoreboard players set Bench12 sgp.bench 12
execute if entity @a[name=Bench12] run scoreboard players set Bench12 sgp.id 12
execute if entity @a[name=Bench12] run tp Bench12 -2.5 81 -6.5 0 0
execute if score #players sgp.bench matches 13.. run dummy Bench13 spawn
execute if entity @a[name=Bench13] run tag Bench13 add sgp.bench.actor
execute if entity @a[name=Bench13] run scoreboard players set Bench13 sgp.bench 13
execute if entity @a[name=Bench13] run scoreboard players set Bench13 sgp.id 13
execute if entity @a[name=Bench13] run tp Bench13 4.5 81 -6.5 0 0
execute if score #players sgp.bench matches 14.. run dummy Bench14 spawn
execute if entity @a[name=Bench14] run tag Bench14 add sgp.bench.actor
execute if entity @a[name=Bench14] run scoreboard players set Bench14 sgp.bench 14
execute if entity @a[name=Bench14] run scoreboard players set Bench14 sgp.id 14
execute if entity @a[name=Bench14] run tp Bench14 11.5 81 -6.5 0 0
execute if score #players sgp.bench matches 15.. run dummy Bench15 spawn
execute if entity @a[name=Bench15] run tag Bench15 add sgp.bench.actor
execute if entity @a[name=Bench15] run scoreboard players set Bench15 sgp.bench 15
execute if entity @a[name=Bench15] run scoreboard players set Bench15 sgp.id 15
execute if entity @a[name=Bench15] run tp Bench15 18.5 81 -6.5 0 0
execute if score #players sgp.bench matches 16.. run dummy Bench16 spawn
execute if entity @a[name=Bench16] run tag Bench16 add sgp.bench.actor
execute if entity @a[name=Bench16] run scoreboard players set Bench16 sgp.bench 16
execute if entity @a[name=Bench16] run scoreboard players set Bench16 sgp.id 16
execute if entity @a[name=Bench16] run tp Bench16 25.5 81 -6.5 0 0
execute if score #players sgp.bench matches 17.. run dummy Bench17 spawn
execute if entity @a[name=Bench17] run tag Bench17 add sgp.bench.actor
execute if entity @a[name=Bench17] run scoreboard players set Bench17 sgp.bench 17
execute if entity @a[name=Bench17] run scoreboard players set Bench17 sgp.id 17
execute if entity @a[name=Bench17] run tp Bench17 -23.5 81 0.5 0 0
execute if score #players sgp.bench matches 18.. run dummy Bench18 spawn
execute if entity @a[name=Bench18] run tag Bench18 add sgp.bench.actor
execute if entity @a[name=Bench18] run scoreboard players set Bench18 sgp.bench 18
execute if entity @a[name=Bench18] run scoreboard players set Bench18 sgp.id 18
execute if entity @a[name=Bench18] run tp Bench18 -16.5 81 0.5 0 0
execute if score #players sgp.bench matches 19.. run dummy Bench19 spawn
execute if entity @a[name=Bench19] run tag Bench19 add sgp.bench.actor
execute if entity @a[name=Bench19] run scoreboard players set Bench19 sgp.bench 19
execute if entity @a[name=Bench19] run scoreboard players set Bench19 sgp.id 19
execute if entity @a[name=Bench19] run tp Bench19 -9.5 81 0.5 0 0
execute if score #players sgp.bench matches 20.. run dummy Bench20 spawn
execute if entity @a[name=Bench20] run tag Bench20 add sgp.bench.actor
execute if entity @a[name=Bench20] run scoreboard players set Bench20 sgp.bench 20
execute if entity @a[name=Bench20] run scoreboard players set Bench20 sgp.id 20
execute if entity @a[name=Bench20] run tp Bench20 -2.5 81 0.5 0 0
execute if score #players sgp.bench matches 21.. run dummy Bench21 spawn
execute if entity @a[name=Bench21] run tag Bench21 add sgp.bench.actor
execute if entity @a[name=Bench21] run scoreboard players set Bench21 sgp.bench 21
execute if entity @a[name=Bench21] run scoreboard players set Bench21 sgp.id 21
execute if entity @a[name=Bench21] run tp Bench21 4.5 81 0.5 0 0
execute if score #players sgp.bench matches 22.. run dummy Bench22 spawn
execute if entity @a[name=Bench22] run tag Bench22 add sgp.bench.actor
execute if entity @a[name=Bench22] run scoreboard players set Bench22 sgp.bench 22
execute if entity @a[name=Bench22] run scoreboard players set Bench22 sgp.id 22
execute if entity @a[name=Bench22] run tp Bench22 11.5 81 0.5 0 0
execute if score #players sgp.bench matches 23.. run dummy Bench23 spawn
execute if entity @a[name=Bench23] run tag Bench23 add sgp.bench.actor
execute if entity @a[name=Bench23] run scoreboard players set Bench23 sgp.bench 23
execute if entity @a[name=Bench23] run scoreboard players set Bench23 sgp.id 23
execute if entity @a[name=Bench23] run tp Bench23 18.5 81 0.5 0 0
execute if score #players sgp.bench matches 24.. run dummy Bench24 spawn
execute if entity @a[name=Bench24] run tag Bench24 add sgp.bench.actor
execute if entity @a[name=Bench24] run scoreboard players set Bench24 sgp.bench 24
execute if entity @a[name=Bench24] run scoreboard players set Bench24 sgp.id 24
execute if entity @a[name=Bench24] run tp Bench24 25.5 81 0.5 0 0
execute if score #players sgp.bench matches 25.. run dummy Bench25 spawn
execute if entity @a[name=Bench25] run tag Bench25 add sgp.bench.actor
execute if entity @a[name=Bench25] run scoreboard players set Bench25 sgp.bench 25
execute if entity @a[name=Bench25] run scoreboard players set Bench25 sgp.id 25
execute if entity @a[name=Bench25] run tp Bench25 -23.5 81 7.5 0 0
execute if score #players sgp.bench matches 26.. run dummy Bench26 spawn
execute if entity @a[name=Bench26] run tag Bench26 add sgp.bench.actor
execute if entity @a[name=Bench26] run scoreboard players set Bench26 sgp.bench 26
execute if entity @a[name=Bench26] run scoreboard players set Bench26 sgp.id 26
execute if entity @a[name=Bench26] run tp Bench26 -16.5 81 7.5 0 0
execute if score #players sgp.bench matches 27.. run dummy Bench27 spawn
execute if entity @a[name=Bench27] run tag Bench27 add sgp.bench.actor
execute if entity @a[name=Bench27] run scoreboard players set Bench27 sgp.bench 27
execute if entity @a[name=Bench27] run scoreboard players set Bench27 sgp.id 27
execute if entity @a[name=Bench27] run tp Bench27 -9.5 81 7.5 0 0
execute if score #players sgp.bench matches 28.. run dummy Bench28 spawn
execute if entity @a[name=Bench28] run tag Bench28 add sgp.bench.actor
execute if entity @a[name=Bench28] run scoreboard players set Bench28 sgp.bench 28
execute if entity @a[name=Bench28] run scoreboard players set Bench28 sgp.id 28
execute if entity @a[name=Bench28] run tp Bench28 -2.5 81 7.5 0 0
execute if score #players sgp.bench matches 29.. run dummy Bench29 spawn
execute if entity @a[name=Bench29] run tag Bench29 add sgp.bench.actor
execute if entity @a[name=Bench29] run scoreboard players set Bench29 sgp.bench 29
execute if entity @a[name=Bench29] run scoreboard players set Bench29 sgp.id 29
execute if entity @a[name=Bench29] run tp Bench29 4.5 81 7.5 0 0
execute if score #players sgp.bench matches 30.. run dummy Bench30 spawn
execute if entity @a[name=Bench30] run tag Bench30 add sgp.bench.actor
execute if entity @a[name=Bench30] run scoreboard players set Bench30 sgp.bench 30
execute if entity @a[name=Bench30] run scoreboard players set Bench30 sgp.id 30
execute if entity @a[name=Bench30] run tp Bench30 11.5 81 7.5 0 0
execute if score #players sgp.bench matches 31.. run dummy Bench31 spawn
execute if entity @a[name=Bench31] run tag Bench31 add sgp.bench.actor
execute if entity @a[name=Bench31] run scoreboard players set Bench31 sgp.bench 31
execute if entity @a[name=Bench31] run scoreboard players set Bench31 sgp.id 31
execute if entity @a[name=Bench31] run tp Bench31 18.5 81 7.5 0 0
execute if score #players sgp.bench matches 32.. run dummy Bench32 spawn
execute if entity @a[name=Bench32] run tag Bench32 add sgp.bench.actor
execute if entity @a[name=Bench32] run scoreboard players set Bench32 sgp.bench 32
execute if entity @a[name=Bench32] run scoreboard players set Bench32 sgp.id 32
execute if entity @a[name=Bench32] run tp Bench32 25.5 81 7.5 0 0
execute if score #players sgp.bench matches 33.. run dummy Bench33 spawn
execute if entity @a[name=Bench33] run tag Bench33 add sgp.bench.actor
execute if entity @a[name=Bench33] run scoreboard players set Bench33 sgp.bench 33
execute if entity @a[name=Bench33] run scoreboard players set Bench33 sgp.id 33
execute if entity @a[name=Bench33] run tp Bench33 -23.5 81 14.5 0 0
execute if score #players sgp.bench matches 34.. run dummy Bench34 spawn
execute if entity @a[name=Bench34] run tag Bench34 add sgp.bench.actor
execute if entity @a[name=Bench34] run scoreboard players set Bench34 sgp.bench 34
execute if entity @a[name=Bench34] run scoreboard players set Bench34 sgp.id 34
execute if entity @a[name=Bench34] run tp Bench34 -16.5 81 14.5 0 0
execute if score #players sgp.bench matches 35.. run dummy Bench35 spawn
execute if entity @a[name=Bench35] run tag Bench35 add sgp.bench.actor
execute if entity @a[name=Bench35] run scoreboard players set Bench35 sgp.bench 35
execute if entity @a[name=Bench35] run scoreboard players set Bench35 sgp.id 35
execute if entity @a[name=Bench35] run tp Bench35 -9.5 81 14.5 0 0
execute if score #players sgp.bench matches 36.. run dummy Bench36 spawn
execute if entity @a[name=Bench36] run tag Bench36 add sgp.bench.actor
execute if entity @a[name=Bench36] run scoreboard players set Bench36 sgp.bench 36
execute if entity @a[name=Bench36] run scoreboard players set Bench36 sgp.id 36
execute if entity @a[name=Bench36] run tp Bench36 -2.5 81 14.5 0 0
execute if score #players sgp.bench matches 37.. run dummy Bench37 spawn
execute if entity @a[name=Bench37] run tag Bench37 add sgp.bench.actor
execute if entity @a[name=Bench37] run scoreboard players set Bench37 sgp.bench 37
execute if entity @a[name=Bench37] run scoreboard players set Bench37 sgp.id 37
execute if entity @a[name=Bench37] run tp Bench37 4.5 81 14.5 0 0
execute if score #players sgp.bench matches 38.. run dummy Bench38 spawn
execute if entity @a[name=Bench38] run tag Bench38 add sgp.bench.actor
execute if entity @a[name=Bench38] run scoreboard players set Bench38 sgp.bench 38
execute if entity @a[name=Bench38] run scoreboard players set Bench38 sgp.id 38
execute if entity @a[name=Bench38] run tp Bench38 11.5 81 14.5 0 0
execute if score #players sgp.bench matches 39.. run dummy Bench39 spawn
execute if entity @a[name=Bench39] run tag Bench39 add sgp.bench.actor
execute if entity @a[name=Bench39] run scoreboard players set Bench39 sgp.bench 39
execute if entity @a[name=Bench39] run scoreboard players set Bench39 sgp.id 39
execute if entity @a[name=Bench39] run tp Bench39 18.5 81 14.5 0 0
execute if score #players sgp.bench matches 40.. run dummy Bench40 spawn
execute if entity @a[name=Bench40] run tag Bench40 add sgp.bench.actor
execute if entity @a[name=Bench40] run scoreboard players set Bench40 sgp.bench 40
execute if entity @a[name=Bench40] run scoreboard players set Bench40 sgp.id 40
execute if entity @a[name=Bench40] run tp Bench40 25.5 81 14.5 0 0

gamemode survival @a[tag=sgp.bench.actor]
clear @a[tag=sgp.bench.actor]
effect clear @a[tag=sgp.bench.actor]
tag @a[tag=sgp.bench.actor] add sgp.in_game
execute as @a[tag=sgp.bench.actor] run function sgp.misc:scoreboards/player_initialization
