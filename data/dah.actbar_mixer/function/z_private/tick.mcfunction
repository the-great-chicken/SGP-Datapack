#> dah.actbar_mixer:z_private/tick
#
# SGP cadence override for Actionbar Mixer v1.4.
# Minecraft keeps an actionbar message alive for 60 client ticks, so rebuilding and resending every server tick is unnecessary.
# Reuse SGP's existing global alternating-tick score and render at 10 Hz instead of 20 Hz.
#
# All Mixer mutations still happen immediately; only display/prepare is delayed
# by at most one server tick. Keep Mixer's #off behavior unchanged.

execute unless score #off dah.actbar.calc matches 1 if score #even_tick sgp.dummy matches 0 run function dah.actbar_mixer:z_private/display/prepare
