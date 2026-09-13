#> sgp.majeurs:scheduler/event_isolation
# @dummy
# @environment sgp.ci:major_schedule
#
# Changing one event's schedule leaves the other events' starts, warnings, and round limits intact.

function sgp.majeurs:config/pco {hour:20,minute:15,rounds:2}
function sgp.majeurs:config/hide_and_seek {hour:21,minute:30,rounds:3}
function sgp.majeurs:config/protect {hour:22,minute:45,rounds:4}
function sgp.majeurs:config/protect {hour:0,minute:1,rounds:1}
function sgp.ci:major_schedule/expect {event:pco,hour:20,minute:15,rounds:2,announcement_hour:20,announcement_minute:13}
function sgp.ci:major_schedule/expect {event:hide_and_seek,hour:21,minute:30,rounds:3,announcement_hour:21,announcement_minute:28}
function sgp.ci:major_schedule/expect {event:protect,hour:0,minute:1,rounds:1,announcement_hour:23,announcement_minute:59}
