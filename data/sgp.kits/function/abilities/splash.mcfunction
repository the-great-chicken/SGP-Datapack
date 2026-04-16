#> sgp.kits:abilities/splash

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.splash.cooldown

particle splash ~ ~0.5 ~ 0.5 0.5 0.5 0 50
playsound entity.player.splash master @a ~ ~ ~ 1
tellraw @s {text:"Splash",color:blue}