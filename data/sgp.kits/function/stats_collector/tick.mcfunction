#> sgp.kits:stats_collector/tick
#
# Detect major-event transitions so duration-based collector state is paused
# and resumed at the same boundary as event-based statistics.

execute unless score #stats_schema_version sgp.dummy matches 5 run return 0

execute store success score #stats_major_event_active sgp.dummy \
    if entity @a[predicate=sgp.majeurs:event_in_progress]

execute if score #stats_major_event_active sgp.dummy matches 1 \
    unless score #stats_paused sgp.dummy matches 1 \
        run function sgp.kits:stats_collector/pause_for_major_event

execute if score #stats_major_event_active sgp.dummy matches 0 \
    if score #stats_paused sgp.dummy matches 1 \
    unless entity @a[scores={sgp.just_died=1..}] \
        run function sgp.kits:stats_collector/resume_after_major_event
