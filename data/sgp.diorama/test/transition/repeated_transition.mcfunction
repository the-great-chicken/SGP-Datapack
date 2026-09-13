#> sgp.diorama:transition/repeated_transition
# @dummy
# @environment sgp.ci:diorama_transition/repeated_transition
#
# A later transition for the same player uses the new destination without leaving extra cameras or targets.

function sgp.ci:diorama_transition/fixture
function sgp.ci:diorama_transition/start {x:"~6.5",z:"~6.5",yaw:90,pitch:20}
function sgp.ci:diorama_transition/advance_16
function sgp.diorama:scale_down_anim/step
function sgp.ci:diorama_transition/expect_arrived {id:92001,x:"~6.5",z:"~6.5",yaw:90000,pitch:20000}
function sgp.ci:diorama_transition/start {x:"~3.5",z:"~4.5",yaw:-45,pitch:0}
function sgp.ci:diorama_transition/expect_active {id:92001}
assert score @s sgp.anim_timer matches 17
function sgp.ci:diorama_transition/advance_16
function sgp.diorama:scale_down_anim/step
function sgp.ci:diorama_transition/expect_arrived {id:92001,x:"~3.5",z:"~4.5",yaw:-45000,pitch:0}
