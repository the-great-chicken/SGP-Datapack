#> sgp.ci:activation_items/track_drop
# `{UUID: player UUID}`
# Match the same fresh, owned drop that production can select without changing its gameplay tags.

$tag @n[tag=!smithed.entity,distance=..4,nbt={Age:0s,Thrower:$(UUID)},type=item] add sgp.ci.activation_item
