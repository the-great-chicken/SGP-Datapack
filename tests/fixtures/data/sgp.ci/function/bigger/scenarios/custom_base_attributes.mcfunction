#> sgp.ci:bigger/scenarios/custom_base_attributes

function sgp.ci:bigger/fixture
attribute @s minecraft:scale base set 0.75
attribute @s minecraft:jump_strength base set 0.6
attribute @s minecraft:entity_interaction_range base set 4
attribute @s minecraft:attack_damage base set 3
function sgp.kits:abilities/bigger/apply
function sgp.ci:bigger/expect {scale:"149999..150001",jump:"74999..75001",reach:"599999..600001",damage:"599999..600001"}
function sgp.kits:abilities/bigger/end
function sgp.ci:bigger/expect {scale:"74999..75001",jump:"59999..60001",reach:"399999..400001",damage:"299999..300001"}
