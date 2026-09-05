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

scoreboard objectives add sgp.death_cause dummy
scoreboard objectives add sgp.damage_taken minecraft.custom:minecraft.damage_taken
scoreboard objectives add sgp.damage_owner dummy
scoreboard objectives add sgp.damage_resisted minecraft.custom:minecraft.damage_resisted
scoreboard objectives add sgp.ability_cast dummy
scoreboard objectives add sgp.ability_kind dummy
scoreboard objectives add sgp.ability_success dummy
scoreboard objectives add sgp.last_ability_cast dummy
scoreboard objectives add sgp.ability_result_window dummy
scoreboard objectives add sgp.peck_lock_ticks dummy

scoreboard objectives add sgp.elo dummy
scoreboard objectives add sgp.elo_pending dummy
scoreboard objectives add sgp.elo_encounters dummy
scoreboard objectives add sgp.elo_deaths deathCount
scoreboard objectives add sgp.elo_deaths_seen dummy
scoreboard objectives add sgp.leave_game minecraft.custom:minecraft.leave_game
scoreboard objectives add sgp.leave_seen dummy



# ---------- Create Teams ----------

team add sgp.Illusion
team modify sgp.Illusion collisionRule never



# ---------- Initialize Storages ----------

execute unless data storage sgp:data kits.ability_cooldowns run data merge storage sgp:data {kits:{ability_cooldowns:{assassinate:{cooldown:400s,duration:100s}, bats:{cooldown:400s,duration:100s}, bigger:{cooldown:400s,duration:100s}, cleave:{cooldown:300s}, fangs:{cooldown:260s}, illusions:{cooldown:400s,duration:140s}, pecking:{cooldown:400s}, rays:{cooldown:400s,duration:100s}, repulsion:{cooldown:400s}, smoke_grenade:{cooldown:400s}, tnt:{cooldown:400s}, water_trident:{cooldown:160s}}}}

function sgp.kits:stats_collector/init

data merge storage sgp:kits {\
    kit_id_order:[ \
        {kit_id:0,kit_path:pigeon,ability_path:pecking}, \
        {kit_id:1,kit_path:combattant,ability_path:cleave}, \
        {kit_id:2,kit_path:archer,ability_path:repulsion}, \
        {kit_id:3,kit_path:vindicateur,ability_path:fangs}, \
        {kit_id:4,kit_path:pyromane,ability_path:tnt}, \
        {kit_id:5,kit_path:tank,ability_path:bigger}, \
        {kit_id:6,kit_path:roi,ability_path:rays}, \
        {kit_id:7,kit_path:eclaireur,ability_path:smoke_grenade}, \
        {kit_id:8,kit_path:alchimiste,ability_path:illusions}, \
        {kit_id:9,kit_path:enderman,ability_path:assassinate}, \
        {kit_id:10,kit_path:cancer,ability_path:bats}, \
        {kit_id:11,kit_path:poseidon,ability_path:water_trident} \
    ], \
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
