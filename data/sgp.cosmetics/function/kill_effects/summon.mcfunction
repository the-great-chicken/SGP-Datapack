#> sgp.cosmetics:kill_effects/summon
# 
# Checks what kill effect the killer has selected, and runs the appropriate function

execute if entity @s[tag=portal_kill] run function sgp.cosmetics:kill_effects/particle_and_sound {particle:"portal ~ ~0.5 ~ 0.1 0.1 0.1 0.6 500", sound:"block.portal.trigger"}
execute if entity @s[tag=anvil_kill] at @e[type=marker,tag=sgp.marker,name="death_reaper"] run function sgp.cosmetics:kill_effects/anvil
execute if entity @s[tag=explosion_kill] run function sgp.cosmetics:kill_effects/particle_and_sound {particle:"explosion_emitter ~ ~ ~ 0 0 0 1 1", sound:"entity.generic.explode"}
execute if entity @s[tag=cloud_kill] run function sgp.cosmetics:kill_effects/particle {particle:"cloud ~ ~1.5 ~ 0 0 0 0.6 250"}
execute if entity @s[tag=witch_kill] run function sgp.cosmetics:kill_effects/particle {particle:"witch ~ ~0.5 ~ 0 0.4 0 1 500"}
execute if entity @s[tag=hurt_kill] run function sgp.cosmetics:kill_effects/particle {particle:"damage_indicator ~ ~0.9 ~ 0 0 0 0.5 50"}
execute if entity @s[tag=firework_kill] at @e[type=marker,tag=sgp.marker,name="death_reaper"] run function sgp.cosmetics:kill_effects/firework
execute if entity @s[tag=splash_kill] run function sgp.cosmetics:kill_effects/particle_and_sound {particle:"splash ~ ~1 ~ 0.15 0.3 0.15 0 2000", sound:"entity.player.splash.high_speed"}