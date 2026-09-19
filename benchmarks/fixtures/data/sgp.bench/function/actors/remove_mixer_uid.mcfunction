#> sgp.bench:actors/remove_mixer_uid
# `{mixer_uid: Actionbar Mixer UID}`
# Exact-match removal is safe even if the referenced row has already disappeared.

$data remove storage dah:actbar data[{UID:$(mixer_uid)}]
