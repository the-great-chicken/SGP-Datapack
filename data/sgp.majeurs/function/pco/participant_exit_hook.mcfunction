#> sgp.majeurs:pco/participant_exit_hook
# Route a participant exit while a PCO round is active.

execute unless score #pco_phase sgp.dummy matches 2 run return 0
execute if entity @s[team=sgp.Poule] \
    run return run function sgp.majeurs:pco/participant_exit {team:Poule, name_ennemies:Oies, color_ennemies:yellow, victory:victorieuses}

execute if entity @s[team=sgp.Canard] \
    run return run function sgp.majeurs:pco/participant_exit {team:Canard, name_ennemies:Poules, color_ennemies:red, victory:victorieuses}

execute if entity @s[team=sgp.Oie] \
    run return run function sgp.majeurs:pco/participant_exit {team:Oie, name_ennemies:Canards, color_ennemies:green, victory:victorieux}
