#> sgp.ci:rays/say_damage_diagnostics
# `{caster, near_pos, far_pos: position list, near_health, far_health: float, beams: NBT list}`
#
# Emit a compact snapshot of caster/target positions, health, and beam metadata after a damage mismatch.

$say Ray damage mismatch: caster=$(caster), near=$(near_pos)/$(near_health), far=$(far_pos)/$(far_health), beams=$(beams)
