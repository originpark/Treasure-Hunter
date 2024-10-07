class_name CaptainJump
extends StateBase


func enter() -> void:
	character.animation_player.play("jump")
	character.velocity.y = (character as CaptainClownNose).jump_power
	

func exit() -> void:
	pass
	

func update(delta: float) -> void:
	pass
	

func physics_update(delta: float) -> void:
	if character.velocity.y > 0.0:
		transition_to("CaptainFall")
