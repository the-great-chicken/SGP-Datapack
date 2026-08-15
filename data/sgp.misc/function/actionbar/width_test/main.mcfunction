#> sgp.misc:actionbar/width_test/main
# `{text: text component, width:int}`

tag @s add sgp.is_testing_width
function sgp.misc:actionbar/width_test/clear
schedule clear sgp.misc:actionbar/width_test/sub
schedule clear sgp.misc:actionbar/width_test/clear

tag @s add sgp.is_testing_width

$data modify storage sgp:macro width_test set value [{id:"sgp:test_1", order:1, text:$(text)}, \
                                                    {id:"sgp:test_2", order:2, text:$(text)}, \
                                                    {id:"sgp:test_3", order:3, text:$(text)}, \
                                                    {id:"sgp:test_4", order:4, text:$(text)},]

$scoreboard players set #test_width_init sgp.dummy $(width)

function sgp.misc:actionbar/width_test/sub
schedule function sgp.misc:actionbar/width_test/sub 2s append
schedule function sgp.misc:actionbar/width_test/sub 4s append
schedule function sgp.misc:actionbar/width_test/sub 6s append

schedule function sgp.misc:actionbar/width_test/clear 8s append