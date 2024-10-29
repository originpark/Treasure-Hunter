class_name PushAble
extends Node

var is_pushed: bool = false



func _physics_process(delta: float) -> void:
	check()
	if not is_pushed:
		owner.velocity.x = move_toward(owner.velocity.x, 0, 1000 * delta)  # 使用较大的衰减值加速停止


func check() -> void:
	var body
	if owner.body:
		body = owner.body
	# 检查 body 是否有效以及为 BasicCharacter 类型
	if not body or body is not BasicCharacter:
		is_pushed = false
		return

	var character = body as BasicCharacter

	# 检查是否在推动并且未撞墙
	if character.input_push and not owner.is_on_wall():
		var dir := 1 if character.global_position.x - self.owner.global_position.x < 0 else -1
		if dir == character.expect_direction:
			owner.velocity.x = character.expect_direction * character.push_force
			is_pushed = true
			return
	else:
		is_pushed = false
