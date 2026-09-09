#> sgp.ci:diorama_transition/scenarios/player_isolation

function sgp.ci:diorama_transition/fixture
dummy DioramaOther spawn
gamemode survival DioramaOther
tp DioramaOther ~2.5 ~1 ~1.5 0 0
scoreboard players set DioramaOther sgp.id 92002
function sgp.ci:diorama_transition/start {x:"~6.5",z:"~6.5",yaw:90,pitch:20}
execute as DioramaOther run function sgp.ci:diorama_transition/start {x:"~8.5",z:"~8.5",yaw:-90,pitch:-15}
function sgp.ci:diorama_transition/advance_16
function sgp.diorama:scale_down_anim/step
function sgp.ci:diorama_transition/expect_arrived {id:92001,x:"~6.5",z:"~6.5",yaw:90000,pitch:20000}
execute as DioramaOther run function sgp.ci:diorama_transition/expect_active {id:92002}
assert score DioramaOther sgp.anim_timer matches 17
execute as DioramaOther run function sgp.ci:diorama_transition/advance_16
execute as DioramaOther run function sgp.diorama:scale_down_anim/step
execute as DioramaOther run function sgp.ci:diorama_transition/expect_arrived {id:92002,x:"~8.5",z:"~8.5",yaw:-90000,pitch:-15000}
dummy DioramaOther leave
