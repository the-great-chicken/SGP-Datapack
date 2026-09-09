#> sgp.ci:diorama_spawns/label
# {title}
# Executed as one button: its linked label must describe that button, even at overlapping coordinates.
scoreboard players operation $link.to bs.in = @s bs.id
$assert entity @e[tag=sgp.spawn_tper_text,predicate=bs.link:link_equal,nbt={text:{text:"$(title)"}},type=text_display]
assert data entity @n[tag=sgp.spawn_tper_text,predicate=bs.link:link_equal,type=text_display] text.extra[0]
