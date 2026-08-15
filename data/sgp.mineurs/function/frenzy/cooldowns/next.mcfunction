#> sgp.mineurs:frenzy/cooldowns/next
# `{value: <remaining ability compound>}`

$data modify storage sgp:data mineurs.haste.walker.snbt set value '$(value)'

# All keys were consumed.
execute if data storage sgp:data mineurs.haste.walker{snbt:"{}"} run return 1

# Reset the character scanner for the first key of the remaining compound.
execute store result score #haste.snbt_length sgp.dummy run data get storage sgp:data mineurs.haste.walker.snbt
scoreboard players set #haste.scan_index sgp.dummy 1
scoreboard players set #haste.scan_next sgp.dummy 2
scoreboard players set #haste.in_quote sgp.dummy 0
scoreboard players set #haste.quote_type sgp.dummy 0
scoreboard players set #haste.escaped sgp.dummy 0
data modify storage sgp:data mineurs.haste.walker.scan set value {index:1,next:2}
function sgp.mineurs:frenzy/cooldowns/scan with storage sgp:data mineurs.haste.walker.scan
