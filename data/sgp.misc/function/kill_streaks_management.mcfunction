#> sgp.misc:kill_streaks_management
# 
# Updates the highest streak, resets it when the player dies

execute as @a[tag=sgp.in_game] \
    if score @s sgp.streak_en_cours > @s sgp.plus_grande_streak \
        run scoreboard players operation @s sgp.plus_grande_streak = @s sgp.streak_en_cours
        
execute as @a[scores={sgp.streak_reset=1..}] run scoreboard players set @s sgp.streak_en_cours 0
execute as @a[scores={sgp.streak_reset=1..}] run scoreboard players set @s sgp.streak_reset 0