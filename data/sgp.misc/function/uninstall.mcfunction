#> sgp.misc:uninstall
# 
# Remove the datapack's data

# ---------- Remove Objectives ----------
scoreboard objectives remove sgp.intensity.light_unlocked
scoreboard objectives remove sgp.intensity.medium_unlocked
scoreboard objectives remove sgp.intensity.heavy_unlocked
scoreboard objectives remove sgp.intensity.super_heavy_unlocked
scoreboard objectives remove sgp.particle.flame_crown_unlocked
scoreboard objectives remove sgp.particle.marine_unlocked
scoreboard objectives remove sgp.particle.ench_unlocked
scoreboard objectives remove sgp.particle.smoke_unlocked
scoreboard objectives remove sgp.particle.cloud_unlocked

scoreboard objectives remove sgp.kill.anvil_unlocked
scoreboard objectives remove sgp.kill.portal_unlocked
scoreboard objectives remove sgp.kill.explosion_unlocked
scoreboard objectives remove sgp.kill.witch_unlocked
scoreboard objectives remove sgp.kill.hurt_unlocked
scoreboard objectives remove sgp.kill.cloud_unlocked
scoreboard objectives remove sgp.kill.splash_unlocked
scoreboard objectives remove sgp.kill.firework_unlocked

scoreboard objectives remove sgp.pyromane_found
scoreboard objectives remove sgp.cancer_found
scoreboard objectives remove sgp.roi_found
scoreboard objectives remove sgp.pigeon_found
scoreboard objectives remove sgp.tank_found
scoreboard objectives remove sgp.enderman_found
scoreboard objectives remove sgp.alchimiste_found
scoreboard objectives remove sgp.poseidon_found
scoreboard objectives remove sgp.eclaireur_found
scoreboard objectives remove sgp.peaceful_found

scoreboard objectives remove sgp.cooldown_ability
scoreboard objectives remove sgp.duration_ability
scoreboard objectives remove sgp.trigger_repulsion
scoreboard objectives remove sgp.cooldown_water_trident
scoreboard objectives remove sgp.drop_any
execute as @e[tag=sgp.marker,name="abilities_shulker",type=marker] run setblock ~ ~ ~ air
scoreboard objectives remove sgp.current_attack_damage
scoreboard objectives remove sgp.pecking_timer
scoreboard objectives remove sgp.old_x
scoreboard objectives remove sgp.old_y
scoreboard objectives remove sgp.old_z
scoreboard objectives remove sgp.dx
scoreboard objectives remove sgp.dy
scoreboard objectives remove sgp.dz
scoreboard objectives remove sgp.id

execute as @e[type=marker,tag=sgp.marker,name="lieu"] run function sgp.misc:scoreboards/uninstallation_lieux with entity @s data

scoreboard objectives remove sgp.laby_fin
scoreboard objectives remove sgp.jump_hardest_done
scoreboard objectives remove sgp.jump_diff_2_done

scoreboard objectives remove sgp.uuid
scoreboard objectives remove sgp.killer
scoreboard objectives remove sgp.posx1
scoreboard objectives remove sgp.posy1
scoreboard objectives remove sgp.posz1
scoreboard objectives remove sgp.posx
scoreboard objectives remove sgp.posy
scoreboard objectives remove sgp.posz
scoreboard objectives remove sgp.reset_tags
scoreboard objectives remove sgp.kit_id
scoreboard objectives remove sgp.kit_prefix_set

scoreboard objectives remove sgp.death_effect
scoreboard objectives remove sgp.death_reset_tags
scoreboard objectives remove sgp.streak_reset
scoreboard objectives remove sgp.morts

scoreboard objectives remove sgp.kd 
scoreboard objectives remove sgp.plus_grande_streak
scoreboard objectives remove sgp.kills

scoreboard objectives remove sgp.kills_give_1
scoreboard objectives remove sgp.kills_give_2
scoreboard objectives remove sgp.kills_give_3
scoreboard objectives remove sgp.streak_en_cours
scoreboard objectives remove sgp.last_kill_count

scoreboard objectives remove sgp.devenir_pigeon
scoreboard objectives remove sgp.devenir_chasseur
scoreboard objectives remove sgp.devenir_roi_rouge
scoreboard objectives remove sgp.devenir_roi_bleu

scoreboard objectives remove sgp.liberer_oies
scoreboard objectives remove sgp.liberer_poules
scoreboard objectives remove sgp.liberer_canards

scoreboard objectives remove sgp.temps_cabane_pco
scoreboard objectives remove sgp.temps_cabane_pco_secondes
scoreboard objectives remove sgp.en_cage

scoreboard objectives remove sgp.link_teams

scoreboard objectives remove sgp.reflexes_joueur
scoreboard objectives remove sgp.share_item

scoreboard objectives remove sgp.teleporteur
scoreboard objectives remove sgp.dummy
scoreboard objectives remove sgp.timer

scoreboard objectives remove sgp.lieu_count




# ---------- Remove teams ----------
team remove sgp.Defenseur

team remove sgp.Attaquant

team remove sgp.rouge

team remove sgp.bleue

team remove sgp.Chasseurs_pigeon

team remove sgp.Pigeons

team remove sgp.Oie

team remove sgp.Poule

team remove sgp.Canard

team remove sgp.PGSEC

team remove sgp.Illusion


# Misc
bossbar remove sgp:lgp
kill @e[tag=sgp.predictor,type=marker]


# ---------- Clear Schedules ----------

schedule clear sgp.misc:scoreboards/cycle_and_clearlag

schedule clear sgp.misc:bossbar/cycle_color

schedule clear sgp.misc:bossbar/cycle_name

# ---------- Remove Storages -----------

data remove storage sgp:data majeurs
data remove storage sgp:data mineurs
data remove storage sgp.text prefix