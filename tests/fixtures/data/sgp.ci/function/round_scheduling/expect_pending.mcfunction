#> sgp.ci:round_scheduling/expect_pending

# {event,count}: inspect the real queue by removing the pending start, before it can launch a gameplay event.
$execute store result score #ci.round.pending sgp.dummy run schedule clear sgp.majeurs:$(event)/_start
$assert score #ci.round.pending sgp.dummy matches $(count)
