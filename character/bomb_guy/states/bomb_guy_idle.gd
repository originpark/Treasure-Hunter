class_name BombGuyIdle
extends StateBase


func enter() -> void:
	character.animation_player.play("idle")

func physics_update(delta: float) -> void:
	if character.is_on_floor() and character.input_jump:
		transition_to("BombGuyJump")
		return	
	if character.expect_direction != 0:
		transition_to("BombGuyRun")
		return
