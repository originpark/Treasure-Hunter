class_name BombGuyRun
extends StateBase


func enter() -> void:
	character.animation_player.play("run")

func physics_update(delta: float) -> void:
	if character.expect_direction == 0:
		transition_to("BombGuyIdle")
		return
	if character.is_on_floor() and character.input_jump:
		transition_to("BombGuyJump")
		return	
