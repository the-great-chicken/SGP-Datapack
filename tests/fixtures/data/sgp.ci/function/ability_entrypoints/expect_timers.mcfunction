#> sgp.ci:ability_entrypoints/expect_timers
# `{ability: string}`
# Compare both routed timers with the live production configuration.

$execute store result score #ci.ability.cooldown sgp.dummy run data get storage sgp:data kits.ability_cooldowns.$(ability).cooldown
$execute store result score #ci.ability.duration sgp.dummy run data get storage sgp:data kits.ability_cooldowns.$(ability).duration
assert score @s sgp.cooldown_ability = #ci.ability.cooldown sgp.dummy
assert score @s sgp.duration_ability = #ci.ability.duration sgp.dummy
