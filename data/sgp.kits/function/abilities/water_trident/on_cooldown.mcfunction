#> sgp.kits:abilities/water_trident/on_cooldown

# Don't allow the player to throw his trident
item modify entity @s weapon.mainhand sgp.kits:add_riptide

function sgp.kits:abilities/display_cooldown {type:cooldown_water_trident, every:8}