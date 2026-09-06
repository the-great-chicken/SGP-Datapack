#> sgp.cosmetics:particles/reset_and_replace

$execute if score @s sgp.particle.$(particle)_unlocked matches 1 run function sgp.cosmetics:particles/disable_type
$function sgp.cosmetics:update {effect:"$(particle)", effect_name:"$(particle_name)", color:"$(color)", type:"particle", type_text:"la Traînée de Particules"}
