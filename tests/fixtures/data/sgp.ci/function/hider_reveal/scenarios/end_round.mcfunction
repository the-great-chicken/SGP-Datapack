#> sgp.ci:hider_reveal/scenarios/end_round

# End the roster while leaving the pending callback intact to test its own guard.
function sgp.ci:hider_reveal/expect_active
team leave @s
team leave RevealSeeker
tag @s remove sgp.major_participant
tag RevealSeeker remove sgp.major_participant
