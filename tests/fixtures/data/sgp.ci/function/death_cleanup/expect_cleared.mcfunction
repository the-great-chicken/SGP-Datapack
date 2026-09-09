#> sgp.ci:death_cleanup/expect_cleared

assert score @s sgp.kit_id matches -1
assert score @s sgp.cooldown_ability matches 0
assert score @s sgp.kills_give_1 matches 0
assert score @s sgp.kills_give_2 matches 0
assert score @s sgp.kills_give_3 matches 0
assert score @s sgp.just_died matches 0
assert not data entity @s Inventory[0]
assert not data entity @s active_effects[0]
