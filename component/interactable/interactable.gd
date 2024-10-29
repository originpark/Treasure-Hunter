class_name Interactable
extends Node2D

@export var animation_sprite: AnimatedSprite2D
@export var interact_area: Area2D
@export var collisition_shape: CollisionShape2D


var shader_material: ShaderMaterial
const outline_shader: Shader = preload("res://resource/shader/outline.gdshader")
const teleport_shader: Shader = preload("res://resource/shader/teleport.gdshader")
const alpha_shader: Shader = preload("res://resource/shader/alpha.gdshader")

var mouse_selected: bool = false

func _ready() -> void:
	interact_area.body_entered.connect(_on_interact_area_body_entered)
	interact_area.body_exited.connect(_on_interact_area_body_exited)
	interact_area.mouse_entered.connect(_on_interact_area_mouse_entered)
	interact_area.mouse_exited.connect(_on_interact_area_mouse_exited)
	shader_material = ShaderMaterial.new()
	
	
	
func _on_interact_area_body_entered(body: Node2D) -> void:
	#print(body.name,  " enter ", self.name)
	var tip := owner.find_child("Tip")
	if tip:
		if not ((tip as Tip).disposable_tip) or not owner.showed: 
			
			#print("找到了tip组件")
			(tip as Tip).tip_in()
	if owner and owner.has_method("do_enter"):
		#if tip and (not disposable_tip or not owner.showed):
			#tip.tip_in()
		owner.do_enter(body)


func _on_interact_area_body_exited(body: Node2D) -> void:
	#print(body.name, " exit ", self.name)
	var tip: Tip
	if owner:
		tip = owner.find_child("Tip")
	if tip:
		if not ((tip as Tip).disposable_tip) or not owner.showed: 
			#print("找到了tip组件")
			owner.showed = true
			(tip as Tip).tip_out()
	if owner and owner.has_method("do_exit"):
		owner.do_exit(body)


func _on_interact_area_mouse_entered() -> void:
	#print("鼠标进入了", owner.name)
	mouse_selected = true
	
func _on_interact_area_mouse_exited() -> void:
	#print("鼠标离开了", owner.name)
	mouse_selected = false
	shader_material.set_shader_parameter("width", 0.0)


func register_outline_shader() -> void:
	shader_material.shader = outline_shader
	animation_sprite.material = shader_material
	
func register_alpha_shader() -> void:
	shader_material.shader = alpha_shader
	animation_sprite.material = shader_material

func regisiter_teleport_shader() -> void:
	shader_material.shader = teleport_shader
	shader_material.set_shader_parameter("progress", 0)
	shader_material.set_shader_parameter("beam_size", 0.05)
	shader_material.set_shader_parameter("color", Vector4(1.0, 0.84, 0.0, 1.0))
	animation_sprite.material = shader_material
