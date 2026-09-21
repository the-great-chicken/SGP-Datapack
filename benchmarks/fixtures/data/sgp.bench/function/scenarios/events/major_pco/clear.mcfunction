#> sgp.bench:scenarios/events/major_pco/clear
# Remove every benchmark-owned PCO block, marker and registry entry (also used to recover
# from an interrupted run before the production registry is touched again).

function #bs.schedule:cancel_all {with:{id:"pco"}}
schedule clear sgp.majeurs:pco/_start
kill @e[tag=sgp.bench.pco,type=marker]
fill -31 60 -31 -30 61 -30 air
fill -31 60 -27 -30 61 -26 air
fill 20 81 -8 21 82 -7 air
fill -27 60 -31 -26 61 -30 air
fill -27 60 -27 -26 61 -26 air
fill -20 81 -19 -19 82 -18 air
fill -23 60 -31 -22 61 -30 air
fill -23 60 -27 -22 61 -26 air
fill -20 81 18 -19 82 19 air
data modify storage sgp:data majeurs.pco.locations set value []
data remove storage sgp:data majeurs.pco.active_location
data remove storage sgp:data majeurs.pco.pinned_location
scoreboard players set #pco_phase sgp.dummy 0
scoreboard players set #rounds sgp.dummy 0
team empty sgp.Poule
team empty sgp.Canard
team empty sgp.Oie
