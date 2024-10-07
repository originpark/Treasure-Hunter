class_name CaptainFall
extends StateBase


func enter() -> void:
	character.animation_player.play("fall")
	

func exit() -> void:
	pass
	

func update(delta: float) -> void:
	pass
	

func physics_update(delta: float) -> void:
	if character.is_on_floor():
		transition_to("CaptainIdle")
