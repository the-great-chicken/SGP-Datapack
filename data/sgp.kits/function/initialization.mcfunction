#> sgp.kits:initialization

# ---------- Create Objectives ----------

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

scoreboard objectives add sgp.kills_give_1 playerKillCount
scoreboard objectives add sgp.kills_give_2 playerKillCount
scoreboard objectives add sgp.kills_give_3 playerKillCount

scoreboard objectives add sgp.kit_id dummy
scoreboard objectives add sgp.kit_prefix_set dummy
scoreboard objectives add sgp.reset_tags dummy

scoreboard objectives add sgp.last_kill_count playerKillCount



# ---------- Create Teams ----------

team add sgp.Illusion
team modify sgp.Illusion collisionRule never



# ---------- Misc ----------

function sgp.kits:kit_tags/init_luckperms



# ---------- Start Schedules ----------

function sgp.kits:kit_tags/prefixes_check



# ---------- Initialize Storages ----------

data merge storage sgp.kits:stats {kits_dict:{}}

execute unless data storage sgp:data kits.ability_cooldowns run data merge storage sgp:data {kits:{ability_cooldowns:{assassinate:{cooldown:400s,duration:100s}, bats:{cooldown:400s,duration:100s}, bigger:{cooldown:400s,duration:100s}, cleave:{cooldown:300s}, fangs:{cooldown:260s}, illusions:{cooldown:400s,duration:140s}, pecking:{cooldown:400s}, rays:{cooldown:400s,duration:100s}, repulsion:{cooldown:400s}, smoke_grenade:{cooldown:400s}, tnt:{cooldown:400s}, water_trident:{cooldown:160s}, splash:{cooldown:20s}}}}

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