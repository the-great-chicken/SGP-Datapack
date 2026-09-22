#> sgp.kits:abilities/tnt/tick_fire_cooldowns
#
# Called once per server tick before lingering-fire markers are processed.
#
# After a successful 2-damage on_fire hit, vanilla rejects another identical
# non-bypassing hit while its invulnerability timer is above 10. Starting from
# 20, the next nine fire checks are therefore guaranteed failures. Keep the
# tenth check: that is the first one vanilla can accept again.

scoreboard players remove @a[tag=sgp.tnt_fire_cached,scores={sgp.tnt_fire_cd=1..}] sgp.tnt_fire_cd 1
tag @a[tag=sgp.tnt_fire_cached,scores={sgp.tnt_fire_cd=..0}] remove sgp.tnt_fire_cached
