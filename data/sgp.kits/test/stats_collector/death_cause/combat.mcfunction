#> sgp.kits:stats_collector/death_cause/combat
# @dummy
#
# Player/mob direct attacks and ordinary projectiles keep their stable analytics ids.

function sgp.ci:death_cause/expect {cause:"player_attack",id:1}
function sgp.ci:death_cause/expect {cause:"mace_smash",id:2}
function sgp.ci:death_cause/expect {cause:"spear",id:3}
function sgp.ci:death_cause/expect {cause:"arrow",id:4}
function sgp.ci:death_cause/expect {cause:"trident",id:5}
function sgp.ci:death_cause/expect {cause:"mob_projectile",id:6}
function sgp.ci:death_cause/expect {cause:"fireball",id:7}
function sgp.ci:death_cause/expect {cause:"wind_charge",id:8}
function sgp.ci:death_cause/expect {cause:"sonic_boom",id:9}
function sgp.ci:death_cause/expect {cause:"fireworks",id:10}
