#> sgp.kits:abilities/assassinate/setup_pearl
#
# Link the pearl to the assassin by copying their UUID into the Owner tag, and give it downwards motion

data merge entity @s {Motion:[0.0,-10.0,0.0]}
execute as @p[tag=sgp.assassin_triggered,distance=0..] run function sgp.misc:player_uuid/to_macro
data modify entity @s Owner set from storage sgp:macro owner.uuid