class_name BombGuyFall
extends StateBase

func enter() -> void:
	character.animation_player.play("fall")
	
	
func physics_update(delta: float) -> void:
	if character.is_on_floor():
		transition_to("BombGuyGround")
		return
