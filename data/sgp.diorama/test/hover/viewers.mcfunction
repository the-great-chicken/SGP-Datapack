#> sgp.diorama:hover/viewers
# @dummy
# @environment sgp.ci:diorama_hover/viewers

function sgp.ci:diorama_hover/fixture
dummy HoverOther spawn
gamemode survival HoverOther
tag HoverOther add sgp.around_current_model
tp HoverOther ~3.5 ~1 ~1.5 0 0
function sgp.ci:diorama_hover/update
tp @s ~3.5 ~1 ~1.5 180 0
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:1,scale:0.7}
# Spectators cannot keep a selection active.
gamemode spectator HoverOther
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:0,scale:0.55}
dummy HoverOther leave
