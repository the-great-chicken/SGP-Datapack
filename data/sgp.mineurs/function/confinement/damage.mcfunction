#> sgp.mineurs:confinement/damage
#
# Checks for players that are not protected by the specified blocks, and damages them

execute as @a[tag=sgp.in_game] at @s \
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
    run tag @s add sgp.unprotected 
    
title @a[tag=sgp.unprotected] title "Rentrez en Intérieur !"
execute as @a[tag=sgp.unprotected] run damage @s 4 starve

tag @a[tag=sgp.unprotected] remove sgp.unprotected