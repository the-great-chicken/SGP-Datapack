#> sgp.ci:rays_far/damage_roster
# Extend the far Rays fixture with survival targets on the south beam and near the east beam's reach limit.

function sgp.ci:rays_far/fixture
dummy RayNear spawn
dummy RayFar spawn
gamemode survival RayNear
gamemode survival RayFar
tp RayNear 1008.5 88.0 1010.5
tp RayFar 1024.6 88.0 1008.5
