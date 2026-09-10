#> sgp.diorama:cleanup/leave_giant
# @dummy
# @environment sgp.ci:diorama_cleanup/leave_giant

function sgp.ci:diorama_cleanup/fixture
function sgp.ci:diorama_cleanup/expect_present {group:giant}
function sgp.diorama:tick/update_mannequin/disappear {type:giant,id:95001}
assert not entity @s[tag=sgp.has_giant_mannequin_95001]
assert entity @s[tag=sgp.has_small_mannequin_95001,tag=sgp.has_small_mannequin_95002]
function sgp.ci:diorama_cleanup/expect_removed {group:giant}
function sgp.ci:diorama_cleanup/expect_present {group:small}
function sgp.ci:diorama_cleanup/expect_present {group:other_owner}
function sgp.ci:diorama_cleanup/expect_present {group:other_map}
