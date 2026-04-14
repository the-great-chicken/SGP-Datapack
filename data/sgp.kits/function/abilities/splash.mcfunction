#> sgp.kits:abilities/splash

scoreboard players set @s sgp.cooldown_ability 20

particle splash ~ ~0.5 ~ 0.5 0.5 0.5 0 50
playsound entity.player.splash master @a ~ ~ ~ 1
tellraw @s {text:"Splash",color:blue}