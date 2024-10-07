class_name CaptainFall
extends StateBase

var fall_dust: Dust = null


func enter() -> void:
	character.animation_player.play("fall")
	

func exit() -> void:
	fall_dust = DustCreater.generete(DustCreater.FALL_DUST, get_tree().current_scene, character.global_position)
	fall_dust.free_deferred()

func update(delta: float) -> void:
	pass
	

func physics_update(delta: float) -> void:
	if character.is_on_floor():
		transition_to("CaptainIdle")
