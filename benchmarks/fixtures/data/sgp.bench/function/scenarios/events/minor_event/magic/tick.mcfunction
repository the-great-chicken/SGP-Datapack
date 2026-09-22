#> sgp.bench:scenarios/events/minor_event/magic/tick
# `{first, last, players, event}`
# The roll is fixed to health boost (4) so nobody levitates, withers or turns invisible.
scoreboard players operation #minor_mod sgp.bench = #minor_phase sgp.bench
scoreboard players operation #minor_mod sgp.bench %= #minor_c60 sgp.bench
execute unless score #minor_mod sgp.bench matches 0 run return 0
scoreboard players set #random_magic_roll sgp.dummy 4
function sgp.mineurs:magic/choose_effect
scoreboard players add #minor_actions sgp.bench 1
