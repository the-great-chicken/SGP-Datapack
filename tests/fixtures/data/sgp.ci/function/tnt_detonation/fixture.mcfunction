#> sgp.ci:tnt_detonation/fixture
# Build the standard two-charge click fixture and assign deterministic owner identities.

function sgp.ci:tnt_clicks/fixture
scoreboard players set @e[tag=sgp.ci.click_tnt_a,type=tnt] sgp.damage_owner 98101
scoreboard players set @e[tag=sgp.ci.click_tnt_b,type=tnt] sgp.damage_owner 98102
