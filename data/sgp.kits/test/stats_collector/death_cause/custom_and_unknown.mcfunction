#> sgp.kits:stats_collector/death_cause/custom_and_unknown
# @dummy
#
# SGP-specific ability causes stay outside the vanilla id range and unknown remains zero.

function sgp.ci:death_cause/expect {cause:"unknown",id:0}
function sgp.ci:death_cause/expect {cause:"giant_sweep",id:100}
function sgp.ci:death_cause/expect {cause:"pecking",id:101}
function sgp.ci:death_cause/expect {cause:"ray",id:102}
