class_name Barrel
extends CharacterBody2D

var body: Node2D = null
static var showed: bool = false
var default_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var interactable: Interactable = $Interactable
var move_speed: float = 60.0

func _ready() -> void:
	interactable.register_outline_shader()

func _physics_process(delta: float) -> void:
	velocity.y += default_gravity * delta
	move_and_slide()

func do_enter(_body: Node2D) -> void:
	#print(_body.name, " enter")
	self.body = _body

func do_exit(_body: Node2D) -> void:
	#print(_body.name, " exit")
	self.body = null


func disable() -> void:
	interactable.register_alpha_shader()
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	#(interactable.interact_area.get_child(0) as CollisionShape2D).disabled = true
	
func enable() -> void:
	interactable.register_outline_shader()
	interactable.animation_sprite.material.set_shader_parameter("color", Vector4(1, 1, 1, 1))
	process_mode = ProcessMode.PROCESS_MODE_INHERIT
	(interactable.interact_area.get_child(0) as CollisionShape2D).disabled = false
