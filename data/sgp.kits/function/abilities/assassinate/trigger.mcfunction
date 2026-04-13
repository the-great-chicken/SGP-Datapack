#> sgp.kits:abilities/assassinate/trigger

# Honestly idk what's better between the tag check multiple times here + advancement revocation
# Or to check the player's nbt in the advancement for the tag.
execute if entity @s[tag=sgp.assassin] run tag @s add sgp.assassin_triggered

# 2. Determine the teleportation distance based on solid blocks behind the attacker.
# Check A: If there is a solid block 1 block behind, position 0.25 blocks behind instead.
execute if entity @s[tag=sgp.assassin] on attacker at @s rotated as @s rotated ~ 0 \
    unless block ^ ^ ^-1 #bs.hitbox:can_pass_through positioned ^ ^ ^-0.25 \
        run summon ender_pearl ~ ~1 ~ {Tags:["sgp.assassin_pearl"],Motion:[0.0,-10.0,0.0]}

execute if entity @s[tag=sgp.assassin] on attacker at @s rotated as @s rotated ~ 0 \
    unless block ^ ^ ^-1 #bs.hitbox:can_pass_through positioned ^ ^ ^-0.25 \
        positioned ~ ~0.5 ~ summon endermite run tag @s add sgp.hitbox_entity

# Check B: If 1 block behind is clear, but 2 blocks behind is a solid block, position 1 block behind.
execute if entity @s[tag=sgp.assassin] on attacker at @s rotated as @s rotated ~ 0 \
    if block ^ ^ ^-1 #bs.hitbox:can_pass_through unless block ^ ^ ^-2 #bs.hitbox:can_pass_through positioned ^ ^ ^-1 \
        run summon ender_pearl ~ ~1 ~ {Tags:["sgp.assassin_pearl"],Motion:[0.0,-10.0,0.0]}

execute if entity @s[tag=sgp.assassin] on attacker at @s rotated as @s rotated ~ 0 \
    if block ^ ^ ^-1 #bs.hitbox:can_pass_through unless block ^ ^ ^-2 #bs.hitbox:can_pass_through positioned ^ ^ ^-1 \
        positioned ~ ~0.5 ~ summon endermite run tag @s add sgp.hitbox_entity

# Check C: If both 1 block and 2 blocks behind are clear, position 2 blocks behind.
execute if entity @s[tag=sgp.assassin] on attacker at @s rotated as @s rotated ~ 0 \
    if block ^ ^ ^-1 #bs.hitbox:can_pass_through if block ^ ^ ^-2 #bs.hitbox:can_pass_through positioned ^ ^ ^-2 \
        run summon ender_pearl ~ ~1 ~ {Tags:["sgp.assassin_pearl"],Motion:[0.0,-10.0,0.0]}
        
execute if entity @s[tag=sgp.assassin] on attacker at @s rotated as @s rotated ~ 0 \
    if block ^ ^ ^-1 #bs.hitbox:can_pass_through if block ^ ^ ^-2 #bs.hitbox:can_pass_through positioned ^ ^ ^-2 \
        positioned ~ ~0.5 ~ summon endermite run tag @s add sgp.hitbox_entity


# Setup the summoned endermite
execute as @n[tag=sgp.hitbox_entity] run function #bs.health:time_to_live {with:{time:2,unit:"t"}}
data merge entity @n[tag=sgp.hitbox_entity] {NoGravity:true,Silent:true,Invisible:true}

# 3. Link the pearl to the assassin by copying their UUID into the Owner tag.
execute as @p[tag=sgp.assassin_triggered] run data modify entity @n[type=ender_pearl,tag=sgp.assassin_pearl] Owner set from entity @s UUID
execute if entity @s[tag=sgp.assassin] on attacker rotated as @s rotated ~ 0 run rotate @p[tag=sgp.assassin_triggered] ~ ~

execute if entity @s[tag=sgp.assassin] run tag @s remove sgp.assassin_triggered
advancement revoke @s only sgp.kits:assassinate

execute if entity @s[tag=sgp.assassin] run function sgp.kits:abilities/assassinate/disable