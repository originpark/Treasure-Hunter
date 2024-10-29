class_name CaptainHit
extends StateBase


func enter() -> void:
	character.lock_input()
	character.move_lock = true
	character.animation_player.play("hit")
	var hit_origin := character.stats.current_effect_origin
	var back_power: float = 100.0
	if hit_origin.has_method("get_back_power"):
		back_power = hit_origin.get_back_power()
	var back_vec := hit_origin.global_position.direction_to(character.global_position) * back_power
	back_vec.y = -back_vec.y
	character.velocity = back_vec
	#print(back_vec)
	await character.animation_player.animation_finished
	if character.stats.HP == 0:
		character.animation_player.play("dead")
		await character.animation_player.animation_finished
		get_tree().reload_current_scene()
	character.is_hurt = false
	character.unlock_input()
	character.move_lock = false
	transition_to("CaptainIdle")


func physics_update(delta: float) -> void:
	if character.velocity.x != 0:
		character.velocity.x = move_toward(character.velocity.x, 0, 8)
