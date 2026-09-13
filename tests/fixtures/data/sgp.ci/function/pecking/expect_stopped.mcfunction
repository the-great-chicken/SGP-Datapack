#> sgp.ci:pecking/expect_stopped
# Stopping releases the attack and starts the configured cooldown.

assert not entity @s[tag=sgp.is_pecking]
assert score @s sgp.cooldown_ability matches 37
assert score @s sgp.duration_ability matches 1
assert not entity @a[tag=sgp.ci.peck_actor,tag=sgp.is_being_pecked]
assert not entity @s[tag=sgp.source_peck]
