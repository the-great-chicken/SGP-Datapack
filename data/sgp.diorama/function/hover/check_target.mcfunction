#> sgp.diorama:hover/check_target
# Executed as and at one spawn interaction.

# Preserve hover briefly when gaze packets land on the edge of the small hitbox.
scoreboard players remove @s[scores={sgp.hover_time=1..}] sgp.hover_time 1

# Temporarily make this the sole target accepted by the looking_at predicate.
# Functions execute sequentially, so all players contribute to one aggregate result.
tag @s add sgp.hover_candidate
execute if entity @a[tag=sgp.around_current_model,gamemode=!spectator,distance=..20,predicate=sgp.diorama:looking_at_hover_candidate,limit=1] \
    run scoreboard players set @s sgp.hover_time 2
tag @s remove sgp.hover_candidate

# Only touch display NBT when the aggregate state changes.
execute if score @s sgp.hover_time matches 1.. if entity @s[tag=!sgp.spawn_hovered] \
    run function sgp.diorama:hover/grow
execute if score @s sgp.hover_time matches 0 if entity @s[tag=sgp.spawn_hovered] \
    run function sgp.diorama:hover/shrink
