#> Summons a dummy and test for each kit if it can be obtained without unlocking it
# @dummy

scoreboard players set @s sgp.veut_alchimiste 1
function sgp.kits:misc/check_and_run
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players set @s sgp.veut_cancer 1
function sgp.kits:misc/check_and_run
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players set @s sgp.veut_eclaireur 1
function sgp.kits:misc/check_and_run
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players set @s sgp.veut_enderman 1
function sgp.kits:misc/check_and_run
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players set @s sgp.veut_pigeon 1
function sgp.kits:misc/check_and_run
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players set @s sgp.veut_poseidon 1
function sgp.kits:misc/check_and_run
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players set @s sgp.veut_pyromane 1
function sgp.kits:misc/check_and_run
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players set @s sgp.veut_roi 1
function sgp.kits:misc/check_and_run
assert not entity @s[nbt={Inventory:[{}]}]

scoreboard players set @s sgp.veut_tank 1
function sgp.kits:misc/check_and_run
assert not entity @s[nbt={Inventory:[{}]}]