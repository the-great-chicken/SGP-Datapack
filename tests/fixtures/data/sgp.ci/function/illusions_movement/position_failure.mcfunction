#> sgp.ci:illusions_movement/position_failure
# Report the decoy and its actual position rather than an anonymous selector mismatch.

$fail "Illusion $(group)/$(direction): expected $(x) $(y) $(z) relative to 0 80 0; actual position $(actual)"
