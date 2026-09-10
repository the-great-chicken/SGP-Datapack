#> sgp.world:honey_climbing/head_contact
# @dummy
# @environment sgp.ci:honey_climbing
#
# A honey block beside the upper body is sufficient, on either horizontal axis.

function sgp.ci:honey_climbing/fixture
setblock ~3 ~2 ~4 honey_block
tp @s ~3.5 ~1 ~3.8
execute at @s run function sgp.world:slide_honey_up/add
function sgp.ci:honey_climbing/expect_active
function sgp.world:slide_honey_up/remove
setblock ~3 ~2 ~4 air
setblock ~2 ~2 ~3 honey_block
tp @s ~3.2 ~1 ~3.5
execute at @s run function sgp.world:slide_honey_up/add
function sgp.ci:honey_climbing/expect_active
function sgp.world:slide_honey_up/remove
