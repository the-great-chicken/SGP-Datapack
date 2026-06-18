#> sgp.misc:actionbar/reward
# `{id: string, slot: [1,2,3], text: json_text_component, width: int}`
#
# Shows or refreshes one kill-reward actionbar segment and declares its
# approximate normal-actionbar width for the fixed HUD overlay compensation.
#
# Kill rewards intentionally use several segment ids, one per reward slot,
# so cumulative threshold rewards do not need to guess and rewrite each other.

$data modify storage dah:actbar new set value {id:"$(id)", order:10$(slot), text:$(text)}
function dah.actbar_mixer:new/update_id
$scoreboard players set @s sgp.ab.reward_$(slot) 50
$scoreboard players set @s sgp.ab.reward_$(slot)_width $(width)
