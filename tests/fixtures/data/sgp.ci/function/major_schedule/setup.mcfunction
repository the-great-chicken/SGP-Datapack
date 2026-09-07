#> sgp.ci:major_schedule/setup

function sgp.ci:players/cleanup
data modify storage sgp.ci:major_schedule previous set value {}
function sgp.ci:major_schedule/save {event:pco}
function sgp.ci:major_schedule/save {event:hide_and_seek}
function sgp.ci:major_schedule/save {event:protect}
execute store result storage sgp.ci:major_schedule previous.rounds int 1 run scoreboard players get #rounds sgp.dummy
