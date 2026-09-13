#> sgp.diorama:weapon/missing_player_id
# @dummy
# @environment sgp.ci:diorama_weapon/missing_player_id

function sgp.ci:diorama_weapon/fixture
scoreboard players reset @s bs.id
scoreboard players set $link.to bs.in -99123
function sgp.diorama:left_click/on_left_click
assert score @s bs.id matches 1..
assert score $link.to bs.in = @s bs.id
