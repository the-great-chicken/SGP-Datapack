#> sgp.cosmetics:kill_effects/reset_and_replace

$execute if score @s sgp.kill.$(kill)_unlocked matches 1 run function sgp.cosmetics:kill_effects/disable
$function sgp.cosmetics:update {effect:"$(kill)", effect_name:"$(kill_name)", color:"$(color)", type:"kill", type_text:"le Kill Effect"}
