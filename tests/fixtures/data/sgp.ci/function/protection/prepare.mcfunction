#> sgp.ci:protection/prepare
# Reset both protected players, apply the Protection kit identity, and verify full starting health.

clear @s
clear ProtectPeer
effect clear @s
effect clear ProtectPeer
# The 61-tick login-protection wait happens in survival mode, so establish the
# health baseline explicitly instead of assuming neither dummy took incidental damage.
effect give @s minecraft:instant_health 1 4 true
effect give ProtectPeer minecraft:instant_health 1 4 true
scoreboard players set @s sgp.kit_id 8
scoreboard players set ProtectPeer sgp.kit_id 8
assert entity @s[nbt={Health:20.0f}]
assert entity @a[name=ProtectPeer,nbt={Health:20.0f}]
