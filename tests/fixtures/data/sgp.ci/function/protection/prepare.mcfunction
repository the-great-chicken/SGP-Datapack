#> sgp.ci:protection/prepare
# Reset both protected players, apply the Protection kit identity, and verify full starting health.

clear @s
clear ProtectPeer
effect clear @s
effect clear ProtectPeer
scoreboard players set @s sgp.kit_id 8
scoreboard players set ProtectPeer sgp.kit_id 8
assert entity @s[nbt={Health:20.0f}]
assert entity @a[name=ProtectPeer,nbt={Health:20.0f}]
