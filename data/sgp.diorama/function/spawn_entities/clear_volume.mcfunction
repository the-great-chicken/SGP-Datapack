# Zero-size displays on a volume boundary fail bounding-box selectors; remove each button's linked label instead.
$execute as @e[tag=sgp.spawn_tper,dx=$(mdx),dy=$(mdy),dz=$(mdz),type=interaction] at @s run function sgp.diorama:spawn_entities/remove_button
