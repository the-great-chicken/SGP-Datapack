#> sgp.kits:abilities/assassinate/setup_pearl
#
# Link the pearl to the assassin by copying their UUID into the Owner tag, and give it downwards motion

data merge entity @s {Motion:[0.0,-10.0,0.0]}
data modify entity @s Owner set from entity @p[tag=sgp.assassin_triggered,distance=0..] UUID