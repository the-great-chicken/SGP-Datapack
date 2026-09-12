#> sgp.mineurs:selection/conflicts
#
# Resolving one conflict must not create another with earlier picks or the previous round, including across seven-to-one wraparound.

function sgp.ci:minor_events/check_choice {nbr:1,roll:2,first:0,second:0,previous_count:3,previous_first:2,previous_second:3,previous_third:4}
function sgp.ci:minor_events/check_choice {nbr:2,roll:7,first:1,second:0,previous_count:1,previous_first:7,previous_second:0,previous_third:0}
function sgp.ci:minor_events/check_choice {nbr:3,roll:2,first:3,second:2,previous_count:1,previous_first:7,previous_second:0,previous_third:0}
function sgp.ci:minor_events/check_choice {nbr:3,roll:7,first:1,second:3,previous_count:3,previous_first:7,previous_second:2,previous_third:4}
function sgp.ci:minor_events/check_choice {nbr:3,roll:5,first:4,second:6,previous_count:3,previous_first:5,previous_second:7,previous_third:1}
function sgp.ci:minor_events/check_choice {nbr:1,roll:5,first:0,second:0,previous_count:1,previous_first:2,previous_second:5,previous_third:6}
