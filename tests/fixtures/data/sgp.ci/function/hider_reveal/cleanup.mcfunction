#> sgp.ci:hider_reveal/cleanup
# Cancel reveal-related schedules, clear glow state, and disconnect the fixture roster.

schedule clear sgp.majeurs:hide_and_seek/timer/glow
schedule clear sgp.majeurs:hide_and_seek/timer/glow_announce
function sgp.ci:players/cleanup
