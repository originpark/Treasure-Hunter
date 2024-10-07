class_name CaptainRun
extends StateBase


func enter() -> void:
	character.animation_player.play("run")



func physics_update(delta: float) -> void:
	if character.expect_direction == 0:
		transition_to("CaptainIdle")
	if character.input_jump and character.is_on_floor():
		transition_to("CaptainJump")
