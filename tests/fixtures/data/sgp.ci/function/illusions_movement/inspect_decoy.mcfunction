#> sgp.ci:illusions_movement/inspect_decoy
# {uuid}
# Direct UUID lookup also finds entities whose test tags have been lost.

$data modify storage sgp.ci:illusions_movement identity_check set value {uuid:"$(uuid)",entity:{}}
$data modify storage sgp.ci:illusions_movement identity_check.entity set from entity $(uuid)
function sgp.ci:illusions_movement/log_identity with storage sgp.ci:illusions_movement identity_check
