#> sgp.kits:abilities/illusions/end

team leave @s

scoreboard players set #nbr_illusions_left sgp.dummy 0

function #bs.link:as_children {run:"execute if entity @s[team=sgp.Illusion] run function sgp.kits:abilities/illusions/remove_illusions"}

function sgp.kits:abilities/illusions/record_destroyed