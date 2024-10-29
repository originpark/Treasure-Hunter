class_name BombGuyJump
extends StateBase

func enter() -> void:
	character.animation_player.play("jump_anticipation")
	await character.animation_player.animation_finished
	character.animation_player.play("jump")
	character.velocity.y = (character as BombGuy).jump_power

func physics_update(delta: float) -> void:
	if character.velocity.y > 0.0:
		transition_to("BombGuyFall")
		return
