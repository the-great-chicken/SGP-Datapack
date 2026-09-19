
#> sgp.bench:terrain/vertical_stress_lane/build
# Build a reusable high-variance lane relative to an origin at player foot level.
# The intended caster stands at the origin facing +Z. Fangs sample the block
# columns reached around +3..+11 Z; tall columns, deep drops and bottom slabs are
# arranged to force repeated vertical recursion in both staggered fang lanes.

# Start from a deterministic void-over-floor strip.
fill ~-1 ~ ~2 ~1 ~9 ~12 minecraft:air
fill ~-1 ~-1 ~2 ~1 ~-1 ~12 minecraft:bedrock

# Three tall landing columns. Their placement is chosen as a max-transition
# pattern across the two production Fangs lane graphs, forcing 7/8 horizontal
# transitions to climb or descend by many blocks.
fill ~ ~ ~3.5 ~ ~6 ~3.5 minecraft:bedrock
fill ~ ~ ~7.5 ~ ~6 ~7.5 minecraft:bedrock
fill ~ ~ ~10.5 ~ ~5 ~10.5 minecraft:bedrock
setblock ~ ~6 ~10.5 minecraft:stone_slab[type=bottom]

# Low bottom-slab landings exercise the dedicated slab placement branch after
# the preceding high column has recursively descended back to floor level.
setblock ~ ~-1 ~5.5 minecraft:stone_slab[type=bottom]
setblock ~ ~-1 ~8.5 minecraft:stone_slab[type=bottom]
