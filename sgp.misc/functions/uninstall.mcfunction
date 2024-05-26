# ---------- Remove Objectives ----------
scoreboard objectives remove sgp.veut_light
scoreboard objectives remove sgp.veut_medium
scoreboard objectives remove sgp.veut_heavy
scoreboard objectives remove sgp.veut_super_heavy
scoreboard objectives remove sgp.veut_flame_crown
scoreboard objectives remove sgp.veut_marine
scoreboard objectives remove sgp.veut_ench
scoreboard objectives remove sgp.veut_smoke
scoreboard objectives remove sgp.veut_cloud
scoreboard objectives remove sgp.veut_desactiver

scoreboard objectives remove sgp.veut_kill_disabled
scoreboard objectives remove sgp.veut_kill_anvil
scoreboard objectives remove sgp.veut_kill_portal
scoreboard objectives remove sgp.veut_kill_explosion
scoreboard objectives remove sgp.veut_kill_witch
scoreboard objectives remove sgp.veut_kill_hurt
scoreboard objectives remove sgp.veut_kill_cloud
scoreboard objectives remove sgp.veut_kill_splash
scoreboard objectives remove sgp.veut_kill_firework
scoreboard objectives remove sgp.veut_kill_random
scoreboard objectives remove sgp.anvil_kill_unlocked
scoreboard objectives remove sgp.portal_kill_unlocked
scoreboard objectives remove sgp.explosion_kill_unlocked
scoreboard objectives remove sgp.witch_kill_unlocked
scoreboard objectives remove sgp.hurt_kill_unlocked
scoreboard objectives remove sgp.cloud_kill_unlocked
scoreboard objectives remove sgp.splash_kill_unlocked
scoreboard objectives remove sgp.firework_kill_unlocked

scoreboard objectives remove sgp.veut_alchimiste
scoreboard objectives remove sgp.veut_archer
scoreboard objectives remove sgp.veut_cancer
scoreboard objectives remove sgp.veut_combattant
scoreboard objectives remove sgp.veut_eclaireur
scoreboard objectives remove sgp.veut_enderman
scoreboard objectives remove sgp.veut_pigeon
scoreboard objectives remove sgp.veut_poseidon
scoreboard objectives remove sgp.veut_pyromane
scoreboard objectives remove sgp.veut_random
scoreboard objectives remove sgp.veut_roi
scoreboard objectives remove sgp.veut_tank
scoreboard objectives remove sgp.veut_vindicateur
scoreboard objectives remove sgp.pyromane_found
scoreboard objectives remove sgp.cancer_found
scoreboard objectives remove sgp.roi_found
scoreboard objectives remove sgp.pigeon_found
scoreboard objectives remove sgp.tank_found
scoreboard objectives remove sgp.enderman_found
scoreboard objectives remove sgp.alchimiste_found
scoreboard objectives remove sgp.poseidon_found
scoreboard objectives remove sgp.eclaireur_found

scoreboard objectives remove sgp.spawn_1
scoreboard objectives remove sgp.spawn_2
scoreboard objectives remove sgp.spawn_3
scoreboard objectives remove sgp.spawn_4
scoreboard objectives remove sgp.spawn_5
scoreboard objectives remove sgp.spawn_6
scoreboard objectives remove sgp.spawn_7
scoreboard objectives remove sgp.spawn_8
scoreboard objectives remove sgp.spawn_9
scoreboard objectives remove sgp.spawn_10
scoreboard objectives remove sgp.spawn_11
scoreboard objectives remove sgp.spawn_random

scoreboard objectives remove sgp.lieu_autel
scoreboard objectives remove sgp.lieu_bunker
scoreboard objectives remove sgp.lieu_chercheurDevantLeternel
scoreboard objectives remove sgp.lieu_dedale
scoreboard objectives remove sgp.lieu_fun
scoreboard objectives remove sgp.lieu_galerie
scoreboard objectives remove sgp.lieu_garde
scoreboard objectives remove sgp.lieu_grandeSalle
scoreboard objectives remove sgp.lieu_grange
scoreboard objectives remove sgp.lieu_kotl
scoreboard objectives remove sgp.lieu_laby
scoreboard objectives remove sgp.lieu_lave
scoreboard objectives remove sgp.lieu_machicoulis
scoreboard objectives remove sgp.lieu_moules
scoreboard objectives remove sgp.lieu_observatoire
scoreboard objectives remove sgp.lieu_pavillon
scoreboard objectives remove sgp.lieu_pigeonnier
scoreboard objectives remove sgp.lieu_pyramide
scoreboard objectives remove sgp.lieu_dortoir
scoreboard objectives remove sgp.lieu_reunion
scoreboard objectives remove sgp.lieu_snek
scoreboard objectives remove sgp.lieu_sousToit
scoreboard objectives remove sgp.lieu_sumo
scoreboard objectives remove sgp.lieu_taijitu
scoreboard objectives remove sgp.lieu_temple
scoreboard objectives remove sgp.lieu_toit
scoreboard objectives remove sgp.lieu_vallons
scoreboard objectives remove sgp.lieu_zoneNoire
scoreboard objectives remove sgp.lieu_maison
scoreboard objectives remove sgp.lieu_abri
scoreboard objectives remove sgp.lieu_piliers
scoreboard objectives remove sgp.lieu_jumpEst
scoreboard objectives remove sgp.lieu_jumpOuest

scoreboard objectives remove sgp.laby_fin
scoreboard objectives remove sgp.jump_hardest_done
scoreboard objectives remove sgp.jump_diff_2_done

scoreboard objectives remove sgp.UUID
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

scoreboard objectives remove sgp.kd 
scoreboard objectives remove sgp.plus_grande_streak
scoreboard objectives remove sgp.kills

scoreboard objectives remove sgp.kills_give_1
scoreboard objectives remove sgp.kills_give_2
scoreboard objectives remove sgp.kills_give_3
scoreboard objectives remove sgp.streak_en_cours

scoreboard objectives remove sgp.entre_cosm
scoreboard objectives remove sgp.sort_cosm
scoreboard objectives remove sgp.kits_vers_spawn
scoreboard objectives remove sgp.sort_kits
scoreboard objectives remove sgp.entre_kits
scoreboard objectives remove sgp.spawn_vers_kits

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

scoreboard objectives remove sgp.reflexes_joueur

scoreboard objectives remove sgp.teleporteur
scoreboard objectives remove sgp.dummy
scoreboard objectives remove sgp.timer



# ---------- Remove teams ----------
team remove sgp.Defenseur

team remove sgp.Attaquant

team remove sgp.rouge

team remove sgp.bleue

team remove sgp.Chasseurs_pigeon

team remove sgp.Pigeons

team remove sgp.Oie

team remove Poule

team remove sgp.Canard

team remove sgp.PGSEC


# Misc
bossbar remove sgp:lgp


# ---------- Clear Schedules ----------

schedule clear sgp.misc:scoreboards/cycle_and_clearlag

schedule clear sgp.misc:bossbar/cycle_color

schedule clear sgp.misc:bossbar/cycle_name

