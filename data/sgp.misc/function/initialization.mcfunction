#> sgp.misc:initialization
# 
# Create the necessary objectives, initialize values, create teams,...

# ---------- Create Objectives ----------
scoreboard objectives add sgp.veut_light trigger
scoreboard objectives add sgp.veut_medium trigger
scoreboard objectives add sgp.veut_heavy trigger
scoreboard objectives add sgp.veut_super_heavy trigger
scoreboard objectives add sgp.veut_flame_crown trigger
scoreboard objectives add sgp.veut_marine trigger
scoreboard objectives add sgp.veut_ench trigger
scoreboard objectives add sgp.veut_smoke trigger
scoreboard objectives add sgp.veut_cloud trigger
scoreboard objectives add sgp.veut_desactiver trigger
scoreboard objectives add sgp.reward trigger
scoreboard objectives add sgp.light_particle_unlocked dummy
scoreboard objectives add sgp.medium_particle_unlocked dummy
scoreboard objectives add sgp.heavy_particle_unlocked dummy
scoreboard objectives add sgp.super_heavy_particle_unlocked dummy
scoreboard objectives add sgp.flame_crown_particle_unlocked dummy
scoreboard objectives add sgp.marine_particle_unlocked dummy
scoreboard objectives add sgp.ench_particle_unlocked dummy
scoreboard objectives add sgp.smoke_particle_unlocked dummy
scoreboard objectives add sgp.cloud_particle_unlocked dummy
scoreboard objectives add sgp.link_teams dummy

scoreboard objectives add sgp.veut_kill_disabled trigger
scoreboard objectives add sgp.veut_kill_anvil trigger
scoreboard objectives add sgp.veut_kill_portal trigger
scoreboard objectives add sgp.veut_kill_explosion trigger
scoreboard objectives add sgp.veut_kill_witch trigger
scoreboard objectives add sgp.veut_kill_hurt trigger
scoreboard objectives add sgp.veut_kill_cloud trigger
scoreboard objectives add sgp.veut_kill_splash trigger
scoreboard objectives add sgp.veut_kill_firework trigger
scoreboard objectives add sgp.veut_kill_random trigger
scoreboard objectives add sgp.anvil_kill_unlocked dummy
scoreboard objectives add sgp.portal_kill_unlocked dummy
scoreboard objectives add sgp.explosion_kill_unlocked dummy
scoreboard objectives add sgp.witch_kill_unlocked dummy
scoreboard objectives add sgp.hurt_kill_unlocked dummy
scoreboard objectives add sgp.cloud_kill_unlocked dummy
scoreboard objectives add sgp.splash_kill_unlocked dummy
scoreboard objectives add sgp.firework_kill_unlocked dummy
scoreboard objectives add sgp.disabled_kill_unlocked dummy

scoreboard objectives add sgp.veut_alchimiste trigger
scoreboard objectives add sgp.veut_archer trigger
scoreboard objectives add sgp.veut_cancer trigger
scoreboard objectives add sgp.veut_combattant trigger
scoreboard objectives add sgp.veut_eclaireur trigger
scoreboard objectives add sgp.veut_enderman trigger
scoreboard objectives add sgp.veut_pigeon trigger
scoreboard objectives add sgp.veut_poseidon trigger
scoreboard objectives add sgp.veut_pyromane trigger
scoreboard objectives add sgp.veut_random trigger
scoreboard objectives add sgp.veut_roi trigger
scoreboard objectives add sgp.veut_tank trigger
scoreboard objectives add sgp.veut_vindicateur trigger
scoreboard objectives add sgp.veut_peaceful trigger
scoreboard objectives add sgp.pyromane_found trigger
scoreboard objectives add sgp.cancer_found trigger
scoreboard objectives add sgp.roi_found trigger
scoreboard objectives add sgp.pigeon_found trigger
scoreboard objectives add sgp.tank_found trigger
scoreboard objectives add sgp.enderman_found trigger
scoreboard objectives add sgp.alchimiste_found trigger
scoreboard objectives add sgp.poseidon_found trigger
scoreboard objectives add sgp.eclaireur_found trigger

execute as @e[type=marker,tag=sgp.marker,name="lieu"] run function sgp.misc:scoreboards/initialization_lieux with entity @s data

execute as @e[type=marker,tag=sgp.marker,name="spawn"] run function sgp.misc:scoreboards/initialization_spawns with entity @s data
scoreboard objectives add sgp.spawn_random trigger

scoreboard objectives add sgp.laby_fin trigger
scoreboard objectives add sgp.jump_hardest_done trigger
scoreboard objectives add sgp.jump_diff_2_done trigger

scoreboard objectives add sgp.uuid dummy
scoreboard objectives add sgp.killer dummy
scoreboard objectives add sgp.posx1 dummy
scoreboard objectives add sgp.posy1 dummy
scoreboard objectives add sgp.posz1 dummy
scoreboard objectives add sgp.posx dummy
scoreboard objectives add sgp.posy dummy
scoreboard objectives add sgp.posz dummy
scoreboard objectives add sgp.reset_tags dummy
scoreboard objectives add sgp.kit_id dummy
scoreboard objectives add sgp.kit_prefix_set dummy

scoreboard objectives add sgp.death_effect deathCount
scoreboard objectives add sgp.death_reset_tags deathCount
scoreboard objectives add sgp.streak_reset deathCount
scoreboard objectives add sgp.morts deathCount

scoreboard objectives add sgp.kd dummy {"bold":true,"color":"dark_green","text":"Kills/Deaths (en %)"}
scoreboard objectives add sgp.plus_grande_streak dummy {"bold":true,"color":"dark_aqua","text":"Plus grande streak"}
scoreboard objectives add sgp.kills playerKillCount {"bold":true,"color":"dark_red","text":"Kills au PvP"}

scoreboard objectives add sgp.kills_give_1 playerKillCount
scoreboard objectives add sgp.kills_give_2 playerKillCount
scoreboard objectives add sgp.kills_give_3 playerKillCount
scoreboard objectives add sgp.streak_en_cours minecraft.custom:minecraft.player_kills
scoreboard objectives add sgp.last_kill_count playerKillCount

scoreboard objectives add sgp.entre_cosm trigger
scoreboard objectives add sgp.sort_cosm trigger
scoreboard objectives add sgp.kits_vers_spawn trigger
scoreboard objectives add sgp.sort_kits trigger
scoreboard objectives add sgp.entre_kits trigger
scoreboard objectives add sgp.spawn_vers_kits trigger

scoreboard objectives add sgp.devenir_pigeon trigger
scoreboard objectives add sgp.devenir_chasseur trigger
scoreboard objectives add sgp.devenir_roi_rouge trigger
scoreboard objectives add sgp.devenir_roi_bleu trigger

scoreboard objectives add sgp.liberer_oies trigger
scoreboard objectives add sgp.liberer_poules trigger
scoreboard objectives add sgp.liberer_canards trigger

scoreboard objectives add sgp.temps_cabane_pco dummy
scoreboard objectives add sgp.temps_cabane_pco_secondes dummy
scoreboard objectives add sgp.en_cage dummy

scoreboard objectives add sgp.reflexes_joueur trigger

scoreboard objectives add sgp.teleporteur dummy
scoreboard objectives add sgp.dummy dummy
scoreboard objectives add sgp.timer dummy

scoreboard objectives add sgp.sneak_particle minecraft.custom:minecraft.sneak_time

scoreboard objectives add sgp.lieu_count dummy



# ---------- Initialize values ----------
scoreboard players set #ench_particle sgp.dummy 0
scoreboard players set #flame_crown_particle sgp.dummy 0
scoreboard players set 0 sgp.dummy 0
scoreboard players set 3 sgp.dummy 3
scoreboard players set 1 sgp.dummy 1
scoreboard players set 7 sgp.dummy 7
scoreboard players set 10 sgp.dummy 10
scoreboard players set 16 sgp.dummy 16
scoreboard players set 29 sgp.dummy 29
scoreboard players set 37 sgp.dummy 37
scoreboard players set 49 sgp.dummy 49
scoreboard players set 50 sgp.dummy 50
scoreboard players set 100 sgp.dummy 100
scoreboard players set 300 sgp.dummy 300
scoreboard players set #even_tick sgp.dummy 0
scoreboard players set #20_ticks sgp.dummy 0
scoreboard players set #128_ticks_clock sgp.dummy 0
scoreboard players set #52_ticks_clock sgp.dummy 0
scoreboard players set #bossbar_color sgp.dummy 0
scoreboard players set #bossbar_name sgp.dummy 0
scoreboard players set #scoreboard_and_clearlag sgp.dummy 0

scoreboard players set #confines_ticks sgp.timer 0
scoreboard players set #confines_secondes sgp.timer 0

scoreboard players set #hide_and_seek_max_rounds sgp.dummy 3
scoreboard players set #protect_max_rounds sgp.dummy 3
scoreboard players set #pco_max_rounds sgp.dummy 3

execute store result score #nbr_lieu sgp.lieu_count if entity @e[type=marker,tag=sgp.marker,name="lieu"]



# ---------- Create teams ----------
team add sgp.Defenseur "Défenseur"
team modify sgp.Defenseur collisionRule never
team modify sgp.Defenseur color blue
team modify sgp.Defenseur friendlyFire false

team add sgp.Attaquant
team modify sgp.Attaquant collisionRule never
team modify sgp.Attaquant color red
team modify sgp.Attaquant friendlyFire false
team modify sgp.Attaquant nametagVisibility hideForOtherTeams

team add sgp.rouge
team modify sgp.rouge collisionRule never
team modify sgp.rouge color dark_red
team modify sgp.rouge friendlyFire false
team modify sgp.rouge nametagVisibility hideForOtherTeams

team add sgp.bleue
team modify sgp.bleue collisionRule never
team modify sgp.bleue color dark_blue
team modify sgp.bleue friendlyFire false
team modify sgp.bleue nametagVisibility hideForOtherTeams

team add sgp.Chasseurs_pigeon "Chasseurs"
team modify sgp.Chasseurs_pigeon collisionRule never
team modify sgp.Chasseurs_pigeon color dark_green
team modify sgp.Chasseurs_pigeon friendlyFire false

team add sgp.Pigeons
team modify sgp.Pigeons collisionRule never
team modify sgp.Pigeons color gray
team modify sgp.Pigeons friendlyFire false

team add sgp.Oie
team modify sgp.Oie collisionRule never
team modify sgp.Oie color yellow
team modify sgp.Oie friendlyFire false

team add sgp.Poule
team modify sgp.Poule collisionRule never
team modify sgp.Poule color red
team modify sgp.Poule friendlyFire false

team add sgp.Canard
team modify sgp.Canard collisionRule never
team modify sgp.Canard color green
team modify sgp.Canard friendlyFire false

team add sgp.PGSEC
team modify sgp.PGSEC collisionRule never
team modify sgp.PGSEC color gold

team add sgp.hider "Volaille"
team modify sgp.hider collisionRule pushOtherTeams
team modify sgp.hider nametagVisibility never
team modify sgp.hider color yellow

team add sgp.seeker "Chasseurs"
team modify sgp.seeker friendlyFire false
team modify sgp.seeker color dark_green

# Misc
bossbar add sgp:lgp "a"



# ---------- Run Functions ----------

schedule clear sgp.misc:scoreboards/cycle_and_clearlag
function sgp.misc:scoreboards/cycle_and_clearlag


schedule clear sgp.misc:bossbar/cycle_color
function sgp.misc:bossbar/cycle_color


schedule clear sgp.misc:bossbar/cycle_name
function sgp.misc:bossbar/cycle_name



# ---------- Initialize Storages ----------

data merge storage sgp:lootdrop {tag: [{id: "minecraft:bow",tag: {display: {Lore: ["{\"text\":\"------------\",\"color\":\"#C0C0C0\",\"italic\":\"false\"}","{\"text\":\"���� Puissance I\",\"color\":\"dark_red\",\"italic\":\"false\"}","{\"text\":\"���� Flamme\",\"color\":\"#FF8C00\",\"italic\":\"false\"}","{\"text\":\"���� Puissance II\",\"color\":\"dark_red\",\"italic\":\"false\"}","{\"text\":\"⬱ Recul I\",\"color\":\"#6F4E37\",\"italic\":\"false\"}","{\"text\":\"∞ Infinité\",\"color\":\"#E5E4E2\",\"italic\":\"false\"}"]},Enchantments: [{id: "minecraft:flame",lvl: 1s},{id: "minecraft:power",lvl: 1s},{id: "minecraft:power",lvl: 2s},{id: "minecraft:punch",lvl: 1s},{id: "minecraft:infinity",lvl: 1s}]}},{id: "minecraft:iron_sword",tag: {display: {Lore: ["{\"text\":\"⚔ Tranchant I\",\"color\":\"dark_red\",\"italic\":\"false\"}","{\"text\":\"���� Flamme I\",\"color\":\"#FF8C00\",\"italic\":\"false\"}","{\"text\":\"⬱ Recul I\",\"color\":\"#6F4E37\",\"italic\":\"false\"}"]},Enchantments: [{id: "sharpness",lvl: 1},{id: "fire_aspect",lvl: 1},{id: "knockback",lvl: 1}]},count: 1b},{id: "minecraft:iron_chestplate",tag: {display: {Lore: ["{\"text\":\"���� Protection I\",\"color\":\"dark_aqua\",\"italic\":\"false\"}","{\"text\":\"➹ Protection I\",\"color\":\"dark_blue\",\"italic\":\"false\"}","{\"text\":\"���� Protection II\",\"color\":\"dark_aqua\",\"italic\":\"false\"}","{\"text\":\"➹ Protection II\",\"color\":\"dark_blue\",\"italic\":\"false\"}"]},Enchantments: [{id: "minecraft:protection",lvl: 1s},{id: "minecraft:projectile_protection",lvl: 1s},{id: "minecraft:protection",lvl: 2s},{id: "minecraft:projectile_protection",lvl: 2s}]}}]}

execute unless data storage sgp:kill_counter HandItems run data merge storage sgp:kill_counter {HandItems: [{count: 1b,tag: {KillArray: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],KillUpdates: [],provKillTueur: 4,increment: 20,KillArrayCopy: [],provKillUpdate: 49,provKillVictime: 1}},{}]}

data merge storage sgp:data {majeurs:{pco:{event:"pco",text:"Poule Canard Oie"},ptk:{event:"ptk",text:"Protéger le Roi"},hide_and_seek:{event:"hide_and_seek",text:"Cache-cache",end:{seeker:"Que la chasse à la volaille commence !",hider:"Les chasseurs arrivent, gare à vos fesses !",become_seeker:"Vous pouvez chasser de la volaille à votre tour !"}}},"arene":{base:"2419 198 2133",dx:140,dz:73,dy:73},mineurs:{bounty:{base:"2419 198 2133",dx:140,dz:73,dy:73}}}

data merge storage sgp:kits {eclaireur:{kit: eclaireur, kit_color:aqua}, enderman:{kit:enderman, kit_color:dark_purple}, pigeon:{kit:pigeon, kit_color:dark_gray}, poseidon:{kit:poseidon, kit_color:dark_aqua}, pyromane:{kit:pyromane, kit_color:gold}, roi:{kit:roi, kit_color:yellow}, tank:{kit:tank, kit_color:dark_blue}, cancer:{kit:cancer, kit_color:dark_red}, alchimiste:{kit:alchimiste, kit_color:light_purple}}

data modify storage sgp.text prefix set value {"text":"[", "color":"gray", "extra":[{"text":"SGP", "color":"gold"}, {"text":"] "}]}