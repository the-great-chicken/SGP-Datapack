#> sgp.mineurs:bounty/init_wanted
#
# Give the wanted player his effects and bind the tag to this bounty run.

scoreboard players operation @s sgp.bounty_gen = #generation sgp.bounty_gen
effect give @s glowing infinite 1 true
title @s subtitle {text:"Tu as une prime sur ta tête",color:red,bold:true}