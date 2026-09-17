#> sgp.bench:actors/cleanup
# Disconnect only benchmark-owned fake players; never touch a real/local player.
# PackTest can respawn the same dummy name with a new UUID while scoreboard values
# survive by name. Remove the Actionbar Mixer storage row referenced by the old UID
# before clearing scores, otherwise repeated runs can accumulate stale registrations.

execute as @a[tag=sgp.bench.actor,scores={dah.actbar.UID=1..}] run function sgp.bench:actors/remove_mixer_registration

execute if entity @a[name=Bench01] run dummy Bench01 leave
execute if entity @a[name=Bench02] run dummy Bench02 leave
execute if entity @a[name=Bench03] run dummy Bench03 leave
execute if entity @a[name=Bench04] run dummy Bench04 leave
execute if entity @a[name=Bench05] run dummy Bench05 leave
execute if entity @a[name=Bench06] run dummy Bench06 leave
execute if entity @a[name=Bench07] run dummy Bench07 leave
execute if entity @a[name=Bench08] run dummy Bench08 leave
execute if entity @a[name=Bench09] run dummy Bench09 leave
execute if entity @a[name=Bench10] run dummy Bench10 leave
execute if entity @a[name=Bench11] run dummy Bench11 leave
execute if entity @a[name=Bench12] run dummy Bench12 leave
execute if entity @a[name=Bench13] run dummy Bench13 leave
execute if entity @a[name=Bench14] run dummy Bench14 leave
execute if entity @a[name=Bench15] run dummy Bench15 leave
execute if entity @a[name=Bench16] run dummy Bench16 leave
execute if entity @a[name=Bench17] run dummy Bench17 leave
execute if entity @a[name=Bench18] run dummy Bench18 leave
execute if entity @a[name=Bench19] run dummy Bench19 leave
execute if entity @a[name=Bench20] run dummy Bench20 leave
execute if entity @a[name=Bench21] run dummy Bench21 leave
execute if entity @a[name=Bench22] run dummy Bench22 leave
execute if entity @a[name=Bench23] run dummy Bench23 leave
execute if entity @a[name=Bench24] run dummy Bench24 leave
execute if entity @a[name=Bench25] run dummy Bench25 leave
execute if entity @a[name=Bench26] run dummy Bench26 leave
execute if entity @a[name=Bench27] run dummy Bench27 leave
execute if entity @a[name=Bench28] run dummy Bench28 leave
execute if entity @a[name=Bench29] run dummy Bench29 leave
execute if entity @a[name=Bench30] run dummy Bench30 leave
execute if entity @a[name=Bench31] run dummy Bench31 leave
execute if entity @a[name=Bench32] run dummy Bench32 leave
execute if entity @a[name=Bench33] run dummy Bench33 leave
execute if entity @a[name=Bench34] run dummy Bench34 leave
execute if entity @a[name=Bench35] run dummy Bench35 leave
execute if entity @a[name=Bench36] run dummy Bench36 leave
execute if entity @a[name=Bench37] run dummy Bench37 leave
execute if entity @a[name=Bench38] run dummy Bench38 leave
execute if entity @a[name=Bench39] run dummy Bench39 leave
execute if entity @a[name=Bench40] run dummy Bench40 leave

# Remove every persistent scoreboard value for these names. Fake-player leave/respawn
# does not guarantee scoreboard state is fresh between benchmark repetitions.
scoreboard players reset Bench01
scoreboard players reset Bench02
scoreboard players reset Bench03
scoreboard players reset Bench04
scoreboard players reset Bench05
scoreboard players reset Bench06
scoreboard players reset Bench07
scoreboard players reset Bench08
scoreboard players reset Bench09
scoreboard players reset Bench10
scoreboard players reset Bench11
scoreboard players reset Bench12
scoreboard players reset Bench13
scoreboard players reset Bench14
scoreboard players reset Bench15
scoreboard players reset Bench16
scoreboard players reset Bench17
scoreboard players reset Bench18
scoreboard players reset Bench19
scoreboard players reset Bench20
scoreboard players reset Bench21
scoreboard players reset Bench22
scoreboard players reset Bench23
scoreboard players reset Bench24
scoreboard players reset Bench25
scoreboard players reset Bench26
scoreboard players reset Bench27
scoreboard players reset Bench28
scoreboard players reset Bench29
scoreboard players reset Bench30
scoreboard players reset Bench31
scoreboard players reset Bench32
scoreboard players reset Bench33
scoreboard players reset Bench34
scoreboard players reset Bench35
scoreboard players reset Bench36
scoreboard players reset Bench37
scoreboard players reset Bench38
scoreboard players reset Bench39
scoreboard players reset Bench40

# Remove benchmark-player entries from persistent production statistics so each
# repetition starts from the same storage shape.
data remove storage sgp.kits:stats players.1
data remove storage sgp.kits:stats kits_dict.1
data remove storage sgp.kits:stats elo_ratings.1
data remove storage sgp.kits:stats players.2
data remove storage sgp.kits:stats kits_dict.2
data remove storage sgp.kits:stats elo_ratings.2
data remove storage sgp.kits:stats players.3
data remove storage sgp.kits:stats kits_dict.3
data remove storage sgp.kits:stats elo_ratings.3
data remove storage sgp.kits:stats players.4
data remove storage sgp.kits:stats kits_dict.4
data remove storage sgp.kits:stats elo_ratings.4
data remove storage sgp.kits:stats players.5
data remove storage sgp.kits:stats kits_dict.5
data remove storage sgp.kits:stats elo_ratings.5
data remove storage sgp.kits:stats players.6
data remove storage sgp.kits:stats kits_dict.6
data remove storage sgp.kits:stats elo_ratings.6
data remove storage sgp.kits:stats players.7
data remove storage sgp.kits:stats kits_dict.7
data remove storage sgp.kits:stats elo_ratings.7
data remove storage sgp.kits:stats players.8
data remove storage sgp.kits:stats kits_dict.8
data remove storage sgp.kits:stats elo_ratings.8
data remove storage sgp.kits:stats players.9
data remove storage sgp.kits:stats kits_dict.9
data remove storage sgp.kits:stats elo_ratings.9
data remove storage sgp.kits:stats players.10
data remove storage sgp.kits:stats kits_dict.10
data remove storage sgp.kits:stats elo_ratings.10
data remove storage sgp.kits:stats players.11
data remove storage sgp.kits:stats kits_dict.11
data remove storage sgp.kits:stats elo_ratings.11
data remove storage sgp.kits:stats players.12
data remove storage sgp.kits:stats kits_dict.12
data remove storage sgp.kits:stats elo_ratings.12
data remove storage sgp.kits:stats players.13
data remove storage sgp.kits:stats kits_dict.13
data remove storage sgp.kits:stats elo_ratings.13
data remove storage sgp.kits:stats players.14
data remove storage sgp.kits:stats kits_dict.14
data remove storage sgp.kits:stats elo_ratings.14
data remove storage sgp.kits:stats players.15
data remove storage sgp.kits:stats kits_dict.15
data remove storage sgp.kits:stats elo_ratings.15
data remove storage sgp.kits:stats players.16
data remove storage sgp.kits:stats kits_dict.16
data remove storage sgp.kits:stats elo_ratings.16
data remove storage sgp.kits:stats players.17
data remove storage sgp.kits:stats kits_dict.17
data remove storage sgp.kits:stats elo_ratings.17
data remove storage sgp.kits:stats players.18
data remove storage sgp.kits:stats kits_dict.18
data remove storage sgp.kits:stats elo_ratings.18
data remove storage sgp.kits:stats players.19
data remove storage sgp.kits:stats kits_dict.19
data remove storage sgp.kits:stats elo_ratings.19
data remove storage sgp.kits:stats players.20
data remove storage sgp.kits:stats kits_dict.20
data remove storage sgp.kits:stats elo_ratings.20
data remove storage sgp.kits:stats players.21
data remove storage sgp.kits:stats kits_dict.21
data remove storage sgp.kits:stats elo_ratings.21
data remove storage sgp.kits:stats players.22
data remove storage sgp.kits:stats kits_dict.22
data remove storage sgp.kits:stats elo_ratings.22
data remove storage sgp.kits:stats players.23
data remove storage sgp.kits:stats kits_dict.23
data remove storage sgp.kits:stats elo_ratings.23
data remove storage sgp.kits:stats players.24
data remove storage sgp.kits:stats kits_dict.24
data remove storage sgp.kits:stats elo_ratings.24
data remove storage sgp.kits:stats players.25
data remove storage sgp.kits:stats kits_dict.25
data remove storage sgp.kits:stats elo_ratings.25
data remove storage sgp.kits:stats players.26
data remove storage sgp.kits:stats kits_dict.26
data remove storage sgp.kits:stats elo_ratings.26
data remove storage sgp.kits:stats players.27
data remove storage sgp.kits:stats kits_dict.27
data remove storage sgp.kits:stats elo_ratings.27
data remove storage sgp.kits:stats players.28
data remove storage sgp.kits:stats kits_dict.28
data remove storage sgp.kits:stats elo_ratings.28
data remove storage sgp.kits:stats players.29
data remove storage sgp.kits:stats kits_dict.29
data remove storage sgp.kits:stats elo_ratings.29
data remove storage sgp.kits:stats players.30
data remove storage sgp.kits:stats kits_dict.30
data remove storage sgp.kits:stats elo_ratings.30
data remove storage sgp.kits:stats players.31
data remove storage sgp.kits:stats kits_dict.31
data remove storage sgp.kits:stats elo_ratings.31
data remove storage sgp.kits:stats players.32
data remove storage sgp.kits:stats kits_dict.32
data remove storage sgp.kits:stats elo_ratings.32
data remove storage sgp.kits:stats players.33
data remove storage sgp.kits:stats kits_dict.33
data remove storage sgp.kits:stats elo_ratings.33
data remove storage sgp.kits:stats players.34
data remove storage sgp.kits:stats kits_dict.34
data remove storage sgp.kits:stats elo_ratings.34
data remove storage sgp.kits:stats players.35
data remove storage sgp.kits:stats kits_dict.35
data remove storage sgp.kits:stats elo_ratings.35
data remove storage sgp.kits:stats players.36
data remove storage sgp.kits:stats kits_dict.36
data remove storage sgp.kits:stats elo_ratings.36
data remove storage sgp.kits:stats players.37
data remove storage sgp.kits:stats kits_dict.37
data remove storage sgp.kits:stats elo_ratings.37
data remove storage sgp.kits:stats players.38
data remove storage sgp.kits:stats kits_dict.38
data remove storage sgp.kits:stats elo_ratings.38
data remove storage sgp.kits:stats players.39
data remove storage sgp.kits:stats kits_dict.39
data remove storage sgp.kits:stats elo_ratings.39
data remove storage sgp.kits:stats players.40
data remove storage sgp.kits:stats kits_dict.40
data remove storage sgp.kits:stats elo_ratings.40
