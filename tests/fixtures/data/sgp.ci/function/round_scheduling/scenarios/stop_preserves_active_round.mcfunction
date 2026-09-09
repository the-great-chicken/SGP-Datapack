#> sgp.ci:round_scheduling/scenarios/stop_preserves_active_round

tag @s add sgp.major_participant
team join sgp.rouge @s
gamemode survival @s
item replace entity @s hotbar.0 with diamond_sword
scoreboard players set #rounds sgp.dummy 2
schedule function sgp.majeurs:pco/_start 30s
function sgp.majeurs:scheduler/stop
function sgp.majeurs:scheduler/stop
assert entity @s[tag=sgp.major_participant,team=sgp.rouge,gamemode=survival]
assert score #rounds sgp.dummy matches 2
assert data entity @s Inventory[{id:"minecraft:diamond_sword"}]
function sgp.ci:round_scheduling/expect_pending {event:pco,count:0}
