#> sgp.ci:bigger/scenarios/other_modifiers

function sgp.ci:bigger/fixture
attribute @s minecraft:scale modifier add sgp.ci:bigger_other 0.5 add_value
attribute @s minecraft:jump_strength modifier add sgp.ci:bigger_other 0.08 add_value
attribute @s minecraft:entity_interaction_range modifier add sgp.ci:bigger_other 1 add_value
attribute @s minecraft:attack_damage modifier add sgp.ci:bigger_other 3 add_value
function sgp.kits:abilities/bigger/apply
function sgp.ci:bigger/expect {scale:"299999..300001",jump:"62499..62501",reach:"599999..600001",damage:"799999..800001"}
function sgp.kits:abilities/bigger/end
function sgp.ci:bigger/expect {scale:"149999..150001",jump:"49999..50001",reach:"399999..400001",damage:"399999..400001"}
