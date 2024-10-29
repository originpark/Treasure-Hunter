class_name BombGuy
extends BasicCharacter

@export var run_speed: float = 110.0
@export var walk_speed: float = 70.0
@export var jump_power: float = -294.0


func _ready() -> void:
	super()
	current_move_speed = run_speed
