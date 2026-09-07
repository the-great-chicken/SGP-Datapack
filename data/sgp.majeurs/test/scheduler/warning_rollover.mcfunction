#> sgp.majeurs:scheduler/warning_rollover
# @dummy
# @environment sgp.ci:major_schedule
#
# The warning stays exactly two minutes before the start across hour and midnight boundaries.

function sgp.majeurs:config/pco {hour:12,minute:0,rounds:2}
function sgp.ci:major_schedule/expect {event:pco,hour:12,minute:0,rounds:2,announcement_hour:11,announcement_minute:58}
function sgp.majeurs:config/pco {hour:12,minute:1,rounds:2}
function sgp.ci:major_schedule/expect {event:pco,hour:12,minute:1,rounds:2,announcement_hour:11,announcement_minute:59}
function sgp.majeurs:config/pco {hour:0,minute:0,rounds:2}
function sgp.ci:major_schedule/expect {event:pco,hour:0,minute:0,rounds:2,announcement_hour:23,announcement_minute:58}
function sgp.majeurs:config/pco {hour:0,minute:1,rounds:2}
function sgp.ci:major_schedule/expect {event:pco,hour:0,minute:1,rounds:2,announcement_hour:23,announcement_minute:59}
function sgp.majeurs:config/pco {hour:0,minute:2,rounds:2}
function sgp.ci:major_schedule/expect {event:pco,hour:0,minute:2,rounds:2,announcement_hour:0,announcement_minute:0}
