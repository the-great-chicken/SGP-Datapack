#> sgp.kits:abilities/give_back_item
#
# Gives the item back with /loot give, making it go automatically in the right stack

item replace block ~ ~ ~ container.0 from entity @s contents
loot give @s mine ~ ~ ~
item replace block ~ ~ ~ container.0 with air