class_name HideAble
extends Node

var entered: bool = false
var hided: bool = false

var dir: int
var left_ray_cast: RayCast2D
var right_ray_cast: RayCast2D


func _ready() -> void:
	left_ray_cast = RayCast2D.new()
	right_ray_cast = RayCast2D.new()
	left_ray_cast.position = Vector2(0, -10)
	right_ray_cast.position = Vector2(0, -10)
	left_ray_cast.target_position = Vector2(-30, 0)
	right_ray_cast.target_position = Vector2(30, 0)
	left_ray_cast.set_collision_mask_value(1, false)
	right_ray_cast.set_collision_mask_value(1, false)
	left_ray_cast.set_collision_mask_value(3, true)
	right_ray_cast.set_collision_mask_value(3, true)
	owner.call_deferred("add_child", left_ray_cast)
	owner.call_deferred("add_child", right_ray_cast)
	
	


func _physics_process(delta: float) -> void:
	if owner and owner.body:
		if Input.is_action_just_pressed("enter") and not entered:
			entered = true
			hide()
	if hided:
		#print("成功隐藏")
		dir = Input.get_axis("move_left", "move_right") as int
		(owner as Barrel).velocity.x = dir * owner.move_speed
		(owner.body as BasicCharacter).global_position = owner.global_position
		if Input.is_action_just_pressed("enter"):
			hided = false
			exit()
			entered = false
		
func hide() -> void:
	var character: BasicCharacter
	if owner and (owner.body as BasicCharacter):
		character = owner.body
	else:
		return
	
	character.lock_input()
	character.move_lock = true
	character.expect_direction = 0
	character.set_collision_mask_value(4, false)
	character.animation_player.play("run")
	owner.set_collision_mask_value(1, false)
	var tween := get_tree().create_tween()
	tween.tween_property(character, "global_position:x", owner.global_position.x, 0.5)
	tween = get_tree().create_tween()
	tween.tween_property(character, "modulate:a", 0, 0.5)
	await tween.finished
	hided = true
	Store.user_store.visible = false
	
	
func exit() -> void:
	var character: BasicCharacter
	if owner and (owner.body as BasicCharacter):
		character = owner.body
	else:
		return
		
	if left_ray_cast and not left_ray_cast.is_colliding():
		print("从左边出来")
		print(left_ray_cast.is_colliding())
		character.expect_direction = -1
		var tween := get_tree().create_tween()
		
		tween.tween_property(character, "position:x", owner.global_position.x - 20, 0.5)
		tween = get_tree().create_tween()
		tween.tween_property(character, "modulate:a", 1, 0.5)
		await tween.finished
		character.set_collision_mask_value(4, true)
		owner.set_collision_mask_value(1, true)
		character.unlock_input()
		character.move_lock = false
	elif right_ray_cast and not right_ray_cast.is_colliding():
		print("从右边出来")
		character.expect_direction = 1
		var tween := get_tree().create_tween()
		tween.tween_property(character, "position:x", owner.global_position.x + 20, 0.5)
		tween = get_tree().create_tween()
		tween.tween_property(character, "modulate:a", 1, 0.5)
		await tween.finished
		character.set_collision_mask_value(4, true)
		owner.set_collision_mask_value(1, true)
		character.unlock_input()
		character.move_lock = false
	Store.user_store.visible = true
