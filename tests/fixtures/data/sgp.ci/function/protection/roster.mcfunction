#> sgp.ci:protection/roster
# Build a survival arena containing the current player and one protected peer.

fill ~ ~ ~ ~12 ~ ~12 stone
fill ~ ~1 ~ ~12 ~5 ~12 air
dummy ProtectPeer spawn
gamemode survival @s
gamemode survival ProtectPeer
tp @s ~2.5 ~1 ~2.5
tp ProtectPeer ~5.5 ~1 ~2.5
