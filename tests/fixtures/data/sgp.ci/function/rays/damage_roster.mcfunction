#> sgp.ci:rays/damage_roster
# Extend the Rays fixture with near and far survival targets for damage falloff checks.

function sgp.ci:rays/fixture
dummy RayNear spawn
dummy RayFar spawn
gamemode survival RayNear
gamemode survival RayFar
tp RayNear 8.5 88.0 10.5
tp RayFar 8.5 88.0 14.5
