$execute at @s run summon armor_stand ~ ~20 ~ {CustomName:'[{"text":"sgp.item_stacker"}]',Invulnerable:1b,NoGravity:1b,HandItems:[{id:"$(item_id)",tag:{$(tag)},Count:$(count)}]}
$item replace entity @s $(slot) from entity @e[type=armor_stand,name="sgp.item_stacker",limit=1] weapon.mainhand
kill @e[type=armor_stand,name="sgp.item_stacker",limit=1]