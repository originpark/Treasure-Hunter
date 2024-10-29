class_name Cannon
extends BasicCharacter


var detected: bool = false
@onready var ray_cast_2d: RayCast2D = $Graphics/RayCast2D
@onready var shot_marker: Marker2D = $ShotMarker

func _physics_process(delta: float) -> void:
	detected = true if ray_cast_2d.is_colliding() else false
