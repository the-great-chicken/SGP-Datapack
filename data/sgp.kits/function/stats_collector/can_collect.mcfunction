#> sgp.kits:stats_collector/can_collect
#
# Return success only when the current schema is valid and no major event is
# active. All persistent statistics entry points use this same gate.

execute unless score #stats_schema_version sgp.dummy matches 7 run return 0
execute if score #stats_paused sgp.dummy matches 1 run return 0
return 1
