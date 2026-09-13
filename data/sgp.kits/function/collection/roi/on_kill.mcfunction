#> sgp.kits:collection/roi/on_kill
# 
# Gives the Roi kill rewards

execute if score @s sgp.kills_give_1 matches 1.. run function sgp.kits:collection/roi/kills_give

# Consume every earned payout, retaining progress toward the next one.
execute if score @s sgp.kills_give_1 matches 1.. run return run function sgp.kits:collection/roi/on_kill
