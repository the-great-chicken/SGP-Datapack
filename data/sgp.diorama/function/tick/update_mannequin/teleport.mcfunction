#> sgp.diorama:tick/update_mannequin/teleport
# `{x, y, z, h, v}`: absolute position and rotation of the executing mannequin.
# One macro line and one teleport instead of #bs.position:set_pos_and_rot, which re-parsed
# two macro functions (their arguments differ for every mannequin every tick) and
# teleported twice. Relative coordinates from 0.0 0.0 0.0: a whole double such as 9.0d is
# inserted as `9`, which an absolute `tp` would centre to 9.5.
$execute positioned 0.0 0.0 0.0 positioned ~$(x) ~$(y) ~$(z) rotated $(h) $(v) run tp @s ~ ~ ~ ~ ~
