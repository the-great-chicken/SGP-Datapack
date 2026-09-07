#> sgp.ci:major_schedule/expect
# Check the configured start, round limit, and the two-minute warning.

$assert score #$(event)_hour sgp.dummy matches $(hour)
$assert score #$(event)_minute sgp.dummy matches $(minute)
$assert score #$(event)_max_rounds sgp.dummy matches $(rounds)
$assert score #$(event)_announcement_hour sgp.dummy matches $(announcement_hour)
$assert score #$(event)_announcement_minute sgp.dummy matches $(announcement_minute)
