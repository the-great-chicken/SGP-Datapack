#> sgp.ci:repulsion/scenarios/unequipped/1
# Remove the Repulsion enchantment and arm the trigger to test the unequipped path.

item replace entity @e[tag=sgp.ci.repulsion,type=husk] armor.chest with air
scoreboard players set @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,type=husk] sgp.trigger_repulsion 1
