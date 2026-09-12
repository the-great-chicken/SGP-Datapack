#> sgp.diorama:cleanup/death_cleanup
# @dummy
# @environment sgp.ci:diorama_cleanup/death_cleanup

function sgp.ci:diorama_cleanup/fixture
dummy CleanupOther spawn
gamemode survival CleanupOther
tag CleanupOther add sgp.has_small_mannequin_95001
tag CleanupOther add sgp.has_giant_mannequin_95001
# Establish the diorama portion of on_death's context, without invoking stats collection.
scoreboard players operation $link.to bs.in = @s bs.id
tag @s add sgp.diorama_death_cleanup
function sgp.diorama:tick/update_mannequin/remove {id:95001}
tag @s remove sgp.diorama_death_cleanup
assert not entity @s[tag=sgp.has_small_mannequin_95001]
assert not entity @s[tag=sgp.has_giant_mannequin_95001]
assert entity @s[tag=sgp.has_small_mannequin_95002]
assert entity @a[name=CleanupOther,tag=sgp.has_small_mannequin_95001,tag=sgp.has_giant_mannequin_95001]
function sgp.ci:diorama_cleanup/expect_removed {group:small}
function sgp.ci:diorama_cleanup/expect_removed {group:giant}
function sgp.ci:diorama_cleanup/expect_present {group:other_owner}
function sgp.ci:diorama_cleanup/expect_present {group:other_map}
dummy CleanupOther leave

# Keep this test chunk loaded until killed mannequins leave their transient DYING pose.
function sgp.ci:diorama_cleanup/retire
await delay 21t
assert not entity @e[tag=sgp.ci.removal,type=mannequin]
assert not entity @e[tag=sgp.ci.removal,type=text_display]
