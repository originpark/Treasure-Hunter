class_name Spikes
extends Sprite2D
@onready var stats: Stats = $Stats

var back_power: float = 200.0


func do_enter(body: Node2D) -> void:
	#print("spikes 刺中 ", body.name)
	var back := global_position.direction_to(body.global_position) * back_power
	print("spikes: ", back)
	EffectController.physical_attack(self.stats, body.stats, back)
	

func do_exit(body: Node2D) -> void:
	#print(body.name, "离开spikes")
	pass


func get_back_power() -> float:
	return 200.0
