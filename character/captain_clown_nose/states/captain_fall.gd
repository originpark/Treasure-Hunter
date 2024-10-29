class_name CaptainFall
extends StateBase

const COYOTE_TIME: float = 0.1

var fall_dust: Dust = null
var can_coyote_jump: bool = false


func enter() -> void:
	character.animation_player.play("fall")
	if state_machine.history_state(1) == "CaptainRun":
		can_coyote_jump = true
		get_tree().create_timer(COYOTE_TIME).timeout.connect(on_coyote_timer_time_out)
	

func exit() -> void:
	fall_dust = DustCreater.generete(DustCreater.FALL_DUST, get_tree().current_scene, character.global_position)
	fall_dust.free_deferred()
	

func update(delta: float) -> void:
	pass
	

func physics_update(delta: float) -> void:
	if character.is_hurt:
		transition_to("CaptainHit")
		return
	if character.is_on_floor():
		transition_to("CaptainIdle")
		return
	if can_coyote_jump and character.input_jump:
		transition_to("CaptainJump")
		return
		


func on_coyote_timer_time_out() -> void:
	can_coyote_jump = false
