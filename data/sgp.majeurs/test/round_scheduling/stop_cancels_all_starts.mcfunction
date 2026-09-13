#> sgp.majeurs:round_scheduling/stop_cancels_all_starts
# @dummy
# @environment sgp.ci:round_scheduling/stop_cancels_all_starts
#
# Stopping the scheduler cancels its poll and every pending major-event start, without canceling unrelated callbacks.

schedule function sgp.majeurs:scheduler/main 60s
schedule function sgp.majeurs:pco/_start 30s
schedule function sgp.majeurs:hide_and_seek/_start 30s
schedule function sgp.majeurs:protect/_start 30s
schedule function sgp.ci:round_scheduling/unrelated 30s
function sgp.majeurs:scheduler/stop
execute store result score #ci.round.pending sgp.dummy run schedule clear sgp.majeurs:scheduler/main
assert score #ci.round.pending sgp.dummy matches 0
function sgp.ci:round_scheduling/expect_pending {event:pco,count:0}
function sgp.ci:round_scheduling/expect_pending {event:hide_and_seek,count:0}
function sgp.ci:round_scheduling/expect_pending {event:protect,count:0}
execute store result score #ci.round.pending sgp.dummy run schedule clear sgp.ci:round_scheduling/unrelated
assert score #ci.round.pending sgp.dummy matches 1
