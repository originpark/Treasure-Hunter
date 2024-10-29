class_name BombGuyGround
extends StateBase

func enter() -> void:
	character.animation_player.play("ground")
	await character.animation_player.animation_finished
	transition_to("BombGuyIdle")
