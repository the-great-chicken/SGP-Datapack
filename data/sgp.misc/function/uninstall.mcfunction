#> sgp.misc:uninstall
# 
# Remove the datapack's data

function sgp.cosmetics:uninstall
function sgp.diorama:uninstall
function sgp.kits:uninstall
function sgp.majeurs:uninstall
function sgp.mineurs:uninstall
function sgp.world:uninstall

# ---------- Remove Objectives ----------

scoreboard objectives remove sgp.id

scoreboard objectives remove sgp.ab.reward_1
scoreboard objectives remove sgp.ab.reward_2
scoreboard objectives remove sgp.ab.reward_3
scoreboard objectives remove sgp.ab.reward_1_width
scoreboard objectives remove sgp.ab.reward_2_width
scoreboard objectives remove sgp.ab.reward_3_width
scoreboard objectives remove sgp.ab.location
scoreboard objectives remove sgp.ab.location_width
scoreboard objectives remove sgp.ab.location_inside
scoreboard objectives remove sgp.ab.hide_hider
scoreboard objectives remove sgp.ab.pco_cabane
scoreboard objectives remove sgp.ab.ability_cooldown
scoreboard objectives remove sgp.ab.ability_cooldown_max
scoreboard objectives remove sgp.ab.ability_cooldown_last_fill
scoreboard objectives remove sgp.ab.ability_cooldown_last_current
scoreboard objectives remove sgp.ab.hud_ability
scoreboard objectives remove sgp.ab.hud_ability_fill
scoreboard objectives remove sgp.ab.normal_width
scoreboard objectives remove sgp.ab.normal_count

scoreboard objectives remove sgp.just_died
scoreboard objectives remove sgp.synthetic_death
scoreboard objectives remove sgp.streak_reset
scoreboard objectives remove sgp.morts

scoreboard objectives remove sgp.kd 
scoreboard objectives remove sgp.plus_grande_streak
scoreboard objectives remove sgp.kills
scoreboard objectives remove sgp.elo_display

scoreboard objectives remove sgp.streak_en_cours

scoreboard objectives remove sgp.dummy
scoreboard objectives remove sgp.timer

scoreboard objectives remove sgp.tab_dirty
scoreboard objectives remove sgp.tab_candidate
scoreboard objectives remove sgp.tab_applied



# ---------- Misc ----------

bossbar remove sgp:lgp
execute as @a run function sgp.misc:actionbar/clear
execute as @e[tag=sgp.marker,name="lieu",type=marker] run function sgp.misc:tab/location/remove_applied_tag_for_all with entity @s data



# ---------- Clear Schedules ----------

schedule clear sgp.misc:scoreboards/cycle_and_clearlag
schedule clear sgp.misc:bossbar/cycle_color
schedule clear sgp.misc:bossbar/cycle_name



# ---------- Remove Storages -----------

data remove storage sgp:text prefix
data remove storage sgp:actionbar_hud overlay
data remove storage sgp:data misc.actionbar
