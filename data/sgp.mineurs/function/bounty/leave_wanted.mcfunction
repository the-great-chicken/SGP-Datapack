#> sgp.mineurs:bounty/leave_wanted
#
# Remove wanted tag and send the reward message to the attacker

execute on attacker run function sgp.mineurs:bounty/reward/message
tag @s remove sgp.wanted