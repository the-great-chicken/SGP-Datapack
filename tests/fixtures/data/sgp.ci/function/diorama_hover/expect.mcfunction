#> sgp.ci:diorama_hover/expect
# `{target: first|second, active: 0|1, scale: float}`
#
# Check one button's hover state and the scale of its linked label.

$execute store success score #ci.hover.active sgp.dummy if entity @e[tag=sgp.ci.hover_$(target),tag=sgp.spawn_hovered,distance=..16,type=interaction]
$assert score #ci.hover.active sgp.dummy matches $(active)
$assert entity @e[tag=sgp.ci.hover_$(target),distance=..16,nbt={transformation:{scale:[$(scale)f,$(scale)f,$(scale)f]}},type=text_display]
