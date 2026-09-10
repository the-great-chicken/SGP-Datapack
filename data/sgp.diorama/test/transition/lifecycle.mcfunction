#> sgp.diorama:transition/lifecycle
# @dummy
# @environment sgp.ci:diorama_transition
#
# The camera transition remains active until its final update, then restores gameplay at the chosen destination.

function sgp.ci:diorama_transition/fixture
function sgp.ci:diorama_transition/start {x:"~6.5",z:"~6.5",yaw:90,pitch:20}
function sgp.ci:diorama_transition/expect_active {id:92001}
assert score @s sgp.anim_timer matches 17
function sgp.ci:diorama_transition/advance_16
function sgp.ci:diorama_transition/expect_active {id:92001}
assert score @s sgp.anim_timer matches 1
function sgp.diorama:scale_down_anim/step
function sgp.ci:diorama_transition/expect_arrived {id:92001,x:"~6.5",z:"~6.5",yaw:90000,pitch:20000}
