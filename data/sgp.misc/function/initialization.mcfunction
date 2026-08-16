#> sgp.misc:initialization
# 
# Create the necessary objectives, initialize values, create teams,...

# ---------- Create Objectives ----------
scoreboard objectives add sgp.intensity.light_unlocked dummy
scoreboard objectives add sgp.intensity.medium_unlocked dummy
scoreboard objectives add sgp.intensity.heavy_unlocked dummy
scoreboard objectives add sgp.intensity.super_heavy_unlocked dummy
scoreboard objectives add sgp.particle.flame_crown_unlocked dummy
scoreboard objectives add sgp.particle.marine_unlocked dummy
scoreboard objectives add sgp.particle.ench_unlocked dummy
scoreboard objectives add sgp.particle.smoke_unlocked dummy
scoreboard objectives add sgp.particle.cloud_unlocked dummy

scoreboard objectives add sgp.kill.anvil_unlocked dummy
scoreboard objectives add sgp.kill.portal_unlocked dummy
scoreboard objectives add sgp.kill.explosion_unlocked dummy
scoreboard objectives add sgp.kill.witch_unlocked dummy
scoreboard objectives add sgp.kill.hurt_unlocked dummy
scoreboard objectives add sgp.kill.cloud_unlocked dummy
scoreboard objectives add sgp.kill.splash_unlocked dummy
scoreboard objectives add sgp.kill.firework_unlocked dummy

scoreboard objectives add sgp.combattant_found trigger
scoreboard objectives add sgp.vindicateur_found trigger
scoreboard objectives add sgp.archer_found trigger
scoreboard objectives add sgp.pyromane_found trigger
scoreboard objectives add sgp.cancer_found trigger
scoreboard objectives add sgp.roi_found trigger
scoreboard objectives add sgp.pigeon_found trigger
scoreboard objectives add sgp.tank_found trigger
scoreboard objectives add sgp.enderman_found trigger
scoreboard objectives add sgp.alchimiste_found trigger
scoreboard objectives add sgp.poseidon_found trigger
scoreboard objectives add sgp.eclaireur_found trigger
scoreboard objectives add sgp.peaceful_found trigger

scoreboard objectives add sgp.cooldown_ability dummy
scoreboard objectives add sgp.duration_ability dummy
scoreboard objectives add sgp.trigger_repulsion dummy
scoreboard objectives add sgp.cooldown_water_trident dummy
scoreboard objectives add sgp.drop_any custom:drop
execute at @e[tag=sgp.marker,name="abilities_shulker",type=marker] run setblock ~ ~ ~ magenta_shulker_box
scoreboard objectives add sgp.current_attack_damage dummy
scoreboard objectives add sgp.pecking_timer dummy
scoreboard objectives add sgp.old_x dummy
scoreboard objectives add sgp.old_y dummy
scoreboard objectives add sgp.old_z dummy
scoreboard objectives add sgp.dx dummy
scoreboard objectives add sgp.dy dummy
scoreboard objectives add sgp.dz dummy
scoreboard objectives add sgp.id dummy

scoreboard objectives add sgp.ab.reward_1 dummy
scoreboard objectives add sgp.ab.reward_2 dummy
scoreboard objectives add sgp.ab.reward_3 dummy
scoreboard objectives add sgp.ab.reward_1_width dummy
scoreboard objectives add sgp.ab.reward_2_width dummy
scoreboard objectives add sgp.ab.reward_3_width dummy
scoreboard objectives add sgp.ab.location dummy
scoreboard objectives add sgp.ab.location_width dummy
scoreboard objectives add sgp.ab.location_inside dummy
scoreboard objectives add sgp.ab.hide_hider dummy
scoreboard objectives add sgp.ab.pco_cabane dummy
scoreboard objectives add sgp.ab.ability_cooldown dummy
scoreboard objectives add sgp.ab.ability_cooldown_max dummy
scoreboard objectives add sgp.ab.ability_cooldown_last_fill dummy
scoreboard objectives add sgp.ab.ability_cooldown_last_current dummy
scoreboard objectives add sgp.ab.hud_ability dummy
scoreboard objectives add sgp.ab.hud_ability_fill dummy
scoreboard objectives add sgp.ab.normal_width dummy
scoreboard objectives add sgp.ab.normal_count dummy
scoreboard objectives add sgp.ab.water_trident_cooldown dummy
scoreboard objectives add sgp.ab.water_trident_cooldown_max dummy
scoreboard objectives add sgp.ab.water_trident_cooldown_last_fill dummy
scoreboard objectives add sgp.ab.water_trident_cooldown_last_current dummy

execute as @e[type=marker,tag=sgp.marker,name="lieu"] run function sgp.misc:scoreboards/initialization_lieux with entity @s data

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

scoreboard objectives add sgp.kd dummy {bold:true,color:dark_green,text:"Kills/Deaths (en %)"}
scoreboard objectives add sgp.plus_grande_streak dummy {bold:true,color:dark_aqua,text:"Plus grande streak"}
scoreboard objectives add sgp.kills playerKillCount {bold:true,color:dark_red,text:"Kills au PvP"}

scoreboard objectives add sgp.kills_give_1 playerKillCount
scoreboard objectives add sgp.kills_give_2 playerKillCount
scoreboard objectives add sgp.kills_give_3 playerKillCount
scoreboard objectives add sgp.streak_en_cours minecraft.custom:minecraft.player_kills
scoreboard objectives add sgp.last_kill_count playerKillCount

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

scoreboard objectives add sgp.link_teams dummy

scoreboard objectives add sgp.reflexes_joueur trigger
scoreboard objectives add sgp.reward trigger
scoreboard objectives add sgp.share_item trigger

scoreboard objectives add sgp.teleporteur dummy
scoreboard objectives add sgp.dummy dummy
scoreboard objectives add sgp.timer dummy

scoreboard objectives add sgp.lieu_count dummy

scoreboard objectives add sgp.anim_timer dummy

scoreboard objectives add sgp.left_click_count dummy



# ---------- Initialize values ----------
scoreboard players set #ench_particle sgp.dummy 0
scoreboard players set #flame_crown_particle sgp.dummy 0

scoreboard players set -1 sgp.dummy -1
scoreboard players set 0 sgp.dummy 0
scoreboard players set 1 sgp.dummy 1
scoreboard players set 2 sgp.dummy 2
scoreboard players set 3 sgp.dummy 3
scoreboard players set 4 sgp.dummy 4
scoreboard players set 6 sgp.dummy 6
scoreboard players set 7 sgp.dummy 7
scoreboard players set 8 sgp.dummy 8
scoreboard players set 10 sgp.dummy 10
scoreboard players set 16 sgp.dummy 16
scoreboard players set 20 sgp.dummy 20
scoreboard players set 29 sgp.dummy 29
scoreboard players set 37 sgp.dummy 37
scoreboard players set 49 sgp.dummy 49
scoreboard players set 50 sgp.dummy 50
scoreboard players set 100 sgp.dummy 100
scoreboard players set 300 sgp.dummy 300
scoreboard players set 500 sgp.dummy 500
scoreboard players set 1000 sgp.dummy 1000
scoreboard players set 9000 sgp.dummy 9000

scoreboard players set #even_tick sgp.dummy 0
scoreboard players set #20_ticks sgp.dummy 0
scoreboard players set #128_ticks_clock sgp.dummy 0
scoreboard players set #52_ticks_clock sgp.dummy 0
scoreboard players set #bossbar_color sgp.dummy 0
scoreboard players set #bossbar_name sgp.dummy 0
scoreboard players set #scoreboard_and_clearlag sgp.dummy 0

scoreboard players set #confines_ticks sgp.timer 0
scoreboard players set #confines_secondes sgp.timer 0

scoreboard players add #mannequins_swing_enabled sgp.dummy 0
scoreboard players set #mannequin_update_time sgp.dummy 0

execute unless score #hide_and_seek_max_rounds sgp.dummy matches 0.. \
    run scoreboard players set #hide_and_seek_max_rounds sgp.dummy 3
execute unless score #protect_max_rounds sgp.dummy matches 0.. \
    run scoreboard players set #protect_max_rounds sgp.dummy 3
execute unless score #protect_max_rounds sgp.dummy matches 0.. \
    run scoreboard players set #pco_max_rounds sgp.dummy 3



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

team add sgp.Illusion
team modify sgp.Illusion collisionRule never

# ---------- Misc ----------

bossbar add sgp:lgp "a"
forceload add 0 0

time of sgp.mineurs:confinement_clock set 10000t
time of sgp.mineurs:confinement_clock pause

function sgp.kits:kit_tags/init_luckperms



# ---------- Run Functions ----------

schedule clear sgp.misc:scoreboards/cycle_and_clearlag
function sgp.misc:scoreboards/cycle_and_clearlag


schedule clear sgp.misc:bossbar/cycle_color
function sgp.misc:bossbar/cycle_color


schedule clear sgp.misc:bossbar/cycle_name
function sgp.misc:bossbar/cycle_name



# ---------- Initialize Storages ----------

execute unless data storage sgp:kill_counter KillArray run data merge storage sgp:kill_counter {KillArray: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],KillUpdates: [],provKillTueur: 4,increment: 20,KillArrayCopy: [],provKillUpdate: 49,provKillVictime: 1}

execute unless data storage sgp:data kits.ability_cooldowns run data merge storage sgp:data {kits:{ability_cooldowns:{ assassinate:{cooldown:400s,duration:100s}, bats:{cooldown:400s,duration:100s}, bigger:{cooldown:400s,duration:100s}, cleave:{cooldown:300s}, fangs:{cooldown:260s}, illusions:{cooldown:400s,duration:140s}, pecking:{cooldown:400s}, rays:{cooldown:400s,duration:100s}, repulsion:{cooldown:400s}, smoke_grenade:{cooldown:400s}, tnt:{cooldown:400s}, water_trident:{cooldown:160s}, splash:{cooldown:20s}}}}

data merge storage sgp:data {majeurs:{pco:{event:"pco",text:"Poule Canard Oie"},ptk:{event:"ptk",text:"Protéger le Roi"},hide_and_seek:{event:"hide_and_seek",text:"Cache-cache",end:{seeker:"Que la chasse à la volaille commence !",hider:"Les chasseurs arrivent, gare à vos fesses !",become_seeker:"Tu peux chasser de la volaille à votre tour !"}}},"mineurs":{}}

data merge storage sgp:kits {\
    kit_id_order:[{kit_path:pigeon},{kit_path:combattant},{kit_path:archer},{kit_path:vindicateur},{kit_path:pyromane},{kit_path:tank},{kit_path:roi},{kit_path:eclaireur},{kit_path:alchimiste},{kit_path:enderman},{kit_path:cancer},{kit_path:poseidon}], \
    eclaireur:{kit:eclaireur, kit_color:aqua, kit_name:"Éclaireur", kit_icon:""}, \
    enderman:{kit:enderman, kit_color:dark_purple, kit_name:Enderman, kit_icon:""}, \
    pigeon:{kit:pigeon, kit_color:dark_gray, kit_name:Pigeon, kit_icon:""}, \
    poseidon:{kit:poseidon, kit_color:dark_aqua, kit_name:"Poséidon", kit_icon:""}, \
    pyromane:{kit:pyromane, kit_color:gold, kit_name:Pyromane, kit_icon:""}, \
    roi:{kit:roi, kit_color:yellow, kit_name:Roi, kit_icon:""}, tank:{kit:tank, kit_color:dark_blue, kit_name:Tank, kit_icon:""}, \
    cancer:{kit:cancer, kit_color:dark_red, kit_name:Cancer, kit_icon:""}, \
    alchimiste:{kit:alchimiste, kit_color:light_purple, kit_name:Alchimiste, kit_icon:""}, \
    combattant:{kit:combattant, kit_color:white, kit_name:Combattant, kit_icon:""}, \
    archer:{kit:archer, kit_color:green, kit_name:Archer, kit_icon:""}, \
    vindicateur:{kit:vindicateur, kit_color:dark_green, kit_name:Vindicateur, kit_icon:""} \
    }

data modify storage sgp.text prefix set value {text:"[", color:gray, extra:[{text:"SGP", color:gold}, {text:"] "}]}

data modify storage sgp:data const.hex set value ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]



# ---------- Enable and init Diorama ----------

scoreboard players set #diorama_enabled sgp.dummy 0
execute if entity @e[tag=sgp.marker,name="playable_map_model",limit=1,type=marker] \
    run scoreboard players set #diorama_enabled sgp.dummy 1

execute if score #diorama_enabled sgp.dummy matches 1 \
    run function sgp.misc:diorama/init_markers

execute if score #diorama_enabled sgp.dummy matches 1 \
    as @e[tag=sgp.marker,name=playable_map_model,type=marker] at @s \
        run function sgp.misc:diorama/spawn_entities/clear_and_recreate \
            with entity @s data



# ---------- Init marker uuids ----------

data remove storage sgp:data markers_lists.lootdrop
execute as @e[tag=sgp.marker,name="Lootdrop",type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.lootdrop"}

data remove storage sgp:data markers_lists.location
execute as @e[tag=sgp.marker,name="lieu",type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.location"}
    
data remove storage sgp:data markers_lists.pvp_arena
execute as @e[tag=sgp.marker,name="pvp_arena",limit=1,type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.pvp_arena"}

data remove storage sgp:data markers_lists.teleporter
execute as @e[tag=sgp.marker,name="teleporter",type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.teleporter"}




# ---------- Actionbar HUD ----------

data modify storage dah:actbar default_separator set value {text:" | ", color:white, bold:true}
function dah.actbar_mixer:separator/reset_all

# HUD x-offset is the glyph start position relative to screen center.
# Negative values are allowed; use this with the width LUT to center any HUD glyph.
scoreboard players set #sgp.ab.hud_x sgp.dummy -9
scoreboard players set #sgp.ab.bar_length sgp.dummy 20
scoreboard players set #sgp.ab.space_limit sgp.dummy 768

scoreboard players set #sgp.ab.width.separator sgp.dummy 26
scoreboard players set #sgp.ab.width.water_trident sgp.dummy 120
scoreboard players set #sgp.ab.width.hide_hider sgp.dummy 344
scoreboard players set #sgp.ab.width.pco_cabane sgp.dummy 410

data modify storage sgp:data misc.actionbar.hud.space_positive set value [{key:"sgp.kits.offset.p.0"},{key:"sgp.kits.offset.p.1"},{key:"sgp.kits.offset.p.2"},{key:"sgp.kits.offset.p.3"},{key:"sgp.kits.offset.p.4"},{key:"sgp.kits.offset.p.5"},{key:"sgp.kits.offset.p.6"},{key:"sgp.kits.offset.p.7"},{key:"sgp.kits.offset.p.8"},{key:"sgp.kits.offset.p.9"},{key:"sgp.kits.offset.p.10"},{key:"sgp.kits.offset.p.11"},{key:"sgp.kits.offset.p.12"},{key:"sgp.kits.offset.p.13"},{key:"sgp.kits.offset.p.14"},{key:"sgp.kits.offset.p.15"},{key:"sgp.kits.offset.p.16"},{key:"sgp.kits.offset.p.17"},{key:"sgp.kits.offset.p.18"},{key:"sgp.kits.offset.p.19"},{key:"sgp.kits.offset.p.20"},{key:"sgp.kits.offset.p.21"},{key:"sgp.kits.offset.p.22"},{key:"sgp.kits.offset.p.23"},{key:"sgp.kits.offset.p.24"},{key:"sgp.kits.offset.p.25"},{key:"sgp.kits.offset.p.26"},{key:"sgp.kits.offset.p.27"},{key:"sgp.kits.offset.p.28"},{key:"sgp.kits.offset.p.29"},{key:"sgp.kits.offset.p.30"},{key:"sgp.kits.offset.p.31"},{key:"sgp.kits.offset.p.32"},{key:"sgp.kits.offset.p.33"},{key:"sgp.kits.offset.p.34"},{key:"sgp.kits.offset.p.35"},{key:"sgp.kits.offset.p.36"},{key:"sgp.kits.offset.p.37"},{key:"sgp.kits.offset.p.38"},{key:"sgp.kits.offset.p.39"},{key:"sgp.kits.offset.p.40"},{key:"sgp.kits.offset.p.41"},{key:"sgp.kits.offset.p.42"},{key:"sgp.kits.offset.p.43"},{key:"sgp.kits.offset.p.44"},{key:"sgp.kits.offset.p.45"},{key:"sgp.kits.offset.p.46"},{key:"sgp.kits.offset.p.47"},{key:"sgp.kits.offset.p.48"},{key:"sgp.kits.offset.p.49"},{key:"sgp.kits.offset.p.50"},{key:"sgp.kits.offset.p.51"},{key:"sgp.kits.offset.p.52"},{key:"sgp.kits.offset.p.53"},{key:"sgp.kits.offset.p.54"},{key:"sgp.kits.offset.p.55"},{key:"sgp.kits.offset.p.56"},{key:"sgp.kits.offset.p.57"},{key:"sgp.kits.offset.p.58"},{key:"sgp.kits.offset.p.59"},{key:"sgp.kits.offset.p.60"},{key:"sgp.kits.offset.p.61"},{key:"sgp.kits.offset.p.62"},{key:"sgp.kits.offset.p.63"},{key:"sgp.kits.offset.p.64"},{key:"sgp.kits.offset.p.65"},{key:"sgp.kits.offset.p.66"},{key:"sgp.kits.offset.p.67"},{key:"sgp.kits.offset.p.68"},{key:"sgp.kits.offset.p.69"},{key:"sgp.kits.offset.p.70"},{key:"sgp.kits.offset.p.71"},{key:"sgp.kits.offset.p.72"},{key:"sgp.kits.offset.p.73"},{key:"sgp.kits.offset.p.74"},{key:"sgp.kits.offset.p.75"},{key:"sgp.kits.offset.p.76"},{key:"sgp.kits.offset.p.77"},{key:"sgp.kits.offset.p.78"},{key:"sgp.kits.offset.p.79"},{key:"sgp.kits.offset.p.80"},{key:"sgp.kits.offset.p.81"},{key:"sgp.kits.offset.p.82"},{key:"sgp.kits.offset.p.83"},{key:"sgp.kits.offset.p.84"},{key:"sgp.kits.offset.p.85"},{key:"sgp.kits.offset.p.86"},{key:"sgp.kits.offset.p.87"},{key:"sgp.kits.offset.p.88"},{key:"sgp.kits.offset.p.89"},{key:"sgp.kits.offset.p.90"},{key:"sgp.kits.offset.p.91"},{key:"sgp.kits.offset.p.92"},{key:"sgp.kits.offset.p.93"},{key:"sgp.kits.offset.p.94"},{key:"sgp.kits.offset.p.95"},{key:"sgp.kits.offset.p.96"},{key:"sgp.kits.offset.p.97"},{key:"sgp.kits.offset.p.98"},{key:"sgp.kits.offset.p.99"},{key:"sgp.kits.offset.p.100"},{key:"sgp.kits.offset.p.101"},{key:"sgp.kits.offset.p.102"},{key:"sgp.kits.offset.p.103"},{key:"sgp.kits.offset.p.104"},{key:"sgp.kits.offset.p.105"},{key:"sgp.kits.offset.p.106"},{key:"sgp.kits.offset.p.107"},{key:"sgp.kits.offset.p.108"},{key:"sgp.kits.offset.p.109"},{key:"sgp.kits.offset.p.110"},{key:"sgp.kits.offset.p.111"},{key:"sgp.kits.offset.p.112"},{key:"sgp.kits.offset.p.113"},{key:"sgp.kits.offset.p.114"},{key:"sgp.kits.offset.p.115"},{key:"sgp.kits.offset.p.116"},{key:"sgp.kits.offset.p.117"},{key:"sgp.kits.offset.p.118"},{key:"sgp.kits.offset.p.119"},{key:"sgp.kits.offset.p.120"},{key:"sgp.kits.offset.p.121"},{key:"sgp.kits.offset.p.122"},{key:"sgp.kits.offset.p.123"},{key:"sgp.kits.offset.p.124"},{key:"sgp.kits.offset.p.125"},{key:"sgp.kits.offset.p.126"},{key:"sgp.kits.offset.p.127"},{key:"sgp.kits.offset.p.128"},{key:"sgp.kits.offset.p.129"},{key:"sgp.kits.offset.p.130"},{key:"sgp.kits.offset.p.131"},{key:"sgp.kits.offset.p.132"},{key:"sgp.kits.offset.p.133"},{key:"sgp.kits.offset.p.134"},{key:"sgp.kits.offset.p.135"},{key:"sgp.kits.offset.p.136"},{key:"sgp.kits.offset.p.137"},{key:"sgp.kits.offset.p.138"},{key:"sgp.kits.offset.p.139"},{key:"sgp.kits.offset.p.140"},{key:"sgp.kits.offset.p.141"},{key:"sgp.kits.offset.p.142"},{key:"sgp.kits.offset.p.143"},{key:"sgp.kits.offset.p.144"},{key:"sgp.kits.offset.p.145"},{key:"sgp.kits.offset.p.146"},{key:"sgp.kits.offset.p.147"},{key:"sgp.kits.offset.p.148"},{key:"sgp.kits.offset.p.149"},{key:"sgp.kits.offset.p.150"},{key:"sgp.kits.offset.p.151"},{key:"sgp.kits.offset.p.152"},{key:"sgp.kits.offset.p.153"},{key:"sgp.kits.offset.p.154"},{key:"sgp.kits.offset.p.155"},{key:"sgp.kits.offset.p.156"},{key:"sgp.kits.offset.p.157"},{key:"sgp.kits.offset.p.158"},{key:"sgp.kits.offset.p.159"},{key:"sgp.kits.offset.p.160"},{key:"sgp.kits.offset.p.161"},{key:"sgp.kits.offset.p.162"},{key:"sgp.kits.offset.p.163"},{key:"sgp.kits.offset.p.164"},{key:"sgp.kits.offset.p.165"},{key:"sgp.kits.offset.p.166"},{key:"sgp.kits.offset.p.167"},{key:"sgp.kits.offset.p.168"},{key:"sgp.kits.offset.p.169"},{key:"sgp.kits.offset.p.170"},{key:"sgp.kits.offset.p.171"},{key:"sgp.kits.offset.p.172"},{key:"sgp.kits.offset.p.173"},{key:"sgp.kits.offset.p.174"},{key:"sgp.kits.offset.p.175"},{key:"sgp.kits.offset.p.176"},{key:"sgp.kits.offset.p.177"},{key:"sgp.kits.offset.p.178"},{key:"sgp.kits.offset.p.179"},{key:"sgp.kits.offset.p.180"},{key:"sgp.kits.offset.p.181"},{key:"sgp.kits.offset.p.182"},{key:"sgp.kits.offset.p.183"},{key:"sgp.kits.offset.p.184"},{key:"sgp.kits.offset.p.185"},{key:"sgp.kits.offset.p.186"},{key:"sgp.kits.offset.p.187"},{key:"sgp.kits.offset.p.188"},{key:"sgp.kits.offset.p.189"},{key:"sgp.kits.offset.p.190"},{key:"sgp.kits.offset.p.191"},{key:"sgp.kits.offset.p.192"},{key:"sgp.kits.offset.p.193"},{key:"sgp.kits.offset.p.194"},{key:"sgp.kits.offset.p.195"},{key:"sgp.kits.offset.p.196"},{key:"sgp.kits.offset.p.197"},{key:"sgp.kits.offset.p.198"},{key:"sgp.kits.offset.p.199"},{key:"sgp.kits.offset.p.200"},{key:"sgp.kits.offset.p.201"},{key:"sgp.kits.offset.p.202"},{key:"sgp.kits.offset.p.203"},{key:"sgp.kits.offset.p.204"},{key:"sgp.kits.offset.p.205"},{key:"sgp.kits.offset.p.206"},{key:"sgp.kits.offset.p.207"},{key:"sgp.kits.offset.p.208"},{key:"sgp.kits.offset.p.209"},{key:"sgp.kits.offset.p.210"},{key:"sgp.kits.offset.p.211"},{key:"sgp.kits.offset.p.212"},{key:"sgp.kits.offset.p.213"},{key:"sgp.kits.offset.p.214"},{key:"sgp.kits.offset.p.215"},{key:"sgp.kits.offset.p.216"},{key:"sgp.kits.offset.p.217"},{key:"sgp.kits.offset.p.218"},{key:"sgp.kits.offset.p.219"},{key:"sgp.kits.offset.p.220"},{key:"sgp.kits.offset.p.221"},{key:"sgp.kits.offset.p.222"},{key:"sgp.kits.offset.p.223"},{key:"sgp.kits.offset.p.224"},{key:"sgp.kits.offset.p.225"},{key:"sgp.kits.offset.p.226"},{key:"sgp.kits.offset.p.227"},{key:"sgp.kits.offset.p.228"},{key:"sgp.kits.offset.p.229"},{key:"sgp.kits.offset.p.230"},{key:"sgp.kits.offset.p.231"},{key:"sgp.kits.offset.p.232"},{key:"sgp.kits.offset.p.233"},{key:"sgp.kits.offset.p.234"},{key:"sgp.kits.offset.p.235"},{key:"sgp.kits.offset.p.236"},{key:"sgp.kits.offset.p.237"},{key:"sgp.kits.offset.p.238"},{key:"sgp.kits.offset.p.239"},{key:"sgp.kits.offset.p.240"},{key:"sgp.kits.offset.p.241"},{key:"sgp.kits.offset.p.242"},{key:"sgp.kits.offset.p.243"},{key:"sgp.kits.offset.p.244"},{key:"sgp.kits.offset.p.245"},{key:"sgp.kits.offset.p.246"},{key:"sgp.kits.offset.p.247"},{key:"sgp.kits.offset.p.248"},{key:"sgp.kits.offset.p.249"},{key:"sgp.kits.offset.p.250"},{key:"sgp.kits.offset.p.251"},{key:"sgp.kits.offset.p.252"},{key:"sgp.kits.offset.p.253"},{key:"sgp.kits.offset.p.254"},{key:"sgp.kits.offset.p.255"},{key:"sgp.kits.offset.p.256"},{key:"sgp.kits.offset.p.257"},{key:"sgp.kits.offset.p.258"},{key:"sgp.kits.offset.p.259"},{key:"sgp.kits.offset.p.260"},{key:"sgp.kits.offset.p.261"},{key:"sgp.kits.offset.p.262"},{key:"sgp.kits.offset.p.263"},{key:"sgp.kits.offset.p.264"},{key:"sgp.kits.offset.p.265"},{key:"sgp.kits.offset.p.266"},{key:"sgp.kits.offset.p.267"},{key:"sgp.kits.offset.p.268"},{key:"sgp.kits.offset.p.269"},{key:"sgp.kits.offset.p.270"},{key:"sgp.kits.offset.p.271"},{key:"sgp.kits.offset.p.272"},{key:"sgp.kits.offset.p.273"},{key:"sgp.kits.offset.p.274"},{key:"sgp.kits.offset.p.275"},{key:"sgp.kits.offset.p.276"},{key:"sgp.kits.offset.p.277"},{key:"sgp.kits.offset.p.278"},{key:"sgp.kits.offset.p.279"},{key:"sgp.kits.offset.p.280"},{key:"sgp.kits.offset.p.281"},{key:"sgp.kits.offset.p.282"},{key:"sgp.kits.offset.p.283"},{key:"sgp.kits.offset.p.284"},{key:"sgp.kits.offset.p.285"},{key:"sgp.kits.offset.p.286"},{key:"sgp.kits.offset.p.287"},{key:"sgp.kits.offset.p.288"},{key:"sgp.kits.offset.p.289"},{key:"sgp.kits.offset.p.290"},{key:"sgp.kits.offset.p.291"},{key:"sgp.kits.offset.p.292"},{key:"sgp.kits.offset.p.293"},{key:"sgp.kits.offset.p.294"},{key:"sgp.kits.offset.p.295"},{key:"sgp.kits.offset.p.296"},{key:"sgp.kits.offset.p.297"},{key:"sgp.kits.offset.p.298"},{key:"sgp.kits.offset.p.299"},{key:"sgp.kits.offset.p.300"},{key:"sgp.kits.offset.p.301"},{key:"sgp.kits.offset.p.302"},{key:"sgp.kits.offset.p.303"},{key:"sgp.kits.offset.p.304"},{key:"sgp.kits.offset.p.305"},{key:"sgp.kits.offset.p.306"},{key:"sgp.kits.offset.p.307"},{key:"sgp.kits.offset.p.308"},{key:"sgp.kits.offset.p.309"},{key:"sgp.kits.offset.p.310"},{key:"sgp.kits.offset.p.311"},{key:"sgp.kits.offset.p.312"},{key:"sgp.kits.offset.p.313"},{key:"sgp.kits.offset.p.314"},{key:"sgp.kits.offset.p.315"},{key:"sgp.kits.offset.p.316"},{key:"sgp.kits.offset.p.317"},{key:"sgp.kits.offset.p.318"},{key:"sgp.kits.offset.p.319"},{key:"sgp.kits.offset.p.320"},{key:"sgp.kits.offset.p.321"},{key:"sgp.kits.offset.p.322"},{key:"sgp.kits.offset.p.323"},{key:"sgp.kits.offset.p.324"},{key:"sgp.kits.offset.p.325"},{key:"sgp.kits.offset.p.326"},{key:"sgp.kits.offset.p.327"},{key:"sgp.kits.offset.p.328"},{key:"sgp.kits.offset.p.329"},{key:"sgp.kits.offset.p.330"},{key:"sgp.kits.offset.p.331"},{key:"sgp.kits.offset.p.332"},{key:"sgp.kits.offset.p.333"},{key:"sgp.kits.offset.p.334"},{key:"sgp.kits.offset.p.335"},{key:"sgp.kits.offset.p.336"},{key:"sgp.kits.offset.p.337"},{key:"sgp.kits.offset.p.338"},{key:"sgp.kits.offset.p.339"},{key:"sgp.kits.offset.p.340"},{key:"sgp.kits.offset.p.341"},{key:"sgp.kits.offset.p.342"},{key:"sgp.kits.offset.p.343"},{key:"sgp.kits.offset.p.344"},{key:"sgp.kits.offset.p.345"},{key:"sgp.kits.offset.p.346"},{key:"sgp.kits.offset.p.347"},{key:"sgp.kits.offset.p.348"},{key:"sgp.kits.offset.p.349"},{key:"sgp.kits.offset.p.350"},{key:"sgp.kits.offset.p.351"},{key:"sgp.kits.offset.p.352"},{key:"sgp.kits.offset.p.353"},{key:"sgp.kits.offset.p.354"},{key:"sgp.kits.offset.p.355"},{key:"sgp.kits.offset.p.356"},{key:"sgp.kits.offset.p.357"},{key:"sgp.kits.offset.p.358"},{key:"sgp.kits.offset.p.359"},{key:"sgp.kits.offset.p.360"},{key:"sgp.kits.offset.p.361"},{key:"sgp.kits.offset.p.362"},{key:"sgp.kits.offset.p.363"},{key:"sgp.kits.offset.p.364"},{key:"sgp.kits.offset.p.365"},{key:"sgp.kits.offset.p.366"},{key:"sgp.kits.offset.p.367"},{key:"sgp.kits.offset.p.368"},{key:"sgp.kits.offset.p.369"},{key:"sgp.kits.offset.p.370"},{key:"sgp.kits.offset.p.371"},{key:"sgp.kits.offset.p.372"},{key:"sgp.kits.offset.p.373"},{key:"sgp.kits.offset.p.374"},{key:"sgp.kits.offset.p.375"},{key:"sgp.kits.offset.p.376"},{key:"sgp.kits.offset.p.377"},{key:"sgp.kits.offset.p.378"},{key:"sgp.kits.offset.p.379"},{key:"sgp.kits.offset.p.380"},{key:"sgp.kits.offset.p.381"},{key:"sgp.kits.offset.p.382"},{key:"sgp.kits.offset.p.383"},{key:"sgp.kits.offset.p.384"},{key:"sgp.kits.offset.p.385"},{key:"sgp.kits.offset.p.386"},{key:"sgp.kits.offset.p.387"},{key:"sgp.kits.offset.p.388"},{key:"sgp.kits.offset.p.389"},{key:"sgp.kits.offset.p.390"},{key:"sgp.kits.offset.p.391"},{key:"sgp.kits.offset.p.392"},{key:"sgp.kits.offset.p.393"},{key:"sgp.kits.offset.p.394"},{key:"sgp.kits.offset.p.395"},{key:"sgp.kits.offset.p.396"},{key:"sgp.kits.offset.p.397"},{key:"sgp.kits.offset.p.398"},{key:"sgp.kits.offset.p.399"},{key:"sgp.kits.offset.p.400"},{key:"sgp.kits.offset.p.401"},{key:"sgp.kits.offset.p.402"},{key:"sgp.kits.offset.p.403"},{key:"sgp.kits.offset.p.404"},{key:"sgp.kits.offset.p.405"},{key:"sgp.kits.offset.p.406"},{key:"sgp.kits.offset.p.407"},{key:"sgp.kits.offset.p.408"},{key:"sgp.kits.offset.p.409"},{key:"sgp.kits.offset.p.410"},{key:"sgp.kits.offset.p.411"},{key:"sgp.kits.offset.p.412"},{key:"sgp.kits.offset.p.413"},{key:"sgp.kits.offset.p.414"},{key:"sgp.kits.offset.p.415"},{key:"sgp.kits.offset.p.416"},{key:"sgp.kits.offset.p.417"},{key:"sgp.kits.offset.p.418"},{key:"sgp.kits.offset.p.419"},{key:"sgp.kits.offset.p.420"},{key:"sgp.kits.offset.p.421"},{key:"sgp.kits.offset.p.422"},{key:"sgp.kits.offset.p.423"},{key:"sgp.kits.offset.p.424"},{key:"sgp.kits.offset.p.425"},{key:"sgp.kits.offset.p.426"},{key:"sgp.kits.offset.p.427"},{key:"sgp.kits.offset.p.428"},{key:"sgp.kits.offset.p.429"},{key:"sgp.kits.offset.p.430"},{key:"sgp.kits.offset.p.431"},{key:"sgp.kits.offset.p.432"},{key:"sgp.kits.offset.p.433"},{key:"sgp.kits.offset.p.434"},{key:"sgp.kits.offset.p.435"},{key:"sgp.kits.offset.p.436"},{key:"sgp.kits.offset.p.437"},{key:"sgp.kits.offset.p.438"},{key:"sgp.kits.offset.p.439"},{key:"sgp.kits.offset.p.440"},{key:"sgp.kits.offset.p.441"},{key:"sgp.kits.offset.p.442"},{key:"sgp.kits.offset.p.443"},{key:"sgp.kits.offset.p.444"},{key:"sgp.kits.offset.p.445"},{key:"sgp.kits.offset.p.446"},{key:"sgp.kits.offset.p.447"},{key:"sgp.kits.offset.p.448"},{key:"sgp.kits.offset.p.449"},{key:"sgp.kits.offset.p.450"},{key:"sgp.kits.offset.p.451"},{key:"sgp.kits.offset.p.452"},{key:"sgp.kits.offset.p.453"},{key:"sgp.kits.offset.p.454"},{key:"sgp.kits.offset.p.455"},{key:"sgp.kits.offset.p.456"},{key:"sgp.kits.offset.p.457"},{key:"sgp.kits.offset.p.458"},{key:"sgp.kits.offset.p.459"},{key:"sgp.kits.offset.p.460"},{key:"sgp.kits.offset.p.461"},{key:"sgp.kits.offset.p.462"},{key:"sgp.kits.offset.p.463"},{key:"sgp.kits.offset.p.464"},{key:"sgp.kits.offset.p.465"},{key:"sgp.kits.offset.p.466"},{key:"sgp.kits.offset.p.467"},{key:"sgp.kits.offset.p.468"},{key:"sgp.kits.offset.p.469"},{key:"sgp.kits.offset.p.470"},{key:"sgp.kits.offset.p.471"},{key:"sgp.kits.offset.p.472"},{key:"sgp.kits.offset.p.473"},{key:"sgp.kits.offset.p.474"},{key:"sgp.kits.offset.p.475"},{key:"sgp.kits.offset.p.476"},{key:"sgp.kits.offset.p.477"},{key:"sgp.kits.offset.p.478"},{key:"sgp.kits.offset.p.479"},{key:"sgp.kits.offset.p.480"},{key:"sgp.kits.offset.p.481"},{key:"sgp.kits.offset.p.482"},{key:"sgp.kits.offset.p.483"},{key:"sgp.kits.offset.p.484"},{key:"sgp.kits.offset.p.485"},{key:"sgp.kits.offset.p.486"},{key:"sgp.kits.offset.p.487"},{key:"sgp.kits.offset.p.488"},{key:"sgp.kits.offset.p.489"},{key:"sgp.kits.offset.p.490"},{key:"sgp.kits.offset.p.491"},{key:"sgp.kits.offset.p.492"},{key:"sgp.kits.offset.p.493"},{key:"sgp.kits.offset.p.494"},{key:"sgp.kits.offset.p.495"},{key:"sgp.kits.offset.p.496"},{key:"sgp.kits.offset.p.497"},{key:"sgp.kits.offset.p.498"},{key:"sgp.kits.offset.p.499"},{key:"sgp.kits.offset.p.500"},{key:"sgp.kits.offset.p.501"},{key:"sgp.kits.offset.p.502"},{key:"sgp.kits.offset.p.503"},{key:"sgp.kits.offset.p.504"},{key:"sgp.kits.offset.p.505"},{key:"sgp.kits.offset.p.506"},{key:"sgp.kits.offset.p.507"},{key:"sgp.kits.offset.p.508"},{key:"sgp.kits.offset.p.509"},{key:"sgp.kits.offset.p.510"},{key:"sgp.kits.offset.p.511"},{key:"sgp.kits.offset.p.512"},{key:"sgp.kits.offset.p.513"},{key:"sgp.kits.offset.p.514"},{key:"sgp.kits.offset.p.515"},{key:"sgp.kits.offset.p.516"},{key:"sgp.kits.offset.p.517"},{key:"sgp.kits.offset.p.518"},{key:"sgp.kits.offset.p.519"},{key:"sgp.kits.offset.p.520"},{key:"sgp.kits.offset.p.521"},{key:"sgp.kits.offset.p.522"},{key:"sgp.kits.offset.p.523"},{key:"sgp.kits.offset.p.524"},{key:"sgp.kits.offset.p.525"},{key:"sgp.kits.offset.p.526"},{key:"sgp.kits.offset.p.527"},{key:"sgp.kits.offset.p.528"},{key:"sgp.kits.offset.p.529"},{key:"sgp.kits.offset.p.530"},{key:"sgp.kits.offset.p.531"},{key:"sgp.kits.offset.p.532"},{key:"sgp.kits.offset.p.533"},{key:"sgp.kits.offset.p.534"},{key:"sgp.kits.offset.p.535"},{key:"sgp.kits.offset.p.536"},{key:"sgp.kits.offset.p.537"},{key:"sgp.kits.offset.p.538"},{key:"sgp.kits.offset.p.539"},{key:"sgp.kits.offset.p.540"},{key:"sgp.kits.offset.p.541"},{key:"sgp.kits.offset.p.542"},{key:"sgp.kits.offset.p.543"},{key:"sgp.kits.offset.p.544"},{key:"sgp.kits.offset.p.545"},{key:"sgp.kits.offset.p.546"},{key:"sgp.kits.offset.p.547"},{key:"sgp.kits.offset.p.548"},{key:"sgp.kits.offset.p.549"},{key:"sgp.kits.offset.p.550"},{key:"sgp.kits.offset.p.551"},{key:"sgp.kits.offset.p.552"},{key:"sgp.kits.offset.p.553"},{key:"sgp.kits.offset.p.554"},{key:"sgp.kits.offset.p.555"},{key:"sgp.kits.offset.p.556"},{key:"sgp.kits.offset.p.557"},{key:"sgp.kits.offset.p.558"},{key:"sgp.kits.offset.p.559"},{key:"sgp.kits.offset.p.560"},{key:"sgp.kits.offset.p.561"},{key:"sgp.kits.offset.p.562"},{key:"sgp.kits.offset.p.563"},{key:"sgp.kits.offset.p.564"},{key:"sgp.kits.offset.p.565"},{key:"sgp.kits.offset.p.566"},{key:"sgp.kits.offset.p.567"},{key:"sgp.kits.offset.p.568"},{key:"sgp.kits.offset.p.569"},{key:"sgp.kits.offset.p.570"},{key:"sgp.kits.offset.p.571"},{key:"sgp.kits.offset.p.572"},{key:"sgp.kits.offset.p.573"},{key:"sgp.kits.offset.p.574"},{key:"sgp.kits.offset.p.575"},{key:"sgp.kits.offset.p.576"},{key:"sgp.kits.offset.p.577"},{key:"sgp.kits.offset.p.578"},{key:"sgp.kits.offset.p.579"},{key:"sgp.kits.offset.p.580"},{key:"sgp.kits.offset.p.581"},{key:"sgp.kits.offset.p.582"},{key:"sgp.kits.offset.p.583"},{key:"sgp.kits.offset.p.584"},{key:"sgp.kits.offset.p.585"},{key:"sgp.kits.offset.p.586"},{key:"sgp.kits.offset.p.587"},{key:"sgp.kits.offset.p.588"},{key:"sgp.kits.offset.p.589"},{key:"sgp.kits.offset.p.590"},{key:"sgp.kits.offset.p.591"},{key:"sgp.kits.offset.p.592"},{key:"sgp.kits.offset.p.593"},{key:"sgp.kits.offset.p.594"},{key:"sgp.kits.offset.p.595"},{key:"sgp.kits.offset.p.596"},{key:"sgp.kits.offset.p.597"},{key:"sgp.kits.offset.p.598"},{key:"sgp.kits.offset.p.599"},{key:"sgp.kits.offset.p.600"},{key:"sgp.kits.offset.p.601"},{key:"sgp.kits.offset.p.602"},{key:"sgp.kits.offset.p.603"},{key:"sgp.kits.offset.p.604"},{key:"sgp.kits.offset.p.605"},{key:"sgp.kits.offset.p.606"},{key:"sgp.kits.offset.p.607"},{key:"sgp.kits.offset.p.608"},{key:"sgp.kits.offset.p.609"},{key:"sgp.kits.offset.p.610"},{key:"sgp.kits.offset.p.611"},{key:"sgp.kits.offset.p.612"},{key:"sgp.kits.offset.p.613"},{key:"sgp.kits.offset.p.614"},{key:"sgp.kits.offset.p.615"},{key:"sgp.kits.offset.p.616"},{key:"sgp.kits.offset.p.617"},{key:"sgp.kits.offset.p.618"},{key:"sgp.kits.offset.p.619"},{key:"sgp.kits.offset.p.620"},{key:"sgp.kits.offset.p.621"},{key:"sgp.kits.offset.p.622"},{key:"sgp.kits.offset.p.623"},{key:"sgp.kits.offset.p.624"},{key:"sgp.kits.offset.p.625"},{key:"sgp.kits.offset.p.626"},{key:"sgp.kits.offset.p.627"},{key:"sgp.kits.offset.p.628"},{key:"sgp.kits.offset.p.629"},{key:"sgp.kits.offset.p.630"},{key:"sgp.kits.offset.p.631"},{key:"sgp.kits.offset.p.632"},{key:"sgp.kits.offset.p.633"},{key:"sgp.kits.offset.p.634"},{key:"sgp.kits.offset.p.635"},{key:"sgp.kits.offset.p.636"},{key:"sgp.kits.offset.p.637"},{key:"sgp.kits.offset.p.638"},{key:"sgp.kits.offset.p.639"},{key:"sgp.kits.offset.p.640"},{key:"sgp.kits.offset.p.641"},{key:"sgp.kits.offset.p.642"},{key:"sgp.kits.offset.p.643"},{key:"sgp.kits.offset.p.644"},{key:"sgp.kits.offset.p.645"},{key:"sgp.kits.offset.p.646"},{key:"sgp.kits.offset.p.647"},{key:"sgp.kits.offset.p.648"},{key:"sgp.kits.offset.p.649"},{key:"sgp.kits.offset.p.650"},{key:"sgp.kits.offset.p.651"},{key:"sgp.kits.offset.p.652"},{key:"sgp.kits.offset.p.653"},{key:"sgp.kits.offset.p.654"},{key:"sgp.kits.offset.p.655"},{key:"sgp.kits.offset.p.656"},{key:"sgp.kits.offset.p.657"},{key:"sgp.kits.offset.p.658"},{key:"sgp.kits.offset.p.659"},{key:"sgp.kits.offset.p.660"},{key:"sgp.kits.offset.p.661"},{key:"sgp.kits.offset.p.662"},{key:"sgp.kits.offset.p.663"},{key:"sgp.kits.offset.p.664"},{key:"sgp.kits.offset.p.665"},{key:"sgp.kits.offset.p.666"},{key:"sgp.kits.offset.p.667"},{key:"sgp.kits.offset.p.668"},{key:"sgp.kits.offset.p.669"},{key:"sgp.kits.offset.p.670"},{key:"sgp.kits.offset.p.671"},{key:"sgp.kits.offset.p.672"},{key:"sgp.kits.offset.p.673"},{key:"sgp.kits.offset.p.674"},{key:"sgp.kits.offset.p.675"},{key:"sgp.kits.offset.p.676"},{key:"sgp.kits.offset.p.677"},{key:"sgp.kits.offset.p.678"},{key:"sgp.kits.offset.p.679"},{key:"sgp.kits.offset.p.680"},{key:"sgp.kits.offset.p.681"},{key:"sgp.kits.offset.p.682"},{key:"sgp.kits.offset.p.683"},{key:"sgp.kits.offset.p.684"},{key:"sgp.kits.offset.p.685"},{key:"sgp.kits.offset.p.686"},{key:"sgp.kits.offset.p.687"},{key:"sgp.kits.offset.p.688"},{key:"sgp.kits.offset.p.689"},{key:"sgp.kits.offset.p.690"},{key:"sgp.kits.offset.p.691"},{key:"sgp.kits.offset.p.692"},{key:"sgp.kits.offset.p.693"},{key:"sgp.kits.offset.p.694"},{key:"sgp.kits.offset.p.695"},{key:"sgp.kits.offset.p.696"},{key:"sgp.kits.offset.p.697"},{key:"sgp.kits.offset.p.698"},{key:"sgp.kits.offset.p.699"},{key:"sgp.kits.offset.p.700"},{key:"sgp.kits.offset.p.701"},{key:"sgp.kits.offset.p.702"},{key:"sgp.kits.offset.p.703"},{key:"sgp.kits.offset.p.704"},{key:"sgp.kits.offset.p.705"},{key:"sgp.kits.offset.p.706"},{key:"sgp.kits.offset.p.707"},{key:"sgp.kits.offset.p.708"},{key:"sgp.kits.offset.p.709"},{key:"sgp.kits.offset.p.710"},{key:"sgp.kits.offset.p.711"},{key:"sgp.kits.offset.p.712"},{key:"sgp.kits.offset.p.713"},{key:"sgp.kits.offset.p.714"},{key:"sgp.kits.offset.p.715"},{key:"sgp.kits.offset.p.716"},{key:"sgp.kits.offset.p.717"},{key:"sgp.kits.offset.p.718"},{key:"sgp.kits.offset.p.719"},{key:"sgp.kits.offset.p.720"},{key:"sgp.kits.offset.p.721"},{key:"sgp.kits.offset.p.722"},{key:"sgp.kits.offset.p.723"},{key:"sgp.kits.offset.p.724"},{key:"sgp.kits.offset.p.725"},{key:"sgp.kits.offset.p.726"},{key:"sgp.kits.offset.p.727"},{key:"sgp.kits.offset.p.728"},{key:"sgp.kits.offset.p.729"},{key:"sgp.kits.offset.p.730"},{key:"sgp.kits.offset.p.731"},{key:"sgp.kits.offset.p.732"},{key:"sgp.kits.offset.p.733"},{key:"sgp.kits.offset.p.734"},{key:"sgp.kits.offset.p.735"},{key:"sgp.kits.offset.p.736"},{key:"sgp.kits.offset.p.737"},{key:"sgp.kits.offset.p.738"},{key:"sgp.kits.offset.p.739"},{key:"sgp.kits.offset.p.740"},{key:"sgp.kits.offset.p.741"},{key:"sgp.kits.offset.p.742"},{key:"sgp.kits.offset.p.743"},{key:"sgp.kits.offset.p.744"},{key:"sgp.kits.offset.p.745"},{key:"sgp.kits.offset.p.746"},{key:"sgp.kits.offset.p.747"},{key:"sgp.kits.offset.p.748"},{key:"sgp.kits.offset.p.749"},{key:"sgp.kits.offset.p.750"},{key:"sgp.kits.offset.p.751"},{key:"sgp.kits.offset.p.752"},{key:"sgp.kits.offset.p.753"},{key:"sgp.kits.offset.p.754"},{key:"sgp.kits.offset.p.755"},{key:"sgp.kits.offset.p.756"},{key:"sgp.kits.offset.p.757"},{key:"sgp.kits.offset.p.758"},{key:"sgp.kits.offset.p.759"},{key:"sgp.kits.offset.p.760"},{key:"sgp.kits.offset.p.761"},{key:"sgp.kits.offset.p.762"},{key:"sgp.kits.offset.p.763"},{key:"sgp.kits.offset.p.764"},{key:"sgp.kits.offset.p.765"},{key:"sgp.kits.offset.p.766"},{key:"sgp.kits.offset.p.767"},{key:"sgp.kits.offset.p.768"}]

data modify storage sgp:data misc.actionbar.hud.space_negative set value [{key:"sgp.kits.offset.n.0"},{key:"sgp.kits.offset.n.1"},{key:"sgp.kits.offset.n.2"},{key:"sgp.kits.offset.n.3"},{key:"sgp.kits.offset.n.4"},{key:"sgp.kits.offset.n.5"},{key:"sgp.kits.offset.n.6"},{key:"sgp.kits.offset.n.7"},{key:"sgp.kits.offset.n.8"},{key:"sgp.kits.offset.n.9"},{key:"sgp.kits.offset.n.10"},{key:"sgp.kits.offset.n.11"},{key:"sgp.kits.offset.n.12"},{key:"sgp.kits.offset.n.13"},{key:"sgp.kits.offset.n.14"},{key:"sgp.kits.offset.n.15"},{key:"sgp.kits.offset.n.16"},{key:"sgp.kits.offset.n.17"},{key:"sgp.kits.offset.n.18"},{key:"sgp.kits.offset.n.19"},{key:"sgp.kits.offset.n.20"},{key:"sgp.kits.offset.n.21"},{key:"sgp.kits.offset.n.22"},{key:"sgp.kits.offset.n.23"},{key:"sgp.kits.offset.n.24"},{key:"sgp.kits.offset.n.25"},{key:"sgp.kits.offset.n.26"},{key:"sgp.kits.offset.n.27"},{key:"sgp.kits.offset.n.28"},{key:"sgp.kits.offset.n.29"},{key:"sgp.kits.offset.n.30"},{key:"sgp.kits.offset.n.31"},{key:"sgp.kits.offset.n.32"},{key:"sgp.kits.offset.n.33"},{key:"sgp.kits.offset.n.34"},{key:"sgp.kits.offset.n.35"},{key:"sgp.kits.offset.n.36"},{key:"sgp.kits.offset.n.37"},{key:"sgp.kits.offset.n.38"},{key:"sgp.kits.offset.n.39"},{key:"sgp.kits.offset.n.40"},{key:"sgp.kits.offset.n.41"},{key:"sgp.kits.offset.n.42"},{key:"sgp.kits.offset.n.43"},{key:"sgp.kits.offset.n.44"},{key:"sgp.kits.offset.n.45"},{key:"sgp.kits.offset.n.46"},{key:"sgp.kits.offset.n.47"},{key:"sgp.kits.offset.n.48"},{key:"sgp.kits.offset.n.49"},{key:"sgp.kits.offset.n.50"},{key:"sgp.kits.offset.n.51"},{key:"sgp.kits.offset.n.52"},{key:"sgp.kits.offset.n.53"},{key:"sgp.kits.offset.n.54"},{key:"sgp.kits.offset.n.55"},{key:"sgp.kits.offset.n.56"},{key:"sgp.kits.offset.n.57"},{key:"sgp.kits.offset.n.58"},{key:"sgp.kits.offset.n.59"},{key:"sgp.kits.offset.n.60"},{key:"sgp.kits.offset.n.61"},{key:"sgp.kits.offset.n.62"},{key:"sgp.kits.offset.n.63"},{key:"sgp.kits.offset.n.64"},{key:"sgp.kits.offset.n.65"},{key:"sgp.kits.offset.n.66"},{key:"sgp.kits.offset.n.67"},{key:"sgp.kits.offset.n.68"},{key:"sgp.kits.offset.n.69"},{key:"sgp.kits.offset.n.70"},{key:"sgp.kits.offset.n.71"},{key:"sgp.kits.offset.n.72"},{key:"sgp.kits.offset.n.73"},{key:"sgp.kits.offset.n.74"},{key:"sgp.kits.offset.n.75"},{key:"sgp.kits.offset.n.76"},{key:"sgp.kits.offset.n.77"},{key:"sgp.kits.offset.n.78"},{key:"sgp.kits.offset.n.79"},{key:"sgp.kits.offset.n.80"},{key:"sgp.kits.offset.n.81"},{key:"sgp.kits.offset.n.82"},{key:"sgp.kits.offset.n.83"},{key:"sgp.kits.offset.n.84"},{key:"sgp.kits.offset.n.85"},{key:"sgp.kits.offset.n.86"},{key:"sgp.kits.offset.n.87"},{key:"sgp.kits.offset.n.88"},{key:"sgp.kits.offset.n.89"},{key:"sgp.kits.offset.n.90"},{key:"sgp.kits.offset.n.91"},{key:"sgp.kits.offset.n.92"},{key:"sgp.kits.offset.n.93"},{key:"sgp.kits.offset.n.94"},{key:"sgp.kits.offset.n.95"},{key:"sgp.kits.offset.n.96"},{key:"sgp.kits.offset.n.97"},{key:"sgp.kits.offset.n.98"},{key:"sgp.kits.offset.n.99"},{key:"sgp.kits.offset.n.100"},{key:"sgp.kits.offset.n.101"},{key:"sgp.kits.offset.n.102"},{key:"sgp.kits.offset.n.103"},{key:"sgp.kits.offset.n.104"},{key:"sgp.kits.offset.n.105"},{key:"sgp.kits.offset.n.106"},{key:"sgp.kits.offset.n.107"},{key:"sgp.kits.offset.n.108"},{key:"sgp.kits.offset.n.109"},{key:"sgp.kits.offset.n.110"},{key:"sgp.kits.offset.n.111"},{key:"sgp.kits.offset.n.112"},{key:"sgp.kits.offset.n.113"},{key:"sgp.kits.offset.n.114"},{key:"sgp.kits.offset.n.115"},{key:"sgp.kits.offset.n.116"},{key:"sgp.kits.offset.n.117"},{key:"sgp.kits.offset.n.118"},{key:"sgp.kits.offset.n.119"},{key:"sgp.kits.offset.n.120"},{key:"sgp.kits.offset.n.121"},{key:"sgp.kits.offset.n.122"},{key:"sgp.kits.offset.n.123"},{key:"sgp.kits.offset.n.124"},{key:"sgp.kits.offset.n.125"},{key:"sgp.kits.offset.n.126"},{key:"sgp.kits.offset.n.127"},{key:"sgp.kits.offset.n.128"},{key:"sgp.kits.offset.n.129"},{key:"sgp.kits.offset.n.130"},{key:"sgp.kits.offset.n.131"},{key:"sgp.kits.offset.n.132"},{key:"sgp.kits.offset.n.133"},{key:"sgp.kits.offset.n.134"},{key:"sgp.kits.offset.n.135"},{key:"sgp.kits.offset.n.136"},{key:"sgp.kits.offset.n.137"},{key:"sgp.kits.offset.n.138"},{key:"sgp.kits.offset.n.139"},{key:"sgp.kits.offset.n.140"},{key:"sgp.kits.offset.n.141"},{key:"sgp.kits.offset.n.142"},{key:"sgp.kits.offset.n.143"},{key:"sgp.kits.offset.n.144"},{key:"sgp.kits.offset.n.145"},{key:"sgp.kits.offset.n.146"},{key:"sgp.kits.offset.n.147"},{key:"sgp.kits.offset.n.148"},{key:"sgp.kits.offset.n.149"},{key:"sgp.kits.offset.n.150"},{key:"sgp.kits.offset.n.151"},{key:"sgp.kits.offset.n.152"},{key:"sgp.kits.offset.n.153"},{key:"sgp.kits.offset.n.154"},{key:"sgp.kits.offset.n.155"},{key:"sgp.kits.offset.n.156"},{key:"sgp.kits.offset.n.157"},{key:"sgp.kits.offset.n.158"},{key:"sgp.kits.offset.n.159"},{key:"sgp.kits.offset.n.160"},{key:"sgp.kits.offset.n.161"},{key:"sgp.kits.offset.n.162"},{key:"sgp.kits.offset.n.163"},{key:"sgp.kits.offset.n.164"},{key:"sgp.kits.offset.n.165"},{key:"sgp.kits.offset.n.166"},{key:"sgp.kits.offset.n.167"},{key:"sgp.kits.offset.n.168"},{key:"sgp.kits.offset.n.169"},{key:"sgp.kits.offset.n.170"},{key:"sgp.kits.offset.n.171"},{key:"sgp.kits.offset.n.172"},{key:"sgp.kits.offset.n.173"},{key:"sgp.kits.offset.n.174"},{key:"sgp.kits.offset.n.175"},{key:"sgp.kits.offset.n.176"},{key:"sgp.kits.offset.n.177"},{key:"sgp.kits.offset.n.178"},{key:"sgp.kits.offset.n.179"},{key:"sgp.kits.offset.n.180"},{key:"sgp.kits.offset.n.181"},{key:"sgp.kits.offset.n.182"},{key:"sgp.kits.offset.n.183"},{key:"sgp.kits.offset.n.184"},{key:"sgp.kits.offset.n.185"},{key:"sgp.kits.offset.n.186"},{key:"sgp.kits.offset.n.187"},{key:"sgp.kits.offset.n.188"},{key:"sgp.kits.offset.n.189"},{key:"sgp.kits.offset.n.190"},{key:"sgp.kits.offset.n.191"},{key:"sgp.kits.offset.n.192"},{key:"sgp.kits.offset.n.193"},{key:"sgp.kits.offset.n.194"},{key:"sgp.kits.offset.n.195"},{key:"sgp.kits.offset.n.196"},{key:"sgp.kits.offset.n.197"},{key:"sgp.kits.offset.n.198"},{key:"sgp.kits.offset.n.199"},{key:"sgp.kits.offset.n.200"},{key:"sgp.kits.offset.n.201"},{key:"sgp.kits.offset.n.202"},{key:"sgp.kits.offset.n.203"},{key:"sgp.kits.offset.n.204"},{key:"sgp.kits.offset.n.205"},{key:"sgp.kits.offset.n.206"},{key:"sgp.kits.offset.n.207"},{key:"sgp.kits.offset.n.208"},{key:"sgp.kits.offset.n.209"},{key:"sgp.kits.offset.n.210"},{key:"sgp.kits.offset.n.211"},{key:"sgp.kits.offset.n.212"},{key:"sgp.kits.offset.n.213"},{key:"sgp.kits.offset.n.214"},{key:"sgp.kits.offset.n.215"},{key:"sgp.kits.offset.n.216"},{key:"sgp.kits.offset.n.217"},{key:"sgp.kits.offset.n.218"},{key:"sgp.kits.offset.n.219"},{key:"sgp.kits.offset.n.220"},{key:"sgp.kits.offset.n.221"},{key:"sgp.kits.offset.n.222"},{key:"sgp.kits.offset.n.223"},{key:"sgp.kits.offset.n.224"},{key:"sgp.kits.offset.n.225"},{key:"sgp.kits.offset.n.226"},{key:"sgp.kits.offset.n.227"},{key:"sgp.kits.offset.n.228"},{key:"sgp.kits.offset.n.229"},{key:"sgp.kits.offset.n.230"},{key:"sgp.kits.offset.n.231"},{key:"sgp.kits.offset.n.232"},{key:"sgp.kits.offset.n.233"},{key:"sgp.kits.offset.n.234"},{key:"sgp.kits.offset.n.235"},{key:"sgp.kits.offset.n.236"},{key:"sgp.kits.offset.n.237"},{key:"sgp.kits.offset.n.238"},{key:"sgp.kits.offset.n.239"},{key:"sgp.kits.offset.n.240"},{key:"sgp.kits.offset.n.241"},{key:"sgp.kits.offset.n.242"},{key:"sgp.kits.offset.n.243"},{key:"sgp.kits.offset.n.244"},{key:"sgp.kits.offset.n.245"},{key:"sgp.kits.offset.n.246"},{key:"sgp.kits.offset.n.247"},{key:"sgp.kits.offset.n.248"},{key:"sgp.kits.offset.n.249"},{key:"sgp.kits.offset.n.250"},{key:"sgp.kits.offset.n.251"},{key:"sgp.kits.offset.n.252"},{key:"sgp.kits.offset.n.253"},{key:"sgp.kits.offset.n.254"},{key:"sgp.kits.offset.n.255"},{key:"sgp.kits.offset.n.256"},{key:"sgp.kits.offset.n.257"},{key:"sgp.kits.offset.n.258"},{key:"sgp.kits.offset.n.259"},{key:"sgp.kits.offset.n.260"},{key:"sgp.kits.offset.n.261"},{key:"sgp.kits.offset.n.262"},{key:"sgp.kits.offset.n.263"},{key:"sgp.kits.offset.n.264"},{key:"sgp.kits.offset.n.265"},{key:"sgp.kits.offset.n.266"},{key:"sgp.kits.offset.n.267"},{key:"sgp.kits.offset.n.268"},{key:"sgp.kits.offset.n.269"},{key:"sgp.kits.offset.n.270"},{key:"sgp.kits.offset.n.271"},{key:"sgp.kits.offset.n.272"},{key:"sgp.kits.offset.n.273"},{key:"sgp.kits.offset.n.274"},{key:"sgp.kits.offset.n.275"},{key:"sgp.kits.offset.n.276"},{key:"sgp.kits.offset.n.277"},{key:"sgp.kits.offset.n.278"},{key:"sgp.kits.offset.n.279"},{key:"sgp.kits.offset.n.280"},{key:"sgp.kits.offset.n.281"},{key:"sgp.kits.offset.n.282"},{key:"sgp.kits.offset.n.283"},{key:"sgp.kits.offset.n.284"},{key:"sgp.kits.offset.n.285"},{key:"sgp.kits.offset.n.286"},{key:"sgp.kits.offset.n.287"},{key:"sgp.kits.offset.n.288"},{key:"sgp.kits.offset.n.289"},{key:"sgp.kits.offset.n.290"},{key:"sgp.kits.offset.n.291"},{key:"sgp.kits.offset.n.292"},{key:"sgp.kits.offset.n.293"},{key:"sgp.kits.offset.n.294"},{key:"sgp.kits.offset.n.295"},{key:"sgp.kits.offset.n.296"},{key:"sgp.kits.offset.n.297"},{key:"sgp.kits.offset.n.298"},{key:"sgp.kits.offset.n.299"},{key:"sgp.kits.offset.n.300"},{key:"sgp.kits.offset.n.301"},{key:"sgp.kits.offset.n.302"},{key:"sgp.kits.offset.n.303"},{key:"sgp.kits.offset.n.304"},{key:"sgp.kits.offset.n.305"},{key:"sgp.kits.offset.n.306"},{key:"sgp.kits.offset.n.307"},{key:"sgp.kits.offset.n.308"},{key:"sgp.kits.offset.n.309"},{key:"sgp.kits.offset.n.310"},{key:"sgp.kits.offset.n.311"},{key:"sgp.kits.offset.n.312"},{key:"sgp.kits.offset.n.313"},{key:"sgp.kits.offset.n.314"},{key:"sgp.kits.offset.n.315"},{key:"sgp.kits.offset.n.316"},{key:"sgp.kits.offset.n.317"},{key:"sgp.kits.offset.n.318"},{key:"sgp.kits.offset.n.319"},{key:"sgp.kits.offset.n.320"},{key:"sgp.kits.offset.n.321"},{key:"sgp.kits.offset.n.322"},{key:"sgp.kits.offset.n.323"},{key:"sgp.kits.offset.n.324"},{key:"sgp.kits.offset.n.325"},{key:"sgp.kits.offset.n.326"},{key:"sgp.kits.offset.n.327"},{key:"sgp.kits.offset.n.328"},{key:"sgp.kits.offset.n.329"},{key:"sgp.kits.offset.n.330"},{key:"sgp.kits.offset.n.331"},{key:"sgp.kits.offset.n.332"},{key:"sgp.kits.offset.n.333"},{key:"sgp.kits.offset.n.334"},{key:"sgp.kits.offset.n.335"},{key:"sgp.kits.offset.n.336"},{key:"sgp.kits.offset.n.337"},{key:"sgp.kits.offset.n.338"},{key:"sgp.kits.offset.n.339"},{key:"sgp.kits.offset.n.340"},{key:"sgp.kits.offset.n.341"},{key:"sgp.kits.offset.n.342"},{key:"sgp.kits.offset.n.343"},{key:"sgp.kits.offset.n.344"},{key:"sgp.kits.offset.n.345"},{key:"sgp.kits.offset.n.346"},{key:"sgp.kits.offset.n.347"},{key:"sgp.kits.offset.n.348"},{key:"sgp.kits.offset.n.349"},{key:"sgp.kits.offset.n.350"},{key:"sgp.kits.offset.n.351"},{key:"sgp.kits.offset.n.352"},{key:"sgp.kits.offset.n.353"},{key:"sgp.kits.offset.n.354"},{key:"sgp.kits.offset.n.355"},{key:"sgp.kits.offset.n.356"},{key:"sgp.kits.offset.n.357"},{key:"sgp.kits.offset.n.358"},{key:"sgp.kits.offset.n.359"},{key:"sgp.kits.offset.n.360"},{key:"sgp.kits.offset.n.361"},{key:"sgp.kits.offset.n.362"},{key:"sgp.kits.offset.n.363"},{key:"sgp.kits.offset.n.364"},{key:"sgp.kits.offset.n.365"},{key:"sgp.kits.offset.n.366"},{key:"sgp.kits.offset.n.367"},{key:"sgp.kits.offset.n.368"},{key:"sgp.kits.offset.n.369"},{key:"sgp.kits.offset.n.370"},{key:"sgp.kits.offset.n.371"},{key:"sgp.kits.offset.n.372"},{key:"sgp.kits.offset.n.373"},{key:"sgp.kits.offset.n.374"},{key:"sgp.kits.offset.n.375"},{key:"sgp.kits.offset.n.376"},{key:"sgp.kits.offset.n.377"},{key:"sgp.kits.offset.n.378"},{key:"sgp.kits.offset.n.379"},{key:"sgp.kits.offset.n.380"},{key:"sgp.kits.offset.n.381"},{key:"sgp.kits.offset.n.382"},{key:"sgp.kits.offset.n.383"},{key:"sgp.kits.offset.n.384"},{key:"sgp.kits.offset.n.385"},{key:"sgp.kits.offset.n.386"},{key:"sgp.kits.offset.n.387"},{key:"sgp.kits.offset.n.388"},{key:"sgp.kits.offset.n.389"},{key:"sgp.kits.offset.n.390"},{key:"sgp.kits.offset.n.391"},{key:"sgp.kits.offset.n.392"},{key:"sgp.kits.offset.n.393"},{key:"sgp.kits.offset.n.394"},{key:"sgp.kits.offset.n.395"},{key:"sgp.kits.offset.n.396"},{key:"sgp.kits.offset.n.397"},{key:"sgp.kits.offset.n.398"},{key:"sgp.kits.offset.n.399"},{key:"sgp.kits.offset.n.400"},{key:"sgp.kits.offset.n.401"},{key:"sgp.kits.offset.n.402"},{key:"sgp.kits.offset.n.403"},{key:"sgp.kits.offset.n.404"},{key:"sgp.kits.offset.n.405"},{key:"sgp.kits.offset.n.406"},{key:"sgp.kits.offset.n.407"},{key:"sgp.kits.offset.n.408"},{key:"sgp.kits.offset.n.409"},{key:"sgp.kits.offset.n.410"},{key:"sgp.kits.offset.n.411"},{key:"sgp.kits.offset.n.412"},{key:"sgp.kits.offset.n.413"},{key:"sgp.kits.offset.n.414"},{key:"sgp.kits.offset.n.415"},{key:"sgp.kits.offset.n.416"},{key:"sgp.kits.offset.n.417"},{key:"sgp.kits.offset.n.418"},{key:"sgp.kits.offset.n.419"},{key:"sgp.kits.offset.n.420"},{key:"sgp.kits.offset.n.421"},{key:"sgp.kits.offset.n.422"},{key:"sgp.kits.offset.n.423"},{key:"sgp.kits.offset.n.424"},{key:"sgp.kits.offset.n.425"},{key:"sgp.kits.offset.n.426"},{key:"sgp.kits.offset.n.427"},{key:"sgp.kits.offset.n.428"},{key:"sgp.kits.offset.n.429"},{key:"sgp.kits.offset.n.430"},{key:"sgp.kits.offset.n.431"},{key:"sgp.kits.offset.n.432"},{key:"sgp.kits.offset.n.433"},{key:"sgp.kits.offset.n.434"},{key:"sgp.kits.offset.n.435"},{key:"sgp.kits.offset.n.436"},{key:"sgp.kits.offset.n.437"},{key:"sgp.kits.offset.n.438"},{key:"sgp.kits.offset.n.439"},{key:"sgp.kits.offset.n.440"},{key:"sgp.kits.offset.n.441"},{key:"sgp.kits.offset.n.442"},{key:"sgp.kits.offset.n.443"},{key:"sgp.kits.offset.n.444"},{key:"sgp.kits.offset.n.445"},{key:"sgp.kits.offset.n.446"},{key:"sgp.kits.offset.n.447"},{key:"sgp.kits.offset.n.448"},{key:"sgp.kits.offset.n.449"},{key:"sgp.kits.offset.n.450"},{key:"sgp.kits.offset.n.451"},{key:"sgp.kits.offset.n.452"},{key:"sgp.kits.offset.n.453"},{key:"sgp.kits.offset.n.454"},{key:"sgp.kits.offset.n.455"},{key:"sgp.kits.offset.n.456"},{key:"sgp.kits.offset.n.457"},{key:"sgp.kits.offset.n.458"},{key:"sgp.kits.offset.n.459"},{key:"sgp.kits.offset.n.460"},{key:"sgp.kits.offset.n.461"},{key:"sgp.kits.offset.n.462"},{key:"sgp.kits.offset.n.463"},{key:"sgp.kits.offset.n.464"},{key:"sgp.kits.offset.n.465"},{key:"sgp.kits.offset.n.466"},{key:"sgp.kits.offset.n.467"},{key:"sgp.kits.offset.n.468"},{key:"sgp.kits.offset.n.469"},{key:"sgp.kits.offset.n.470"},{key:"sgp.kits.offset.n.471"},{key:"sgp.kits.offset.n.472"},{key:"sgp.kits.offset.n.473"},{key:"sgp.kits.offset.n.474"},{key:"sgp.kits.offset.n.475"},{key:"sgp.kits.offset.n.476"},{key:"sgp.kits.offset.n.477"},{key:"sgp.kits.offset.n.478"},{key:"sgp.kits.offset.n.479"},{key:"sgp.kits.offset.n.480"},{key:"sgp.kits.offset.n.481"},{key:"sgp.kits.offset.n.482"},{key:"sgp.kits.offset.n.483"},{key:"sgp.kits.offset.n.484"},{key:"sgp.kits.offset.n.485"},{key:"sgp.kits.offset.n.486"},{key:"sgp.kits.offset.n.487"},{key:"sgp.kits.offset.n.488"},{key:"sgp.kits.offset.n.489"},{key:"sgp.kits.offset.n.490"},{key:"sgp.kits.offset.n.491"},{key:"sgp.kits.offset.n.492"},{key:"sgp.kits.offset.n.493"},{key:"sgp.kits.offset.n.494"},{key:"sgp.kits.offset.n.495"},{key:"sgp.kits.offset.n.496"},{key:"sgp.kits.offset.n.497"},{key:"sgp.kits.offset.n.498"},{key:"sgp.kits.offset.n.499"},{key:"sgp.kits.offset.n.500"},{key:"sgp.kits.offset.n.501"},{key:"sgp.kits.offset.n.502"},{key:"sgp.kits.offset.n.503"},{key:"sgp.kits.offset.n.504"},{key:"sgp.kits.offset.n.505"},{key:"sgp.kits.offset.n.506"},{key:"sgp.kits.offset.n.507"},{key:"sgp.kits.offset.n.508"},{key:"sgp.kits.offset.n.509"},{key:"sgp.kits.offset.n.510"},{key:"sgp.kits.offset.n.511"},{key:"sgp.kits.offset.n.512"},{key:"sgp.kits.offset.n.513"},{key:"sgp.kits.offset.n.514"},{key:"sgp.kits.offset.n.515"},{key:"sgp.kits.offset.n.516"},{key:"sgp.kits.offset.n.517"},{key:"sgp.kits.offset.n.518"},{key:"sgp.kits.offset.n.519"},{key:"sgp.kits.offset.n.520"},{key:"sgp.kits.offset.n.521"},{key:"sgp.kits.offset.n.522"},{key:"sgp.kits.offset.n.523"},{key:"sgp.kits.offset.n.524"},{key:"sgp.kits.offset.n.525"},{key:"sgp.kits.offset.n.526"},{key:"sgp.kits.offset.n.527"},{key:"sgp.kits.offset.n.528"},{key:"sgp.kits.offset.n.529"},{key:"sgp.kits.offset.n.530"},{key:"sgp.kits.offset.n.531"},{key:"sgp.kits.offset.n.532"},{key:"sgp.kits.offset.n.533"},{key:"sgp.kits.offset.n.534"},{key:"sgp.kits.offset.n.535"},{key:"sgp.kits.offset.n.536"},{key:"sgp.kits.offset.n.537"},{key:"sgp.kits.offset.n.538"},{key:"sgp.kits.offset.n.539"},{key:"sgp.kits.offset.n.540"},{key:"sgp.kits.offset.n.541"},{key:"sgp.kits.offset.n.542"},{key:"sgp.kits.offset.n.543"},{key:"sgp.kits.offset.n.544"},{key:"sgp.kits.offset.n.545"},{key:"sgp.kits.offset.n.546"},{key:"sgp.kits.offset.n.547"},{key:"sgp.kits.offset.n.548"},{key:"sgp.kits.offset.n.549"},{key:"sgp.kits.offset.n.550"},{key:"sgp.kits.offset.n.551"},{key:"sgp.kits.offset.n.552"},{key:"sgp.kits.offset.n.553"},{key:"sgp.kits.offset.n.554"},{key:"sgp.kits.offset.n.555"},{key:"sgp.kits.offset.n.556"},{key:"sgp.kits.offset.n.557"},{key:"sgp.kits.offset.n.558"},{key:"sgp.kits.offset.n.559"},{key:"sgp.kits.offset.n.560"},{key:"sgp.kits.offset.n.561"},{key:"sgp.kits.offset.n.562"},{key:"sgp.kits.offset.n.563"},{key:"sgp.kits.offset.n.564"},{key:"sgp.kits.offset.n.565"},{key:"sgp.kits.offset.n.566"},{key:"sgp.kits.offset.n.567"},{key:"sgp.kits.offset.n.568"},{key:"sgp.kits.offset.n.569"},{key:"sgp.kits.offset.n.570"},{key:"sgp.kits.offset.n.571"},{key:"sgp.kits.offset.n.572"},{key:"sgp.kits.offset.n.573"},{key:"sgp.kits.offset.n.574"},{key:"sgp.kits.offset.n.575"},{key:"sgp.kits.offset.n.576"},{key:"sgp.kits.offset.n.577"},{key:"sgp.kits.offset.n.578"},{key:"sgp.kits.offset.n.579"},{key:"sgp.kits.offset.n.580"},{key:"sgp.kits.offset.n.581"},{key:"sgp.kits.offset.n.582"},{key:"sgp.kits.offset.n.583"},{key:"sgp.kits.offset.n.584"},{key:"sgp.kits.offset.n.585"},{key:"sgp.kits.offset.n.586"},{key:"sgp.kits.offset.n.587"},{key:"sgp.kits.offset.n.588"},{key:"sgp.kits.offset.n.589"},{key:"sgp.kits.offset.n.590"},{key:"sgp.kits.offset.n.591"},{key:"sgp.kits.offset.n.592"},{key:"sgp.kits.offset.n.593"},{key:"sgp.kits.offset.n.594"},{key:"sgp.kits.offset.n.595"},{key:"sgp.kits.offset.n.596"},{key:"sgp.kits.offset.n.597"},{key:"sgp.kits.offset.n.598"},{key:"sgp.kits.offset.n.599"},{key:"sgp.kits.offset.n.600"},{key:"sgp.kits.offset.n.601"},{key:"sgp.kits.offset.n.602"},{key:"sgp.kits.offset.n.603"},{key:"sgp.kits.offset.n.604"},{key:"sgp.kits.offset.n.605"},{key:"sgp.kits.offset.n.606"},{key:"sgp.kits.offset.n.607"},{key:"sgp.kits.offset.n.608"},{key:"sgp.kits.offset.n.609"},{key:"sgp.kits.offset.n.610"},{key:"sgp.kits.offset.n.611"},{key:"sgp.kits.offset.n.612"},{key:"sgp.kits.offset.n.613"},{key:"sgp.kits.offset.n.614"},{key:"sgp.kits.offset.n.615"},{key:"sgp.kits.offset.n.616"},{key:"sgp.kits.offset.n.617"},{key:"sgp.kits.offset.n.618"},{key:"sgp.kits.offset.n.619"},{key:"sgp.kits.offset.n.620"},{key:"sgp.kits.offset.n.621"},{key:"sgp.kits.offset.n.622"},{key:"sgp.kits.offset.n.623"},{key:"sgp.kits.offset.n.624"},{key:"sgp.kits.offset.n.625"},{key:"sgp.kits.offset.n.626"},{key:"sgp.kits.offset.n.627"},{key:"sgp.kits.offset.n.628"},{key:"sgp.kits.offset.n.629"},{key:"sgp.kits.offset.n.630"},{key:"sgp.kits.offset.n.631"},{key:"sgp.kits.offset.n.632"},{key:"sgp.kits.offset.n.633"},{key:"sgp.kits.offset.n.634"},{key:"sgp.kits.offset.n.635"},{key:"sgp.kits.offset.n.636"},{key:"sgp.kits.offset.n.637"},{key:"sgp.kits.offset.n.638"},{key:"sgp.kits.offset.n.639"},{key:"sgp.kits.offset.n.640"},{key:"sgp.kits.offset.n.641"},{key:"sgp.kits.offset.n.642"},{key:"sgp.kits.offset.n.643"},{key:"sgp.kits.offset.n.644"},{key:"sgp.kits.offset.n.645"},{key:"sgp.kits.offset.n.646"},{key:"sgp.kits.offset.n.647"},{key:"sgp.kits.offset.n.648"},{key:"sgp.kits.offset.n.649"},{key:"sgp.kits.offset.n.650"},{key:"sgp.kits.offset.n.651"},{key:"sgp.kits.offset.n.652"},{key:"sgp.kits.offset.n.653"},{key:"sgp.kits.offset.n.654"},{key:"sgp.kits.offset.n.655"},{key:"sgp.kits.offset.n.656"},{key:"sgp.kits.offset.n.657"},{key:"sgp.kits.offset.n.658"},{key:"sgp.kits.offset.n.659"},{key:"sgp.kits.offset.n.660"},{key:"sgp.kits.offset.n.661"},{key:"sgp.kits.offset.n.662"},{key:"sgp.kits.offset.n.663"},{key:"sgp.kits.offset.n.664"},{key:"sgp.kits.offset.n.665"},{key:"sgp.kits.offset.n.666"},{key:"sgp.kits.offset.n.667"},{key:"sgp.kits.offset.n.668"},{key:"sgp.kits.offset.n.669"},{key:"sgp.kits.offset.n.670"},{key:"sgp.kits.offset.n.671"},{key:"sgp.kits.offset.n.672"},{key:"sgp.kits.offset.n.673"},{key:"sgp.kits.offset.n.674"},{key:"sgp.kits.offset.n.675"},{key:"sgp.kits.offset.n.676"},{key:"sgp.kits.offset.n.677"},{key:"sgp.kits.offset.n.678"},{key:"sgp.kits.offset.n.679"},{key:"sgp.kits.offset.n.680"},{key:"sgp.kits.offset.n.681"},{key:"sgp.kits.offset.n.682"},{key:"sgp.kits.offset.n.683"},{key:"sgp.kits.offset.n.684"},{key:"sgp.kits.offset.n.685"},{key:"sgp.kits.offset.n.686"},{key:"sgp.kits.offset.n.687"},{key:"sgp.kits.offset.n.688"},{key:"sgp.kits.offset.n.689"},{key:"sgp.kits.offset.n.690"},{key:"sgp.kits.offset.n.691"},{key:"sgp.kits.offset.n.692"},{key:"sgp.kits.offset.n.693"},{key:"sgp.kits.offset.n.694"},{key:"sgp.kits.offset.n.695"},{key:"sgp.kits.offset.n.696"},{key:"sgp.kits.offset.n.697"},{key:"sgp.kits.offset.n.698"},{key:"sgp.kits.offset.n.699"},{key:"sgp.kits.offset.n.700"},{key:"sgp.kits.offset.n.701"},{key:"sgp.kits.offset.n.702"},{key:"sgp.kits.offset.n.703"},{key:"sgp.kits.offset.n.704"},{key:"sgp.kits.offset.n.705"},{key:"sgp.kits.offset.n.706"},{key:"sgp.kits.offset.n.707"},{key:"sgp.kits.offset.n.708"},{key:"sgp.kits.offset.n.709"},{key:"sgp.kits.offset.n.710"},{key:"sgp.kits.offset.n.711"},{key:"sgp.kits.offset.n.712"},{key:"sgp.kits.offset.n.713"},{key:"sgp.kits.offset.n.714"},{key:"sgp.kits.offset.n.715"},{key:"sgp.kits.offset.n.716"},{key:"sgp.kits.offset.n.717"},{key:"sgp.kits.offset.n.718"},{key:"sgp.kits.offset.n.719"},{key:"sgp.kits.offset.n.720"},{key:"sgp.kits.offset.n.721"},{key:"sgp.kits.offset.n.722"},{key:"sgp.kits.offset.n.723"},{key:"sgp.kits.offset.n.724"},{key:"sgp.kits.offset.n.725"},{key:"sgp.kits.offset.n.726"},{key:"sgp.kits.offset.n.727"},{key:"sgp.kits.offset.n.728"},{key:"sgp.kits.offset.n.729"},{key:"sgp.kits.offset.n.730"},{key:"sgp.kits.offset.n.731"},{key:"sgp.kits.offset.n.732"},{key:"sgp.kits.offset.n.733"},{key:"sgp.kits.offset.n.734"},{key:"sgp.kits.offset.n.735"},{key:"sgp.kits.offset.n.736"},{key:"sgp.kits.offset.n.737"},{key:"sgp.kits.offset.n.738"},{key:"sgp.kits.offset.n.739"},{key:"sgp.kits.offset.n.740"},{key:"sgp.kits.offset.n.741"},{key:"sgp.kits.offset.n.742"},{key:"sgp.kits.offset.n.743"},{key:"sgp.kits.offset.n.744"},{key:"sgp.kits.offset.n.745"},{key:"sgp.kits.offset.n.746"},{key:"sgp.kits.offset.n.747"},{key:"sgp.kits.offset.n.748"},{key:"sgp.kits.offset.n.749"},{key:"sgp.kits.offset.n.750"},{key:"sgp.kits.offset.n.751"},{key:"sgp.kits.offset.n.752"},{key:"sgp.kits.offset.n.753"},{key:"sgp.kits.offset.n.754"},{key:"sgp.kits.offset.n.755"},{key:"sgp.kits.offset.n.756"},{key:"sgp.kits.offset.n.757"},{key:"sgp.kits.offset.n.758"},{key:"sgp.kits.offset.n.759"},{key:"sgp.kits.offset.n.760"},{key:"sgp.kits.offset.n.761"},{key:"sgp.kits.offset.n.762"},{key:"sgp.kits.offset.n.763"},{key:"sgp.kits.offset.n.764"},{key:"sgp.kits.offset.n.765"},{key:"sgp.kits.offset.n.766"},{key:"sgp.kits.offset.n.767"},{key:"sgp.kits.offset.n.768"}]

data modify storage sgp:data misc.actionbar.hud.ability_bars set value [{key:"sgp.kits.ability_bar.0",width:11},{key:"sgp.kits.ability_bar.1",width:13},{key:"sgp.kits.ability_bar.2",width:14},{key:"sgp.kits.ability_bar.3",width:16},{key:"sgp.kits.ability_bar.4",width:16},{key:"sgp.kits.ability_bar.5",width:16},{key:"sgp.kits.ability_bar.6",width:16},{key:"sgp.kits.ability_bar.7",width:16},{key:"sgp.kits.ability_bar.8",width:16},{key:"sgp.kits.ability_bar.9",width:16},{key:"sgp.kits.ability_bar.10",width:16},{key:"sgp.kits.ability_bar.11",width:16},{key:"sgp.kits.ability_bar.12",width:16},{key:"sgp.kits.ability_bar.13",width:16},{key:"sgp.kits.ability_bar.14",width:16},{key:"sgp.kits.ability_bar.15",width:16},{key:"sgp.kits.ability_bar.16",width:16},{key:"sgp.kits.ability_bar.17",width:16},{key:"sgp.kits.ability_bar.18",width:16},{key:"sgp.kits.ability_bar.19",width:16},{key:"sgp.kits.ability_bar.20",width:16}]

data modify storage sgp:data misc.actionbar.progress_bar.bars set value [{gold:"",white:"||||||||||||||||||||"},{gold:"|",white:"|||||||||||||||||||"},{gold:"||",white:"||||||||||||||||||"},{gold:"|||",white:"|||||||||||||||||"},{gold:"||||",white:"||||||||||||||||"},{gold:"|||||",white:"|||||||||||||||"},{gold:"||||||",white:"||||||||||||||"},{gold:"|||||||",white:"|||||||||||||"},{gold:"||||||||",white:"||||||||||||"},{gold:"|||||||||",white:"|||||||||||"},{gold:"||||||||||",white:"||||||||||"},{gold:"|||||||||||",white:"|||||||||"},{gold:"||||||||||||",white:"||||||||"},{gold:"|||||||||||||",white:"|||||||"},{gold:"||||||||||||||",white:"||||||"},{gold:"|||||||||||||||",white:"|||||"},{gold:"||||||||||||||||",white:"||||"},{gold:"|||||||||||||||||",white:"|||"},{gold:"||||||||||||||||||",white:"||"},{gold:"|||||||||||||||||||",white:"|"},{gold:"||||||||||||||||||||",white:""}]