class_name CaptainJump
extends StateBase

var jump_dust: Dust = null


func enter() -> void:
	character.animation_player.play("jump")
	character.velocity.y = (character as CaptainClownNose).jump_power
	jump_dust = DustCreater.generete(DustCreater.JUMP_DUST, get_tree().current_scene, character.global_position)
	

func exit() -> void:
	jump_dust.free_deferred()
	

func update(delta: float) -> void:
	pass
	

func physics_update(delta: float) -> void:
	if character.is_hurt:
		transition_to("CaptainHit")
		return
	if character.velocity.y > 0.0:
		transition_to("CaptainFall")
		return
	if character.is_on_floor():
		transition_to("CaptainIdle")
		return
