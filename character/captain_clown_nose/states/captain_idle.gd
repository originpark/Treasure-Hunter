class_name CaptainIdle
extends StateBase


func enter() -> void:
	character.animation_player.play("idle")
	


func physics_update(delta: float) -> void:
	if character.is_hurt:
		transition_to("CaptainHit")
		return
	if character.input_jump and character.is_on_floor():
		transition_to("CaptainJump")
		return
	if character.expect_direction != 0:
		transition_to("CaptainRun")
		return
