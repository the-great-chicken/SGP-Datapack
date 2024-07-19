#> sgp.kits:stacking/set_stack
# `{count, item_id, tag: item_nbt, slot: hotbar.0-8 or inventory.0-26 or offhand}`
# 
# Sets `<count>` `<item_id>` with `<item_nbt>` in the slot

$execute at @s run summon armor_stand ~ ~20 ~ {CustomName:'[{"text":"sgp.item_stacker"}]',Invulnerable:1b,NoGravity:1b,HandItems:[{id:"$(item_id)",component:{$(tag)},Count:$(count)}]}
$item replace entity @s $(slot) from entity @n[type=armor_stand,name="sgp.item_stacker"] weapon.mainhand
kill @n[type=armor_stand,name="sgp.item_stacker"]