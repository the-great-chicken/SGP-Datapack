#> sgp.ci:major_schedule/expect
# `{event: pco|hide_and_seek|protect, hour, announcement_hour: 0..23, minute, announcement_minute: 0..59, rounds: positive int}`
#
# Check the configured start, round limit, and the two-minute warning.

$assert score #$(event)_hour sgp.dummy matches $(hour)
$assert score #$(event)_minute sgp.dummy matches $(minute)
$assert score #$(event)_max_rounds sgp.dummy matches $(rounds)
$assert score #$(event)_announcement_hour sgp.dummy matches $(announcement_hour)
$assert score #$(event)_announcement_minute sgp.dummy matches $(announcement_minute)
