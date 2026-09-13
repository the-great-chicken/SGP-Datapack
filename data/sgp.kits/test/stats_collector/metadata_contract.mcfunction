#> sgp.kits:stats_collector/metadata_contract
# @dummy
# @environment sgp.ci:stats_collector
#
# Runtime metadata exposes the schema and units consumed by the stats exporter.

assert data storage sgp.kits:stats {schema_version:7}
assert data storage sgp.kits:stats death_position_metadata{stored_unit:"block_tenths",display_unit:"blocks",display_scale:0.1d,quantization:"floor",position_reference:"feet"}
assert data storage sgp.kits:stats damage_cause_names{"1":"player_attack","14":"explosion","18":"fall","100":"giant_sweep","101":"pecking","102":"ray"}
assert data storage sgp.kits:stats elo_metadata{initial_rating:1000.0d,k_factor:80.0d,rating_divisor:1050.0d}
assert data storage sgp.kits:stats elo_metadata{k_factor_schedule:[{minimum_average_encounters:0,k_factor:80.0d},{minimum_average_encounters:25,k_factor:50.0d},{minimum_average_encounters:75,k_factor:30.0d},{minimum_average_encounters:150,k_factor:18.0d}]}
