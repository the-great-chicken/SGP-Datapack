#> sgp.majeurs:protect/participant_exit_hook
#
# Route exits from either Protect team through the event-owned handler.

execute if entity @s[team=sgp.rouge] run return run function sgp.majeurs:protect/participant_exit {side:rouge,team:rouge,name:Rouge,color:dark_red,name_ennemies:Bleu,color_ennemies:dark_blue}
execute if entity @s[team=sgp.bleue] run return run function sgp.majeurs:protect/participant_exit {side:bleu,team:bleue,name:Bleu,color:dark_blue,name_ennemies:Rouge,color_ennemies:dark_red}
