# ---------- Create Objectives ----------
scoreboard objectives add veut_light trigger
scoreboard objectives add veut_medium trigger
scoreboard objectives add veut_heavy trigger
scoreboard objectives add veut_super_heavy trigger
scoreboard objectives add veut_flame_crown trigger
scoreboard objectives add veut_marine trigger
scoreboard objectives add veut_ench trigger
scoreboard objectives add veut_smoke trigger
scoreboard objectives add veut_cloud trigger
scoreboard objectives add veut_desactiver trigger
scoreboard objectives add light_particle_unlocked dummy
scoreboard objectives add medium_particle_unlocked dummy
scoreboard objectives add heavy_particle_unlocked dummy
scoreboard objectives add super_heavy_particle_unlocked dummy
scoreboard objectives add flame_crown_particle_unlocked dummy
scoreboard objectives add marine_particle_unlocked dummy
scoreboard objectives add ench_particle_unlocked dummy
scoreboard objectives add smoke_particle_unlocked dummy
scoreboard objectives add cloud_particle_unlocked dummy

scoreboard objectives add veut_kill_disabled trigger
scoreboard objectives add veut_kill_anvil trigger
scoreboard objectives add veut_kill_portal trigger
scoreboard objectives add veut_kill_explosion trigger
scoreboard objectives add veut_kill_witch trigger
scoreboard objectives add veut_kill_hurt trigger
scoreboard objectives add veut_kill_cloud trigger
scoreboard objectives add veut_kill_splash trigger
scoreboard objectives add veut_kill_firework trigger
scoreboard objectives add veut_kill_random trigger
scoreboard objectives add anvil_kill_unlocked dummy
scoreboard objectives add portal_kill_unlocked dummy
scoreboard objectives add explosion_kill_unlocked dummy
scoreboard objectives add witch_kill_unlocked dummy
scoreboard objectives add hurt_kill_unlocked dummy
scoreboard objectives add cloud_kill_unlocked dummy
scoreboard objectives add splash_kill_unlocked dummy
scoreboard objectives add firework_kill_unlocked dummy
scoreboard objectives add random_kill_unlocked dummy

scoreboard objectives add veut_alchimiste trigger
scoreboard objectives add veut_archer trigger
scoreboard objectives add veut_cancer trigger
scoreboard objectives add veut_combattant trigger
scoreboard objectives add veut_eclaireur trigger
scoreboard objectives add veut_enderman trigger
scoreboard objectives add veut_pigeon trigger
scoreboard objectives add veut_poseidon trigger
scoreboard objectives add veut_pyromane trigger
scoreboard objectives add veut_random trigger
scoreboard objectives add veut_roi trigger
scoreboard objectives add veut_tank trigger
scoreboard objectives add veut_vindicateur trigger
scoreboard objectives add alchimiste_found trigger
scoreboard objectives add archer_found trigger
scoreboard objectives add cancer_found trigger
scoreboard objectives add combattant_found trigger
scoreboard objectives add eclaireur_found trigger
scoreboard objectives add enderman_found trigger
scoreboard objectives add pigeon_found trigger
scoreboard objectives add poseidon_found trigger
scoreboard objectives add pyromane_found trigger
scoreboard objectives add roi_found trigger
scoreboard objectives add tank_found trigger
scoreboard objectives add vindicateur_found trigger

scoreboard objectives add spawn_1 trigger
scoreboard objectives add spawn_2 trigger
scoreboard objectives add spawn_3 trigger
scoreboard objectives add spawn_4 trigger
scoreboard objectives add spawn_5 trigger
scoreboard objectives add spawn_6 trigger
scoreboard objectives add spawn_7 trigger
scoreboard objectives add spawn_8 trigger
scoreboard objectives add spawn_9 trigger
scoreboard objectives add spawn_10 trigger
scoreboard objectives add spawn_11 trigger
scoreboard objectives add spawn_random trigger

scoreboard objectives add pyromane_found trigger
scoreboard objectives add cancer_found trigger
scoreboard objectives add roi_found trigger
scoreboard objectives add pigeon_found trigger
scoreboard objectives add tank_found trigger
scoreboard objectives add enderman_found trigger
scoreboard objectives add alchimiste_found trigger
scoreboard objectives add poseidon_found trigger
scoreboard objectives add eclaireur_found trigger

scoreboard objectives add lieu_autel dummy
scoreboard objectives add lieu_bunker dummy
scoreboard objectives add lieu_chercheurDevantLeternel dummy
scoreboard objectives add lieu_dedale dummy
scoreboard objectives add lieu_fun dummy
scoreboard objectives add lieu_gallerie dummy
scoreboard objectives add lieu_garde dummy
scoreboard objectives add lieu_grandeSalle dummy
scoreboard objectives add lieu_grange dummy
scoreboard objectives add lieu_kotl dummy
scoreboard objectives add lieu_laby dummy
scoreboard objectives add lieu_lave dummy
scoreboard objectives add lieu_machicoulis dummy
scoreboard objectives add lieu_moules dummy
scoreboard objectives add lieu_observatoire dummy
scoreboard objectives add lieu_pavillon dummy
scoreboard objectives add lieu_pigeonnier dummy
scoreboard objectives add lieu_pyramide dummy
scoreboard objectives add lieu_repos dummy
scoreboard objectives add lieu_reunion dummy
scoreboard objectives add lieu_snek dummy
scoreboard objectives add lieu_sousToit dummy
scoreboard objectives add lieu_sumo dummy
scoreboard objectives add lieu_taijitu dummy
scoreboard objectives add lieu_temple dummy
scoreboard objectives add lieu_toit dummy
scoreboard objectives add lieu_vallons dummy
scoreboard objectives add lieu_zoneNoire dummy
scoreboard objectives add lieu_maison dummy
scoreboard objectives add lieu_abri dummy
scoreboard objectives add lieu_piliers dummy
scoreboard objectives add lieu_jumpEst dummy
scoreboard objectives add lieu_jumpOuest dummy

scoreboard objectives add laby_fin trigger
scoreboard objectives add jump_hardest_done trigger
scoreboard objectives add jump_diff_2_done trigger

scoreboard objectives add UUID dummy
scoreboard objectives add killer dummy
scoreboard objectives add posx1 dummy
scoreboard objectives add posy1 dummy
scoreboard objectives add posz1 dummy
scoreboard objectives add posx dummy
scoreboard objectives add posy dummy
scoreboard objectives add posz dummy
scoreboard objectives add reset_tags dummy
scoreboard objectives add kit_id dummy
scoreboard objectives add kitPrefixSet dummy

scoreboard objectives add death_effect deathCount
scoreboard objectives add death_reset_tags deathCount
scoreboard objectives add streak_reset deathCount

scoreboard objectives add kd dummy {"bold":true,"color":"dark_green","text":"Kills/Deaths (en %)"}
scoreboard objectives add plus_grande_streak dummy {"bold":true,"color":"dark_aqua","text":"Plus grande streak"}
scoreboard objectives add kills playerKillCount {"bold":true,"color":"dark_red","text":"Kills au PvP"}

scoreboard objectives add kills_give_1 playerKillCount
scoreboard objectives add kills_give_2 playerKillCount
scoreboard objectives add kills_give_3 playerKillCount
scoreboard objectives add streak_en_cours minecraft.custom:minecraft.player_kills

scoreboard objectives add entre_cosm trigger
scoreboard objectives add sort_cosm trigger
scoreboard objectives add kits_vers_spawn trigger
scoreboard objectives add sort_kits trigger
scoreboard objectives add entre_kits trigger
scoreboard objectives add spawn_vers_kits trigger

scoreboard objectives add devenir_pigeon trigger
scoreboard objectives add devenir_chasseur trigger
scoreboard objectives add devenir_roi_rouge trigger
scoreboard objectives add devenir_roi_bleu trigger

scoreboard objectives add liberer_oies trigger
scoreboard objectives add liberer_poules trigger
scoreboard objectives add liberer_canards trigger

scoreboard objectives add temps_cabane_pco dummy
scoreboard objectives add temps_cabane_pco_secondes dummy
scoreboard objectives add en_cage dummy

scoreboard objectives add reflexes_joueur trigger

scoreboard objectives add teleporteur dummy
scoreboard objectives add dummy dummy
scoreboard objectives add timer dummy



# ---------- Initialize values ----------
scoreboard players set #ench_particle dummy 0
scoreboard players set 0 dummy 0
scoreboard players set 1 dummy 1
scoreboard players set 7 dummy 7
scoreboard players set 10 dummy 10
scoreboard players set 16 dummy 16
scoreboard players set 29 dummy 29
scoreboard players set 37 dummy 37
scoreboard players set 50 dummy 50
scoreboard players set 100 dummy 100
scoreboard players set 300 dummy 300
scoreboard players set #even_tick dummy 0
scoreboard players set #128_ticks_clock dummy 0
scoreboard players set #bossbar_color dummy 0
scoreboard players set #bossbar_name dummy 0
scoreboard players set #scoreboard_and_clearlag dummy 0

scoreboard players set #confines_ticks timer 0
scoreboard players set #confines_secondes timer 0
scoreboard players set #confines_minutes timer 0



# ---------- Create teams ----------
team add Defenseur "Défenseur"
team modify Defenseur collisionRule never
team modify Defenseur color blue
team modify Defenseur friendlyFire false

team add Attaquant
team modify Attaquant collisionRule never
team modify Attaquant color red
team modify Attaquant friendlyFire false
team modify Attaquant nametagVisibility hideForOtherTeams

team add rouge
team modify rouge collisionRule never
team modify rouge color dark_red
team modify rouge friendlyFire false
team modify rouge nametagVisibility hideForOtherTeams

team add bleue
team modify bleue collisionRule never
team modify bleue color dark_blue
team modify bleue friendlyFire false
team modify bleue nametagVisibility hideForOtherTeams

team add Chasseurs_pigeon "Chasseurs"
team modify Chasseurs_pigeon collisionRule never
team modify Chasseurs_pigeon color dark_green
team modify Chasseurs_pigeon friendlyFire false

team add Pigeons
team modify Pigeons collisionRule never
team modify Pigeons color gray
team modify Pigeons friendlyFire false

team add Oie
team modify Oie collisionRule never
team modify Oie color yellow
team modify Oie friendlyFire false

team add Poule
team modify Poule collisionRule never
team modify Poule color red
team modify Poule friendlyFire false

team add Canard
team modify Canard collisionRule never
team modify Canard color green
team modify Canard friendlyFire false

team add PGSEC
team modify PGSEC collisionRule never
team modify PGSEC color gold



# ---------- Run Functions ----------
function mineurs:lgc_init

schedule clear world:cycle_scoreboards_and_clearlag
function world:cycle_scoreboards_and_clearlag


schedule clear world:bossbar_cycle_color
function world:bossbar_cycle_color


schedule clear world:bossbar_cycle_name
function world:bossbar_cycle_name

