#> sgp.ci:spawn_routing/setup
# Save Confinement/Protect routing state before tests temporarily modify it.

function sgp.ci:players/cleanup
execute store result storage sgp.ci:spawn_routing previous.confinement int 1 run scoreboard players get #confines_secondes sgp.timer
execute store result storage sgp.ci:spawn_routing previous.protect int 1 run scoreboard players get #protect_phase sgp.dummy
