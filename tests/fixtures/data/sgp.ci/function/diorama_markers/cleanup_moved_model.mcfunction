#> sgp.ci:diorama_markers/cleanup_moved_model
# Remove only markers owned by this test; never tear down another fixed-arena test.

kill @e[tag=sgp.ci.diorama_markers_moved_model,type=marker]
