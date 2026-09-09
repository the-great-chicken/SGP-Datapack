#> sgp.ci:honey_climbing/scenarios/feet_contact

function sgp.ci:honey_climbing/fixture
setblock ~4 ~1 ~3 honey_block
tp @s ~3.8 ~1 ~3.5
execute at @s run function sgp.world:slide_honey_up/add
function sgp.ci:honey_climbing/expect_active
function sgp.world:slide_honey_up/remove
assert not entity @s[tag=sgp.sliding_up]
function sgp.ci:honey_climbing/expect_gravity {range:"7999..8001"}
