#> sgp.majeurs:round_scheduling/stop_cancels_all_starts
# @dummy
# @environment sgp.ci:round_scheduling/stop_cancels_all_starts
#
# Stopping the scheduler cancels its poll and every pending major-event start, without canceling unrelated callbacks.

function sgp.ci:round_scheduling/scenarios/stop_cancels_all_starts
