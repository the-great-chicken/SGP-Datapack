execute as @a if score @s sgp.streak_en_cours > @s sgp.plus_grande_streak run scoreboard players operation @s sgp.plus_grande_streak = @s sgp.streak_en_cours
execute as @a[scores={sgp.streak_reset=1..}] run scoreboard players set @s sgp.streak_en_cours 0
execute as @a[scores={sgp.streak_reset=1..}] run scoreboard players set @s sgp.streak_reset 0

team empty sgp.PGSEC
scoreboard players set #highest sgp.streak_en_cours 1
execute as @a if score @s sgp.streak_en_cours > #highest sgp.streak_en_cours run scoreboard players operation #highest sgp.streak_en_cours = @s sgp.streak_en_cours
execute as @a if score @s sgp.streak_en_cours = #highest sgp.streak_en_cours unless predicate sgp.majeurs:event_in_progress run team join sgp.PGSEC @s