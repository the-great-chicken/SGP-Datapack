#> sgp.ci:ability_entrypoints/seed_stats
# `{id: int, kit: int, ability: string}`
# Give telemetry a valid test-owned destination if collection is enabled during this run.

$scoreboard players set @s sgp.id $(id)
$data modify storage sgp.kits:stats kits_dict.$(id).$(kit).abilities.$(ability) set value {uses:0,successful_uses:0,affected_players:0}
