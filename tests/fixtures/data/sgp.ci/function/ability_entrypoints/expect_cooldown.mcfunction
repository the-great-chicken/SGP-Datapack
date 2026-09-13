#> sgp.ci:ability_entrypoints/expect_cooldown
# `{ability: string}`
# Compare the routed cooldown with the live production configuration instead of hard-coding balance values.

$execute store result score #ci.ability.cooldown sgp.dummy run data get storage sgp:data kits.ability_cooldowns.$(ability).cooldown
assert score @s sgp.cooldown_ability = #ci.ability.cooldown sgp.dummy
