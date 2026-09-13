#> sgp.majeurs:scheduler/reconfigure
# @dummy
# @environment sgp.ci:major_schedule
#
# Reconfiguring an event replaces its start time, warning time, and round limit without resetting an ongoing round counter.

scoreboard players set #rounds sgp.dummy 2
function sgp.majeurs:config/hide_and_seek {hour:22,minute:45,rounds:3}
function sgp.ci:major_schedule/expect {event:hide_and_seek,hour:22,minute:45,rounds:3,announcement_hour:22,announcement_minute:43}
function sgp.majeurs:config/hide_and_seek {hour:17,minute:20,rounds:1}
function sgp.ci:major_schedule/expect {event:hide_and_seek,hour:17,minute:20,rounds:1,announcement_hour:17,announcement_minute:18}
assert score #rounds sgp.dummy matches 2
