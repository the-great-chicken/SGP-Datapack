#> sgp.mineurs:magic/spells
# @dummy
#
# Each possible roll gives its advertised spell rather than reusing the previous spell.

tag @s add sgp.in_game
function sgp.ci:minor_events/check_magic {roll:1,effect:"absorption",amplifier:4}
function sgp.ci:minor_events/check_magic {roll:2,effect:"fire_resistance",amplifier:2}
function sgp.ci:minor_events/check_magic {roll:3,effect:"wither",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:4,effect:"health_boost",amplifier:1}
function sgp.ci:minor_events/check_magic {roll:5,effect:"hunger",amplifier:1}
function sgp.ci:minor_events/check_magic {roll:6,effect:"invisibility",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:7,effect:"jump_boost",amplifier:1}
function sgp.ci:minor_events/check_magic {roll:8,effect:"levitation",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:9,effect:"nausea",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:10,effect:"darkness",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:11,effect:"poison",amplifier:1}
function sgp.ci:minor_events/check_magic {roll:12,effect:"regeneration",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:13,effect:"resistance",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:14,effect:"slow_falling",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:15,effect:"slowness",amplifier:1}
function sgp.ci:minor_events/check_magic {roll:16,effect:"speed",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:17,effect:"strength",amplifier:0}
function sgp.ci:minor_events/check_magic {roll:18,effect:"weakness",amplifier:0}
