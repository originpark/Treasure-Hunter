class_name CaptainIdle
extends StateBase


func enter() -> void:
	character.animation_player.play("idle")
	


func physics_update(delta: float) -> void:
	if character.expect_direction != 0:
		transition_to("CaptainRun")
	if character.input_jump and character.is_on_floor():
		transition_to("CaptainJump")
