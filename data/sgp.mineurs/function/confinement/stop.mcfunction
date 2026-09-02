#> sgp.mineurs:confinement/stop

schedule clear sgp.mineurs:confinement/running
scoreboard players set #confines_secondes sgp.timer 0
time of sgp.mineurs:confinement_clock set 10000t
schedule clear sgp.mineurs:confinement/add_time_clock
function sgp.mineurs:common/timed_event/stop {event:"confinement"}
