#> sgp.misc:actionbar/hud/select_current_kit
# `{kit_path}`
#
# Copies the current player's kit visual data from the canonical sgp:kits entry.

$data modify storage sgp:macro actionbar_hud.kit set from storage sgp:kits $(kit_path)
