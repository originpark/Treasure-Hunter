extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var shader_material: ShaderMaterial

func _ready() -> void:
	shader_material = (animated_sprite_2d.material) as ShaderMaterial

func _physics_process(delta: float) -> void:
	var progress = shader_material.get_shader_parameter("progress")
	shader_material.set_shader_parameter("progress", progress + 0.005)
