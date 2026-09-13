#> sgp.ci:round_scheduling/expect_pending
# `{event: major event path, count: 0|1}`
#
# Inspect the real schedule by clearing the expected pending event start before it can launch gameplay.

$execute store result score #ci.round.pending sgp.dummy run schedule clear sgp.majeurs:$(event)/_start
$assert score #ci.round.pending sgp.dummy matches $(count)
