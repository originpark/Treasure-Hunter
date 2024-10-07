class_name CaptainClownNose
extends BasicCharacter


@export var run_speed: float = 120.0
@export var jump_power: float = -294.0


func _ready() -> void:
	super()
	current_move_speed = run_speed
	unlock_input()
