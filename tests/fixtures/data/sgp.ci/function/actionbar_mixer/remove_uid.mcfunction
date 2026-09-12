#> sgp.ci:actionbar_mixer/remove_uid
# `{stale_uid: Mixer UID}`
# Exact-match removal is safe even when the inherited score no longer has a storage row.

$data remove storage dah:actbar data[{UID:$(stale_uid)}]
