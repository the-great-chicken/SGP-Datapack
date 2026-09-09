#> sgp.ci:honey_climbing/scenarios/player_isolation

function sgp.ci:honey_climbing/fixture
dummy HoneyOther spawn
gamemode survival HoneyOther
attribute HoneyOther minecraft:gravity base set 0.08
setblock ~4 ~1 ~3 honey_block
tp @s ~3.8 ~1 ~3.5
tp HoneyOther ~3.8 ~1 ~3.5
execute at @s run function sgp.world:slide_honey_up/add
execute as HoneyOther at @s run function sgp.world:slide_honey_up/add
function sgp.ci:honey_climbing/expect_active
execute as HoneyOther run function sgp.ci:honey_climbing/expect_active
function sgp.world:slide_honey_up/remove
function sgp.ci:honey_climbing/expect_gravity {range:"7999..8001"}
execute as HoneyOther run function sgp.ci:honey_climbing/expect_active
execute as HoneyOther run function sgp.world:slide_honey_up/remove
execute as HoneyOther run function sgp.ci:honey_climbing/expect_gravity {range:"7999..8001"}
dummy HoneyOther leave
