#> sgp.mineurs:confinement/damage
#
# Checks for players that are not protected by the specified blocks, and damages them

execute if score #confines_ticks sgp.timer matches 0 \
    as @a[tag=sgp.in_game] at @s \
        unless block ~ ~1 ~ #sgp.mineurs:confinement_invincible \
        unless block ~ ~ ~ #sgp.mineurs:confinement_invincible \
        unless block ~1 ~1 ~ #sgp.mineurs:confinement_invincible \
        unless block ~ ~1 ~1 #sgp.mineurs:confinement_invincible \
        unless block ~ ~1 ~-1 #sgp.mineurs:confinement_invincible \
        unless block ~-1 ~1 ~ #sgp.mineurs:confinement_invincible \
        unless block ~ ~2 ~ #sgp.mineurs:confinement_invincible \
        unless block ~ ~1 ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~ ~ ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~1 ~1 ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~ ~1 ~1 #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~ ~1 ~-1 #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~-1 ~1 ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~ ~2 ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        run title @s title "Rentrez en Intérieur !"

execute if score #confines_ticks sgp.timer matches 0 \
    as @a[tag=sgp.in_game] at @s \
        unless block ~ ~1 ~ #sgp.mineurs:confinement_invincible \
        unless block ~ ~ ~ #sgp.mineurs:confinement_invincible \
        unless block ~1 ~1 ~ #sgp.mineurs:confinement_invincible \
        unless block ~ ~1 ~1 #sgp.mineurs:confinement_invincible \
        unless block ~ ~1 ~-1 #sgp.mineurs:confinement_invincible \
        unless block ~-1 ~1 ~ #sgp.mineurs:confinement_invincible \
        unless block ~ ~2 ~ #sgp.mineurs:confinement_invincible \
        unless block ~ ~1 ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~ ~ ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~1 ~1 ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~ ~1 ~1 #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~ ~1 ~-1 #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~-1 ~1 ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        unless block ~ ~2 ~ #sgp.mineurs:confinement_invincible_waterlogged[waterlogged=true] \
        run damage @s 4 starve