class_name CaptainRun
extends StateBase

var run_dust: Dust = null
var can_generate_dust: bool = false
var dust_wait_time: float
var is_creating_dust: bool = false

func enter() -> void:
	character.animation_player.play("run")
	dust_wait_time = 0.5 if state_machine.history_state(2) == "CaptainFall" else 0.1


func physics_update(delta: float) -> void:
	if character.is_hurt:
		transition_to("CaptainHit")
		return
	if character.expect_direction == 0:
		transition_to("CaptainIdle")
		return 
	if character.input_jump and character.is_on_floor():
		transition_to("CaptainJump")
		return
	if not character.is_on_floor():
		transition_to("CaptainFall")
		
	can_generate_dust = true if state_machine.current_state_run_time > dust_wait_time else false
	if can_generate_dust and not is_creating_dust:
		is_creating_dust = true
		run_dust = DustCreater.generete(DustCreater.RUN_DUST, character.graphics, Vector2(-3, 0))

func exit() -> void:
	if is_creating_dust:
		if state_machine.next_state == "CaptainJump":
			run_dust.queue_free()
		else:
			run_dust.free_deferred()
	can_generate_dust = false
	is_creating_dust = false
