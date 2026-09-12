#> sgp.ci:diorama_markers/cleanup_matching_ids
# Remove only markers owned by this test; never tear down another fixed-arena test.

kill @e[tag=sgp.ci.diorama_markers_matching_ids,type=marker]
