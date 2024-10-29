class_name CannonBall
extends Node2D

var dir: int = -1
var speed: int = 300
var live_time: float = 0.0
var back_power: float = 400.0
@onready var stats: Stats = $Stats

func _physics_process(delta: float) -> void:
	global_position.x += dir * speed * delta
	live_time += delta
	if live_time > 3:
		queue_free()

func do_enter(body: Node2D) -> void:
	print(body.name, " enter ball")
	var back := global_position.direction_to(body.global_position) * back_power
	print("ball: ", back)
	EffectController.physical_attack(self.stats, body.stats, back)


func get_back_power() -> float:
	return 400.0
