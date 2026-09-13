#> sgp.ci:tnt_detonation/fixture
# Build the shared two-charge interaction fixture and assign deterministic owner identities.

function sgp.ci:tnt/interaction_pairs/setup
scoreboard players set @e[tag=sgp.ci.tnt_charge_a,type=tnt] sgp.damage_owner 98101
scoreboard players set @e[tag=sgp.ci.tnt_charge_b,type=tnt] sgp.damage_owner 98102
