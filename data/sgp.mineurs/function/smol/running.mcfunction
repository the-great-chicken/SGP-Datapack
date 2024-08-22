scoreboard players add #smol_seconds sgp.dummy 1

experience add @a[tag=sgp.in_game] -1 levels

execute unless score #smol_seconds sgp.dummy matches 150.. \
    run schedule function sgp.mineurs:smol/running 20t

execute if score #smol_seconds sgp.dummy matches 150.. \
    run function sgp.mineurs:smol/stop