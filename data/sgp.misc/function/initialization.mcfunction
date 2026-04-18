#> sgp.misc:initialization
# 
# Create the necessary objectives, initialize values, create teams,...

# ---------- Create Objectives ----------
scoreboard objectives add sgp.reward trigger
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


execute as @e[type=marker,tag=sgp.marker,name="lieu"] run function sgp.misc:scoreboards/initialization_lieux with entity @s data

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

scoreboard objectives add sgp.teleporteur dummy
scoreboard objectives add sgp.dummy dummy
scoreboard objectives add sgp.timer dummy

scoreboard objectives add sgp.lieu_count dummy



# ---------- Initialize values ----------
scoreboard players set #ench_particle sgp.dummy 0
scoreboard players set #flame_crown_particle sgp.dummy 0
scoreboard players set 0 sgp.dummy 0
scoreboard players set 1 sgp.dummy 1
scoreboard players set 2 sgp.dummy 2
scoreboard players set 3 sgp.dummy 3
scoreboard players set 4 sgp.dummy 4
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
scoreboard players set #even_tick sgp.dummy 0
scoreboard players set #20_ticks sgp.dummy 0
scoreboard players set #128_ticks_clock sgp.dummy 0
scoreboard players set #52_ticks_clock sgp.dummy 0
scoreboard players set #bossbar_color sgp.dummy 0
scoreboard players set #bossbar_name sgp.dummy 0
scoreboard players set #scoreboard_and_clearlag sgp.dummy 0

scoreboard players set #confines_ticks sgp.timer 0
scoreboard players set #confines_secondes sgp.timer 0

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

# Misc
bossbar add sgp:lgp "a"
forceload add 0 0
summon marker 0 0 0 {Tags:["sgp.predictor"]}



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

data merge storage sgp:data {majeurs:{pco:{event:"pco",text:"Poule Canard Oie"},ptk:{event:"ptk",text:"Protéger le Roi"},hide_and_seek:{event:"hide_and_seek",text:"Cache-cache",end:{seeker:"Que la chasse à la volaille commence !",hider:"Les chasseurs arrivent, gare à vos fesses !",become_seeker:"Vous pouvez chasser de la volaille à votre tour !"}}},"mineurs":{}}

data merge storage sgp:kits {\
    eclaireur:{kit: eclaireur, kit_color:aqua, kit_name:"Éclaireur"}, \
    enderman:{kit:enderman, kit_color:dark_purple, kit_name:Enderman}, \
    pigeon:{kit:pigeon, kit_color:dark_gray, kit_name:Pigeon}, \
    poseidon:{kit:poseidon, kit_color:dark_aqua, kit_name:"Poséidon"}, \
    pyromane:{kit:pyromane, kit_color:gold, kit_name:Pyromane}, \
    roi:{kit:roi, kit_color:yellow, kit_name:Roi}, tank:{kit:tank, kit_color:dark_blue, kit_name:Tank}, \
    cancer:{kit:cancer, kit_color:dark_red, kit_name:Cancer}, \
    alchimiste:{kit:alchimiste, kit_color:light_purple, kit_name:Alchimiste}, \
    combattant:{kit:combattant, kit_color:white, kit_name:Combattant}, \
    archer:{kit:archer, kit_color:green, kit_name:Archer}, \
    vindicateur:{kit:vindicateur, kit_color:dark_green, kit_name:Vindicateur} \
    }

data modify storage sgp.text prefix set value {text:"[", color:gray, extra:[{text:"SGP", color:gold}, {text:"] "}]}