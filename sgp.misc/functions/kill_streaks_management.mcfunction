execute as @a if score @s streak_en_cours > @s plus_grande_streak run scoreboard players operation @s plus_grande_streak = @s streak_en_cours
execute as @a[scores={streak_reset=1..}] run scoreboard players set @s streak_en_cours 0
execute as @a[scores={streak_reset=1..}] run scoreboard players set @s streak_reset 0

team empty PGSEC
scoreboard players set #highest streak_en_cours 1
execute as @a if score @s streak_en_cours > #highest streak_en_cours run scoreboard players operation #highest streak_en_cours = @s streak_en_cours
execute as @a if score @s streak_en_cours = #highest streak_en_cours unless predicate sgp.majeurs:event_in_progress run team join PGSEC @s