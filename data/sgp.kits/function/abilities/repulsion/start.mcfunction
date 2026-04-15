#> sgp.kits:abilities/repulsion/start

scoreboard players set @s sgp.cooldown_ability 400

# Trigger the enchantment (apply_impulse is only available on them)
scoreboard players set @s sgp.trigger_repulsion 1

playsound entity.blaze.shoot master @a ~ ~ ~ 1 1
particle minecraft:sonic_boom ~ ~0.5 ~ 0.2 0.2 0.2 0 10 force @a