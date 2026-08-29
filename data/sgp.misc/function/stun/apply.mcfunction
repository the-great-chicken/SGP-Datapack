#> sgp.misc:stun/apply
# `{duration: int|string}`
#
# Stuns @s for `<duration>` seconds, making them invulnerable
# and unable to deal damage.

$effect give @s slowness $(duration) 100 true
$effect give @s jump_boost $(duration) 200 true
$effect give @s blindness $(duration) 255 true
$effect give @s weakness $(duration) 255 true
$effect give @s resistance $(duration) 255 true
