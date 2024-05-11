execute as @a[scores={reset_tags=1}] run function kits:reset_tags
function kits:tag_voulu
scoreboard players set @a[scores={reset_tags=1}] kills_give_1 0
scoreboard players set @a[scores={reset_tags=1}] kills_give_2 0
scoreboard players set @a[scores={reset_tags=1}] kills_give_3 0
scoreboard players set @a[scores={reset_tags=1}] reset_tags 0
scoreboard players set @a[tag=poseidon_a_setup_egapp] kills_give_2 3
tag @a[tag=poseidon_a_setup_egapp] remove poseidon_a_setup_egapp
scoreboard players set @a[tag=vindicateur_a_setup_egapp] kills_give_2 4
tag @a[tag=vindicateur_a_setup_egapp] remove vindicateur_a_setup_egapp