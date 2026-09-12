#> sgp.ci:illusions_movement/position_failure
# `{group: fixture group, direction: left|right|opposite, x, y, z: coordinate, actual: position list}`
#
# Emit expected/actual position diagnostics before the caller raises the assertion failure.

$say Illusion position mismatch: group=$(group), direction=$(direction), expected=($(x), $(y), $(z)), actual=$(actual)
