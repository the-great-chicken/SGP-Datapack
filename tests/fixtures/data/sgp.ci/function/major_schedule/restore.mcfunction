#> sgp.ci:major_schedule/restore

$execute store result score #$(event)_hour sgp.dummy run data get storage sgp.ci:major_schedule previous.$(event).hour
$execute store result score #$(event)_minute sgp.dummy run data get storage sgp.ci:major_schedule previous.$(event).minute
$execute store result score #$(event)_max_rounds sgp.dummy run data get storage sgp.ci:major_schedule previous.$(event).rounds
$execute store result score #$(event)_announcement_hour sgp.dummy run data get storage sgp.ci:major_schedule previous.$(event).announcement_hour
$execute store result score #$(event)_announcement_minute sgp.dummy run data get storage sgp.ci:major_schedule previous.$(event).announcement_minute
