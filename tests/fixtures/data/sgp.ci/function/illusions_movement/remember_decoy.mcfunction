#> sgp.ci:illusions_movement/remember_decoy
# `{group: fixture group, direction: left|right|opposite}`
#
# Keep the original identity so missing-tag diagnostics can still inspect the entity.

function gu:generate
$data modify storage sgp.ci:illusions_movement identities.$(group).$(direction) set value {}
$data modify storage sgp.ci:illusions_movement identities.$(group).$(direction).uuid set from storage gu:main out
