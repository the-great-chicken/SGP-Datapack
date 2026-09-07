#> sgp.ci:major_schedule/cleanup

function sgp.ci:players/cleanup
function sgp.ci:major_schedule/restore {event:pco}
function sgp.ci:major_schedule/restore {event:hide_and_seek}
function sgp.ci:major_schedule/restore {event:protect}
execute store result score #rounds sgp.dummy run data get storage sgp.ci:major_schedule previous.rounds
data remove storage sgp.ci:major_schedule previous
